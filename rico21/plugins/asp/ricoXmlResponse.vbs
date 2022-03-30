<%

class ricoXmlResponse

Public orderByRef      ' use column numbers in order by clause? (true/false)
Public sendDebugMsgs   ' send details of sql parsing/execution in ajax response? (true/false)
Public AllRowsMax      ' max # of rows to send if numrows=-1
Private objDB,eof,oParse,sqltext,arParams


Private Sub Class_Initialize
  orderByRef=false
  if IsObject(oDB) then
    set objDB=oDB  ' use oDB global as database connection, if it exists
    if objDB.Dialect="Access" or objDB.Dialect="MySQL" then orderByRef=true
  end if
  sendDebugMsgs=false
  AllRowsMax=1999
  redim arParams(-1)
end sub


' All Oracle and SQL Server 2005 queries *must* have an ORDER BY clause
' "as" clauses are now ok
' If numrows < 0, then retrieve all rows
Public function Query2xml(ByVal sqlselect,offset,numrows,gettotal,filters)
  dim totcnt,version,Dialect
  set oParse=new sqlParse
  oParse.ParseSelect sqlselect
  ApplyQStringParms filters
  response.write vbLf & "<rows update_ui='true' offset='" & offset & "'>"
  if numrows >= 0 then Dialect=objDB.Dialect else numrows=AllRowsMax
  select case Dialect
    case "TSQL":
      objDB.SingleRecordQuery "select @@VERSION",version
      if ucase(left(sqlselect,7))<>"SELECT " then
        ' stored procedure
        redim arParams(-1)  ' ignore any parameters
        gettotal=false
        totcnt=Query2xmlRaw_NoLimit(sqlselect,offset,numrows,gettotal)
      elseif InStr(version,"SQL Server 2005") > 0 or InStr(version,"SQL Server 2008") > 0 then
        sqltext=UnparseWithRowNumber(offset,numrows+1,true)
        totcnt=Query2xmlRaw_Limit(sqltext,offset,numrows,1)
      else
        sqltext=oParse.UnparseSelect
        totcnt=Query2xmlRaw_NoLimit(sqltext,offset,numrows,gettotal)
      end if
    case "Oracle": 
      sqltext=UnparseWithRowNumber(offset,numrows+1,false)
      totcnt=Query2xmlRaw_Limit(sqltext,offset,numrows,1)
    case "MySQL":
      sqltext=oParse.UnparseSelect & " LIMIT " & offset & "," & CStr(numrows+1)
      totcnt=Query2xmlRaw_Limit(sqltext,offset,numrows,0)
    case else:
      sqltext=oParse.UnparseSelect
      totcnt=Query2xmlRaw_NoLimit(sqltext,offset,numrows,gettotal)
  end select  
  response.write vbLf & "</rows>"
  if not eof and gettotal then totcnt=getTotalRowCount
  if eof then response.write vbLf & "<rowcount>" & totcnt & "</rowcount>"
  if sendDebugMsgs then
    response.write vbLf & "<debug>" & server.HTMLencode(sqlselect) & "</debug>"
    response.write vbLf & "<debug>" & server.HTMLencode(sqltext) & "</debug>"
  end if
  Query2xml=totcnt
  set oParse=Nothing
end function


Public sub Query2xmlDistinct(ByVal sqlselect,colnum,maxrows,filters)
  set oParse=new sqlParse
  oParse.ParseSelect sqlselect
  if colnum<0 or colnum>ubound(oParse.arSelList) then
    objDB.LastErrorMsg="Invalid column number for distinct query"
    exit sub
  end if
  ApplyQStringParms filters
  sqltext=oParse.UnparseDistinctColumn(colnum)
  response.write vbLf & "<rows update_ui='true' offset='" & offset & "' distinct='" & colnum & "'>"
  totcnt=Query2xmlRaw_NoLimit(sqltext,0,maxrows,false)
  response.write vbLf & "</rows>"
  if sendDebugMsgs then
    response.write vbLf & "<debug>" & server.HTMLencode(sqlselect) & "</debug>"
    response.write vbLf & "<debug>" & server.HTMLencode(sqltext) & "</debug>"
  end if
  set oParse=Nothing
end sub


' Tested ok with SQL Server 2005, MySQL, and Oracle
Private function getTotalRowCount()
  dim countSql,cnt
  countSql="SELECT " & oParse.UnparseColumnList & " FROM " & oParse.FromClause
  if not IsEmpty(oParse.WhereClause) then countSql=countSql & " WHERE " & oParse.WhereClause
  if IsArray(oParse.arGroupBy) then
    if UBound(oParse.arGroupBy)>=0 then countSql=countSql & " GROUP BY " & join(oParse.arGroupBy,",")
  end if
  if not IsEmpty(oParse.HavingClause) then countSql=countSql & " HAVING " & oParse.HavingClause
  countSql="SELECT COUNT(*) FROM (" & countSql & ")"
  if objDB.Dialect<>"Oracle" then countSql=countSql & " AS rico_Main"
  if sendDebugMsgs then response.write vbLf & "<debug>" & server.HTMLencode(countSql) & "</debug>"
  if ubound(arParams) >= 0 then
    set rsMain = objDB.RunParamQuery(countSql,arParams)
  else
    set rsMain = objDB.RunQuery(countSql)
  end if
  getTotalRowCount=rsMain.Fields(0).Value
  objDB.rsClose rsMain
  eof=true
