<%@ Control Language="vb" debug="true"%>
<%@ Import Namespace="System.Data" %>
<script runat="server">

Public dbConnection as object
Public dbDialect as String
Protected dbVersion as String
Protected dbClassName as String
Public offset as integer = 0
Public numrows as integer = 1999
Public AllRowsMax as integer = 1999  ' max # of rows to send if numrows=-1
Public gettotal as Boolean = true
Public distinctCol as integer = -1
Public filters as ArrayList
Public orderByRef = false     ' use column numbers in order by clause? (true/false)
Public Wildcard as String="%"
Public oParse as object       ' parsed sql select statement to execute
Public sqlText as String      ' sql query to execute (either oParse or sqlText must be set prior to rendering)
Public ErrorMsg as String     ' may contain the text of an error message that occurred outside this control prior to rendering
Public HeaderRows as new ArrayList()  ' data that will be inserted before the query results
Public FooterRows as new ArrayList()  ' data that will be appended after the query results
Protected command as object

' DEBUGGING CONTROL
Public sendDebugMsgs = false   ' send details of sql parsing/execution in ajax response? (true/false)
Public LogSqlOnError = false   ' include sql statement in results if an error occurs (true/false)
Protected DebugMsgs as new ArrayList()

Protected Overrides Sub Render(writer as HTMLTextWriter)
  Dim SqlRows as integer=0
  if not IsNothing(ErrorMsg) then
    writer.Write("<rows update_ui='false' /><error>" & server.htmlencode(ErrorMsg) & "</error>")
  elseif IsNothing(dbConnection) and (not IsNothing(oParse) or not IsNothing(sqlText)) then
    writer.Write("<rows update_ui='false' /><error>No database connection</error>")
  else
    writer.WriteLine("<rows update_ui='true' offset='" & offset & "'")
    if distinctCol >= 0 then writer.Write(" distinct='" & distinctCol & "'")
    writer.Write(">")
    try
      writer.WriteLine(join(HeaderRows.ToArray(),vbLf))
      if not IsNothing(dbConnection) then
        SqlRows=RenderQueryRows(writer)
      end if
      writer.WriteLine(join(FooterRows.ToArray(),vbLf))
      writer.WriteLine("</rows>")
      if SqlRows >= 0 then
        writer.WriteLine("<rowcount>" & CStr(SqlRows+HeaderRows.count+FooterRows.count) & "</rowcount>")
      end if
      if sendDebugMsgs then
        dim i as Integer
        for i=0 to DebugMsgs.count-1
          writer.WriteLine("<debug>" & server.HTMLencode(DebugMsgs(i)) & "</debug>")
        next
      end if
    Catch ex As Exception
      writer.WriteLine("</rows>")
      writer.Write("<error>" & server.HTMLEncode(ex.Message))
      if LogSqlOnError AndAlso not IsNothing(sqlText) then writer.Write(" - " & server.HTMLEncode(sqlText))
      writer.Write("</error>")
    end try
  end if
End Sub


