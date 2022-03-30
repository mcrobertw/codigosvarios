<%@ LANGUAGE="VBSCRIPT" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico LiveGrid-Example 2</title>

<!-- #INCLUDE FILE = "applib.vbs" --> 

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../../src/css/greenHdg.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />
<!-- #INCLUDE FILE = "chklang2.vbs" --> 

<script type='text/javascript'>
var orderGrid,buffer,prodSelect;

Rico.onLoad( function() {
  var opts = {  
    columnSpecs   : [,,,,,{type:'date'},{type:'date'}]
  };
  buffer=new Rico.Buffer.AjaxSQL('ricoXMLquery.asp', {TimeOut:<%=Session.Timeout%>});
  orderGrid=new Rico.LiveGrid ('ex2', buffer, opts);
  orderGrid.menu = new Rico.GridMenu();
  prodSelect=$('prodSelect');
  prodSelect.selectedIndex=0;
});

function FilterByProduct() {
  var id=prodSelect.value;
  buffer.options.requestParameters=id=='*' ? null : ['w0='+id];
  orderGrid.filterHandler();
}

</script>

<style type="text/css">
div.ricoLG_cell {
  white-space:nowrap;
}
</style>
</head>

<body>
<%
dim rsMain
response.write "<p id='explanation'>Show only orders that include this product: "
Session.Timeout=60
Session.contents("ex2")="select OrderID,CustomerID,ShipName,ShipCity,ShipCountry,OrderDate,ShippedDate from orders order by OrderID"
Session.contents("ex2.filters")=array("OrderID in (select OrderID from order_details where ProductID=?)")
response.write "<select id='prodSelect' onchange='FilterByProduct()'>"
response.write "<option value='*'>&lt;select product&gt;</option>"
OpenDB
set rsMain = oDB.RunQuery("select ProductID,ProductName from products")
while not rsMain.eof
  response.write "<option value='" & rsMain(0) & "'>" & server.HTMLencode(rsMain(1)) & "</option>"
  rsMain.movenext
wend
oDB.rsClose rsMain
CloseApp
response.write "</select>"
%>

<p class="ricoBookmark"><span id='ex2_timer' class='ricoSessionTimer'></span><span id="ex2_bookmark">&nbsp;</span></p>
<table id="ex2" class="ricoLiveGrid" cellspacing="0" cellpadding="0">
<colgroup>
<col style='width:40px;' >
<col style='width:60px;' >
<col style='width:150px;'>
<col style='width:120px;' >
<col style='width:90px;' >
<col style='width:100px;'>
<col style='width:100px;'>
</colgroup>
  <tr id='ex2_main'>
	  <th>Order#</th>
	  <th>Customer#</th>
	  <th>Ship Name</th>
	  <th>Ship City</th>
	  <th>Ship Country</th>
	  <th>Order Date</th>
	  <th>Ship Date</th>
  </tr>
</table>

</body>
</html>