end Function


Private function UnparseWithRowNumber(offset,numrows,includeAS)
  dim unparseText,strOrderBy
  if IsArray(oParse.arOrderBy) then
    if UBound(oParse.arOrderBy)>=0 then strOrderBy=join(oParse.arOrderBy,",")
  end If
  if IsEmpty(strOrderBy) then
    ' order by clause should be included in main sql select statement
    ' However, if it isn't, then use primary key as sort - assuming FromClause is a simple table name
    strOrderBy=objDB.PrimaryKey(oParse.FromClause)
  end if
  unparseText="SELECT ROW_NUMBER() OVER (ORDER BY " & strOrderBy & ") AS rico_rownum,"
  unparseText=unparseText & oParse.UnparseColumnList & " FROM " & oParse.FromClause
  if not IsEmpty(oParse.WhereClause) then unparseText=unparseText & " WHERE " & oParse.WhereClause
  if IsArray(oParse.arGroupBy) then
    if UBound(oParse.arGroupBy)>=0 then unparseText=unparseText & " GROUP BY " & join(oParse.arGroupBy,",")
  end if
  if not IsEmpty(oParse.HavingClause) then unparseText=unparseText & " HAVING " & oParse.HavingClause
  unparseText="SELECT * FROM (" & unparseText & ")"
  if includeAS then unparseText=unparseText & " AS rico_Main"
  unparseText=unparseText & " WHERE rico_rownum > " & offset & " AND rico_rownum <= " & CStr(offset+numrows)
  UnparseWithRowNumber=unparseText
end Function


Public function Query2xmlRaw(ByVal rawsqltext, ByVal offset, ByVal numrows)
  Query2xmlRaw=Query2xmlRaw_NoLimit(rawsqltext,offset,numrows,true)
end Function


Public function Query2xmlRaw_NoLimit(ByVal rawsqltext, ByVal offset, ByVal numrows, ByVal gettotal)
  dim rsMain,totcnt

  if ubound(arParams) >= 0 then
    set rsMain = objDB.RunParamQuery(rawsqltext,arParams)
  else
    set rsMain = objDB.RunQuery(rawsqltext)
  end if
  totcnt=0
  eof=true
  if rsMain is Nothing then exit function

  while not rsMain.eof and totcnt<offset
    totcnt=totcnt+1
    rsMain.movenext
  wend
  totcnt = totcnt + WriteRows(rsMain, numrows, 0)
  if gettotal then
    while not rsMain.eof
      totcnt=totcnt+1
      rsMain.movenext
    wend
  end if
  eof=rsMain.eof

  objDB.rsClose rsMain
  Query2xmlRaw_NoLimit=totcnt
end function


Public function Query2xmlRaw_Limit(ByVal rawsqltext,offset,numrows,firstcol)
  dim rsMain,totcnt

  if ubound(arParams) >= 0 then
    set rsMain = objDB.RunParamQuery(rawsqltext,arParams)
  else
    set rsMain = objDB.RunQuery(rawsqltext)
  end if
  totcnt=offset
  eof=true
  if rsMain is Nothing then exit function
  totcnt = totcnt + WriteRows(rsMain, numrows, firstcol)
  eof=rsMain.eof
  objDB.rsClose rsMain
  Query2xmlRaw_Limit=totcnt
end function


Private Function WriteRows(rsMain, ByVal numrows, ByVal firstcol)
  dim colcnt,rowcnt,i
  rowcnt=0
  colcnt=rsMain.fields.count
  on error resume next
  while not rsMain.eof and rowcnt<numrows
    rowcnt=rowcnt+1
    response.write vbLf & "<tr>"
    for i=firstcol to colcnt-1
      response.write XmlStringCell(FormatValue(rsMain.fields(i).value))
    next
    response.write "</tr>"
    rsMain.movenext
  wend
  WriteRows=rowcnt
end function


Private Function PadNumber(number, length)
	dim strNumber
	
	if IsNull(number) or IsEmpty(number) then strNumber=String(length,"-") else strNumber = Cstr(number)
	do while len(strNumber) < length
		strNumber = "0" & strNumber
	loop

	PadNumber=strNumber
End Function


Private Function FormatValue(s)
  select case vartype(s)
    case 11
      FormatValue=lcase(s)      ' boolean
    case 7,133,134,135:
      FormatValue=year(s) & "-" & PadNumber(month(s),2) & "-" & PadNumber(day(s),2) & " " & PadNumber(hour(s),2) & ":" & PadNumber(minute(s),2) & ":" & PadNumber(second(s),2) ' date/time
    case else
      FormatValue=s
  end select
