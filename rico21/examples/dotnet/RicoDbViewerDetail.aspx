<%@ Page Language="VB" ResponseEncoding="iso-8859-1" Debug="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Register TagPrefix="Rico" TagName="LiveGrid" Src="../../plugins/dotnet/LiveGrid.ascx" %>
<%@ Register TagPrefix="Rico" TagName="Column" Src="../../plugins/dotnet/GridColumn.ascx" %>
<%@ Register TagPrefix="My" TagName="AppLib" Src="applib.ascx" %>
<My:AppLib id='app' runat='server' />

<script runat="server">
Dim TableName as String

Sub Page_Load(Sender As object, e As EventArgs)
  Dim restrictions() As String = New String(2) {}
  Dim ColumnInfo As DataTable
  Dim columnlist as String

  TableName = trim(request.querystring("id"))
  if app.OpenDB() then

    restrictions(2)=TableName
    ColumnInfo = app.dbConnection.GetSchema ("Columns", restrictions)

    Dim colname as String, datatype as String
    For Each colinfo As DataRow In ColumnInfo.Rows
      colname=colinfo("COLUMN_NAME").ToString
      datatype=colinfo("DATA_TYPE").ToString
      if IsNumeric(datatype) then datatype=ADOColType(datatype)
      if not IsNothing(columnlist) then
        columnlist=columnlist & ","
      end if
      if InStr(1,datatype,"binary",1) > 0 or left(datatype,3)="???" then
        columnlist=columnlist & "'?'"
      else
        columnlist=columnlist & colname
      end if
      Dim ColumnObj as New GridColumn()
      ColumnObj.Heading=colname
      ColumnObj.width=100
      if InStr(1,datatype,"DATETIME",1) > 0 then ColumnObj.DataType="datetime"
      dbViewer.AddColumn(ColumnObj)
    Next
    dbViewer.sqlQuery="select " & columnlist & " from [" & TableName & "]"

  end if
End Sub

Function ADOColType(typenum)
  select case typenum
    case 2,3,16,17,18,19,20,21,139: ADOColType="INT"
    case 7,133,134,135: ADOColType="DATETIME"
    case 129,130:   ADOColType="CHAR"
    case 8,200,202: ADOColType="VARCHAR"
    case 201,203:   ADOColType="TEXT"
    case 4,5,6,14:  ADOColType="FLOAT"
    case 11:        ADOColType="BOOLEAN"
    case else:      ADOColType="???" & typenum
  end select
End Function

</script>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico LiveGrid-DB Viewer</title>

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../../src/css/greenHdg.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />

<style type="text/css">
html { border: none; }
div.ricoLG_cell {
  white-space:nowrap;
}
</style>
</head>

<body>

<p><strong><%=TableName%></strong>
<Rico:LiveGrid runat='server' id='dbViewer' >
<GridColumns>
</GridColumns>
</Rico:LiveGrid>

</body>
</html>