' returns the total number of rows produced by the query (or -1 if unknown)
Protected Function RenderQueryRows(writer as HTMLTextWriter) As Integer
  dim rowcnt as integer, fldNum as integer, dbDate as DateTime, strFieldItem as String
  dim firstCol as Integer=0, limitQuery as Boolean=false, eof as Boolean=false
  dim rdr as object
  dim totcnt as Integer=0

  RenderQueryRows=-1
  dbVersion=dbConnection.ServerVersion
  dbClassName=TypeName(dbConnection)
  command = dbConnection.CreateCommand()
  if not IsNothing(oParse) then
    ApplyQStringParms()
    if distinctCol >= 0 then
      sqlText=oParse.UnparseDistinctColumn(distinctCol)
    elseif numrows < 0 then
      sqlText=oParse.UnparseSelect()
    else
      select case dbDialect
        case "TSQL":
          if left(dbVersion,2) >= "09" then
            sqlText=oParse.UnparseWithRowNumber(offset,numrows+1,true)
            firstCol=1
            limitQuery=true
          else
            sqlText=oParse.UnparseSelect()
          end if
        case "Oracle": 
          sqlText=oParse.UnparseWithRowNumber(offset,numrows+1,false)
          firstCol=1
          limitQuery=true
        case "MySQL":
          sqlText=oParse.UnparseSelect() & " LIMIT " & offset & "," & CStr(numrows+1)
          limitQuery=true
        case else:
          sqlText=oParse.UnparseSelect()
      end select  
    end if
  end if
  if IsNothing(sqlText) then Exit Function
  DebugMsgs.add(sqlText)
  DebugMsgs.add(dbClassName)
  DebugMsgs.add(dbVersion)
  command.CommandText = sqlText
  rdr = command.ExecuteReader()

  if limitQuery then
    totcnt=offset
  else
    while (totcnt < offset) and (not eof)
      if rdr.Read() then
        totcnt += 1
      else
        eof=true
      end if
    end while
  end if

  rowcnt=0
  if numrows < 0 then numrows=AllRowsMax
  while (rowcnt < numrows) and (not eof)
    if rdr.Read() then
      rowcnt += 1
      writer.Write("<tr>")
      for fldNum = firstCol to rdr.FieldCount -1
        strFieldItem = ""
        if not rdr.IsDBNull(fldNum) then
          select case rdr.GetFieldType(fldNum).Name
            case "DateTime":
              dbDate=rdr.GetDateTime(fldNum)
              strFieldItem = dbDate.ToString("s")  ' convert to ISO-8601 format
            case else:
              strFieldItem = server.HTMLEncode(rdr.GetValue(fldNum))
          end select
        end if
        writer.Write("<td>" & strFieldItem & "</td>")
      next
      writer.Write("</tr>")
    else
      eof=true
    end if
  end while
  totcnt += rowcnt

  if not eof and gettotal then
    if limitQuery then
      rdr.Close()
      dim countSql,cnt
      countSql="SELECT " & oParse.UnparseColumnList() & " FROM " & oParse.FromClause
      if not IsNothing(oParse.WhereClause) then countSql &= " WHERE " & oParse.WhereClause
      if oParse.GroupBy.count > 0 then countSql &= " GROUP BY " & join(oParse.GroupBy.ToArray(),",")
      if not IsNothing(oParse.HavingClause) then countSql &= " HAVING " & oParse.HavingClause
      countSql="SELECT COUNT(*) FROM (" & countSql & ")"
      if dbDialect<>"Oracle" then countSql &= " AS rico_Main"
      DebugMsgs.add(countSql)
      command.CommandText = countSql
      totcnt = command.ExecuteScalar()
      eof=true
    else
      while rdr.Read()
        totcnt += 1
      end while
      eof=true
    end if
  end if
  if eof then RenderQueryRows=totcnt
  rdr.Close()
End Function


' returns the parameter symbol to insert into the sql string
Private Function PushParam(ByVal newvalue) as String
  dim ParamName as String
  newvalue=cstr(newvalue)
  if newvalue="" then newvalue=" "  ' empty string gets converted to TEXT data type instead of VARCHAR
  select case dbClassName
    case "SqlConnection":
      ParamName="@P" & CStr(command.parameters.count)
      PushParam=ParamName
    case else:
      ParamName=""
      PushParam="?"
  end select
  command.parameters.add(ParamName,newvalue)
  DebugMsgs.add("Param " & ParamName & " value=" & newvalue)
End Function