End Function


Public Sub SetDbConn(dbcls)
  set objDB=dbcls
end Sub


Private sub PushParam(ByVal newvalue)
  ReDim Preserve arParams(ubound(arParams)+1)
  newvalue=cstr(newvalue)
  if newvalue="" then newvalue=" "  ' empty string gets converted to TEXT data type instead of VARCHAR
  arParams(ubound(arParams))=newvalue
  if sendDebugMsgs then
    response.write vbLf & "<debug>Param " & ubound(arParams) & " type=" & typename(newvalue) & " value=" & server.HTMLencode(newvalue) & "</debug>"
  end if
end sub


' assumes oParse is already initialized
Private sub ApplyQStringParms(filters)
  dim i,j,newfilter,qs,a,flen,fop,value

  for each qs in Request.QueryString
    select case left(qs,1)
      
      ' user-invoked condition
      case "w","h":
        i=mid(qs,2)
        if not IsNumeric(i) or not isArray(filters) then exit for
        i=CInt(i)
        if i<0 or i>ubound(filters) then exit for
        value=Request.QueryString(qs)
        newfilter=filters(i)
        j=InStr(1,newfilter," in (?)",1)
        if j>0 then
          a=split(value,",")
          for i=0 to ubound(a)
            PushParam a(i)
            a(i)="?"
          next
          newfilter=left(newfilter,j+4) & join(a,",") & mid(newfilter,j+6)
        elseif InStr(newfilter,"?")>0 then
          PushParam value
        end if
        if left(qs,1)="h" then
          oParse.AddHavingCondition newfilter
        else
          oParse.AddWhereCondition newfilter
        end if
      
      ' sort
      case "s":
        i=mid(qs,2)
        if not IsNumeric(i) then exit for
        i=CInt(i)
        if i<0 or i>ubound(oParse.arSelList) then exit for
        value=ucase(left(Request.QueryString(qs),4))
        if value<>"ASC" and value<>"DESC" then value="ASC"
        if orderByRef then
          oParse.AddSort CStr(i+1) & " " & value
        else
          oParse.AddSort oParse.arSelList(i) & " " & value
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
            if i<0 or i>ubound(oParse.arSelList) then exit for
            fop=Request.QueryString(qs)
            newfilter=oParse.arSelList(i)
            select case fop
              case "EQ":
                value=Request.QueryString(replace(qs,"[op]","[0]"))
                if value="" then
                  if objDB.Dialect="Access" then
                    newfilter="iif(IsNull(" & newfilter & "),''," & newfilter & ")"
                  else
                    newfilter="coalesce(" & newfilter & ",'')"
                  end if
                end if
                newfilter=newfilter & "=?"
                PushParam value
              case "LE":
                newfilter=newfilter & "<=?"
                PushParam Request.QueryString(replace(qs,"[op]","[0]"))
              case "GE":
                newfilter=newfilter & ">=?"
                PushParam Request.QueryString(replace(qs,"[op]","[0]"))
              case "NULL": newfilter=newfilter & " is null"
              case "NOTNULL": newfilter=newfilter & " is not null"
              case "LIKE":
                newfilter=newfilter & " LIKE ?"
                PushParam replace(Request.QueryString(replace(qs,"[op]","[0]")),"*",objDB.Wildcard)
              case "NE"
                flen=Request.QueryString(replace(qs,"[op]","[len]"))
                if not IsNumeric(flen) then exit for
                flen=CInt(flen)
                newfilter=newfilter & " NOT IN ("
                for j=0 to flen-1
                  if j>0 then newfilter=newfilter & ","
                  newfilter=newfilter & "?"
                  PushParam Request.QueryString(replace(qs,"[op]","[" & j & "]"))
                next
                newfilter=newfilter & ")"
            end select
            if (InStr(oParse.arSelList(i),"min(")>0 or _
               InStr(oParse.arSelList(i),"max(")>0 or _
               InStr(oParse.arSelList(i),"sum(")>0 or _
               InStr(oParse.arSelList(i),"count(")>0) and _
               InStr(oParse.arSelList(i),"(select ")<1 then
              oParse.AddHavingCondition newfilter
            else
              oParse.AddWhereCondition newfilter
            end if
          end if
        end if
    end select
  next
end sub


Public function XmlStringCell(value)
  dim result
  if IsNull(value) then result="" else result=server.HTMLEncode(value)
  XmlStringCell="<td>" & result & "</td>"
end function


' for the root node, parentID should "" (empty string)
' containerORleaf: L/zero (leaf), C/non-zero (container)
' selectable:      0->not selectable, 1->selectable
Public sub WriteTreeRow(parentID,ID,description,containerORleaf,selectable)
  response.write vbLf & "<tr>"
  response.write XmlStringCell(parentID)
  response.write XmlStringCell(ID)
  response.write XmlStringCell(description)
  response.write XmlStringCell(containerORleaf)
  response.write XmlStringCell(selectable)
  response.write "</tr>"
end sub

end class

%>
