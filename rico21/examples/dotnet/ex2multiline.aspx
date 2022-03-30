<%@ Page Language="VB" ResponseEncoding="iso-8859-1" Debug="true" %>
<%@ Register TagPrefix="Rico" TagName="LiveGrid" Src="../../plugins/dotnet/LiveGrid.ascx" %>
<%@ Register TagPrefix="Rico" TagName="Column" Src="../../plugins/dotnet/GridColumn.ascx" %>
<%@ Register TagPrefix="Rico" TagName="sqlCompatibilty" Src="../../plugins/dotnet/sqlCompatibilty.ascx" %>
<%@ Register TagPrefix="My" TagName="AppLib" Src="applib.ascx" %>
<My:AppLib id='app' runat='server' />


<script runat="server">

Sub Page_Load(Sender As object, e As EventArgs)
  Session.Timeout=60
  dim oSqlCompat=new sqlCompatibilty(app.dbDialect)
  dim arDateSql as string() = {"OrderDate","'<br>'","ShippedDate"}
  dim arAddrSql as string() = {"ShipName","'<br>'","ShipAddress","'<br>'","ShipCity","' '","ShipRegion","' '","ShipCountry"}
  ex2.sqlQuery= _
    "select OrderID,CustomerID," & _
    oSqlCompat.Concat(arDateSql,false) & ", " & _
    oSqlCompat.Concat(arAddrSql,false) & " " & _
    "from orders order by OrderID"
End Sub

</script>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico LiveGrid-Example 2</title>

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../../src/css/greenHdg.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />

<style type="text/css">
.ricoLG_bottom div.ricoLG_cell {
  height:3.6em;
}
.ricoLG_top div.ricoLG_cell {
  white-space:nowrap;
}
</style>
</head>


<body>
<div id='explanation'>
This example shows how LiveGrid can display multi-line content.
The Rico.TableColumn.MultiLine control overcomes issues when displaying multi-line content in IE6 and IE7.
</div>

<Rico:LiveGrid runat='server' id='ex2'>
<GridColumns>
  <Rico:Column runat='server' heading='Order#'          width='60' />
  <Rico:Column runat='server' heading='Cust#'           width='60' />
  <Rico:Column runat='server' heading='Order/Ship Date' width='140' control="new Rico.TableColumn.MultiLine()" />
  <Rico:Column runat='server' heading='Ship To'         width='200' control="new Rico.TableColumn.MultiLine()" />
</GridColumns>
</Rico:LiveGrid>

</body>
</html>