' assumes oParse is already initialized
Private sub ApplyQStringParms()
  dim i, a, flen
  dim j as Integer, fop as String, ParamSymbol as String
  dim newfilter as string, qs as string, value as string

  for each qs in Request.QueryString
    select case left(qs,1)
      
      ' user-invoked condition
      case "w","h":
        i=mid(qs,2)
        if not IsNumeric(i) then exit for
        i=CInt(i)
        if i<0 or i>=filters.Count then exit for
        value=Request.QueryString(qs)
        newfilter=filters(i)
        j=InStr(1,newfilter," in (?)",1)
        if j>0 then
          a=split(value,",")
          for i=0 to ubound(a)
            ParamSymbol=PushParam(a(i))
            a(i)=ParamSymbol
          next
          newfilter=left(newfilter,j+4) & join(a,",") & mid(newfilter,j+6)
        elseif InStr(newfilter,"?")>0 then
          ParamSymbol=PushParam(value)
          if ParamSymbol<>"?" then newfilter=replace(newfilter,"?",ParamSymbol)
        end if
        if left(qs,1)="h" then
          oParse.AddHavingCondition(newfilter)
        else
          oParse.AddWhereCondition(newfilter)
        end if
      
      ' sort
      case "s":
        i=mid(qs,2)
        if not IsNumeric(i) then exit for
        i=CInt(i)
        if i<0 or i>=oParse.SelectList.count then exit for
        value=ucase(left(Request.QueryString(qs),4))
        if value<>"ASC" and value<>"DESC" then value="ASC"
        if orderByRef then
          oParse.AddSort(CStr(i+1) & " " & value)
        else
          oParse.AddSort(oParse.SelectList(i).sql & " " & value)
        end if
      
      ' user-supplied filter
      case "f":
        a=split(qs,"[")
        if ubound(a)=2 then
          if a(2)="op]" then
            i=left(a(1),len(a(1))-1)
            if not IsNumeric(i) then exit for
            if len(i)>3 then exit for
            i=CInt(i)
            if i<0 or i>oParse.SelectList.count then exit for
            fop=Request.QueryString(qs)
            newfilter=oParse.SelectList(i).sql
            select case fop
              case "EQ":
                value=Request.QueryString(replace(qs,"[op]","[0]"))
                if value="" then
                  if dbDialect="Access" then
                    newfilter="iif(IsNull(" & newfilter & "),''," & newfilter & ")"
                  else
                    newfilter="coalesce(" & newfilter & ",'')"
                  end if
                end if
                newfilter &= "=" & PushParam(value)
              case "LE":
                newfilter &= "<=" & PushParam(Request.QueryString(replace(qs,"[op]","[0]")))
              case "GE":
                newfilter &= ">=" & PushParam(Request.QueryString(replace(qs,"[op]","[0]")))
              case "NULL": newfilter &= " is null"
              case "NOTNULL": newfilter &= " is not null"
              case "LIKE":
                newfilter &= " LIKE " & PushParam(replace(Request.QueryString(replace(qs,"[op]","[0]")),"*",Wildcard))
              case "NE"
                flen=Request.QueryString(replace(qs,"[op]","[len]"))
                if not IsNumeric(flen) then exit for
                flen=CInt(flen)
                newfilter &= " NOT IN ("
                for j=0 to flen-1
                  if j>0 then newfilter &= ","
                  newfilter &= PushParam(Request.QueryString(replace(qs,"[op]","[" & j & "]")))
                next
                newfilter &= ")"
            end select
            dim sql=oParse.SelectList(i).sql
            if (InStr(sql,"min(")>0 or _
               InStr(sql,"max(")>0 or _
               InStr(sql,"sum(")>0 or _
               InStr(sql,"count(")>0) and _
               InStr(sql,"(select ")<1 then
              oParse.AddHavingCondition(newfilter)
            else
              oParse.AddWhereCondition(newfilter)
            end if
          end if
        end if
    end select
  next
end sub


Public function XmlStringCell(value as object) as String
  dim result
  if IsDBNull(value) then result="" else result=server.HTMLEncode(value)
  XmlStringCell="<td>" & result & "</td>"
end function


' for the root node, parentID should "" (empty string)
' containerORleaf: L/zero (leaf), C/non-zero (container)
' selectable:      0->not selectable, 1->selectable
Public function WriteTreeRow(parentID,ID,description,containerORleaf,selectable)
  HeaderRows.Add(TreeRow(parentID,ID,description,containerORleaf,selectable))
end function

Public function TreeRow(parentID,ID,description,containerORleaf,selectable)
  TreeRow="<tr>" & XmlStringCell(parentID) & XmlStringCell(ID) & XmlStringCell(description) & XmlStringCell(containerORleaf) & XmlStringCell(selectable) & "</tr>"
end function

</script>
