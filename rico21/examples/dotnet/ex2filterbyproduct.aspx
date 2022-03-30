<%@ Page Language="VB" ResponseEncoding="iso-8859-1" Debug="true" %>
<%@ Register TagPrefix="Rico" TagName="LiveGrid" Src="../../plugins/dotnet/LiveGrid.ascx" %>
<%@ Register TagPrefix="Rico" TagName="Column" Src="../../plugins/dotnet/GridColumn.ascx" %>
<%@ Register TagPrefix="My" TagName="AppLib" Src="applib.ascx" %>
<My:AppLib id='app' runat='server' />


<script runat="server">

Sub Page_Load(Sender As object, e As EventArgs)
  Session.Timeout=60
  ex2.sqlQuery="select OrderID,CustomerID,ShipName,ShipCity,ShipCountry,OrderDate,ShippedDate from orders order by OrderID"
  ex2.AddFilter("OrderID in (select OrderID from order_details where ProductID=?)")
  ex2.dataProvider="ricoXMLquery.aspx"

  if app.OpenDB() then
    ' done without DataAdaptors and DataSets to make this database independent
    dim command as object = app.dbConnection.CreateCommand()
    command.CommandText = "select ProductID,ProductName from products"
    dim rdr as object = command.ExecuteReader()
    prodSelect.DataSource = rdr
    prodSelect.DataValueField = "ProductID"
    prodSelect.DataTextField = "ProductName"
    prodSelect.DataBind()
    rdr.Close()
    prodSelect.Items.Insert(0, new ListItem("<select product>","*"))
  end if
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

<script type='text/javascript'>
var prodSelect;

Rico.onLoad( function() {
  prodSelect=$('prodSelect');
  prodSelect.selectedIndex=0;
});

function FilterByProduct() {
  var id=prodSelect.value;
  ex2['buffer'].options.requestParameters=id=='*' ? null : ['w0='+id];
  ex2['grid'].filterHandler();
}

</script>

<style type="text/css">
div.ricoLG_cell {
  white-space:nowrap;
}
</style>
</head>
<body>
<p id='explanation'>Show only orders that include this product: <SELECT id="prodSelect" onchange='FilterByProduct()' runat="server"></SELECT></p>

<Rico:LiveGrid runat='server' id='ex2'>
<GridColumns>
  <Rico:Column runat='server' heading='Order#' width='60' />
  <Rico:Column runat='server' heading='Customer#' width='60' />
  <Rico:Column runat='server' heading='Ship Name' width='150' />
  <Rico:Column runat='server' heading='Ship City' width='120' />
  <Rico:Column runat='server' heading='Ship Country' width='90' />
  <Rico:Column runat='server' heading='Order Date' datatype='date' width='100' />
  <Rico:Column runat='server' heading='Ship Date' datatype='date' width='100' />
</GridColumns>
</Rico:LiveGrid>

</body>
</html>
