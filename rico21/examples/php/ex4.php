<?php
if (!isset ($_SESSION)) session_start();
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico LiveGrid Plus-Example 4</title>

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../../src/css/greenHdg.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />
<?php
require "chklang2.php";

$_SESSION['customergrid']="select CustomerID,CompanyName,ContactName,Address,City,Region,PostalCode,Country,Phone,Fax from customers order by CustomerID";
$_SESSION['ordergrid']="select CustomerID,OrderID,ShipName,ShipCity,ShipCountry,OrderDate,ShippedDate from orders order by OrderID";
$_SESSION['detailgrid']="select OrderID,p.ProductName,QuantityPerUnit,od.UnitPrice,Quantity,od.UnitPrice*Quantity as Total,Discount,od.UnitPrice*Quantity*(1.0-Discount) as NetPrice from order_details od left join products p on od.ProductID=p.ProductID order by od.ProductID";
?>
<script type="text/javascript">
var customerGrid, orderGrid, detailGrid;

Rico.onLoad( function() {

  var opts = {  prefetchBuffer: false,
                columnSpecs   : [{canSort:false,visible:false},,,,,{type:'date'},{type:'date'}],
                canFilterDefault: false,
                dblclick      : orderDrillDown,
                menuEvent     : 'contextmenu',
                highlightElem : 'menuRow',
                visibleRows   : 4
             };
  orderGrid=new Rico.LiveGrid ('ordergrid', new Rico.Buffer.AjaxSQL('ricoXMLquery.php'), opts);
  orderGrid.menu=new Rico.GridMenu();

  var opts = {  prefetchBuffer: false,
                columnSpecs   : [{canSort:false,visible:false},,,'specDollar','specQty','specDollar','specPercent','specDollar'],
                canFilterDefault: false,
                menuEvent     : 'contextmenu',
                highlightElem : 'menuRow',
                visibleRows   : 4
             };
  detailGrid=new Rico.LiveGrid ('detailgrid', new Rico.Buffer.AjaxSQL('ricoXMLquery.php'), opts);
  detailGrid.menu=new Rico.GridMenu();

  var opts = {  prefetchBuffer: true,
                frozenColumns : 2,
                dblclick      : customerDrillDown,
                menuEvent     : 'contextmenu',
                highlightElem : 'menuRow',
                saveColumnInfo: {width:true, filter:true, sort:true},
                visibleRows   : 'parent'
             };
  customerGrid=new Rico.LiveGrid ('customergrid', new Rico.Buffer.AjaxSQL('ricoXMLquery.php'), opts);
  customerGrid.menu=new Rico.GridMenu();
});

var custid,orderid;

function customerDrillDown(e) {
  var cell=Event.element(e);
  cell=RicoUtil.getParentByTagName(cell,'div','ricoLG_cell');
  if (!cell) return;
  Event.stop(e);
  var a=cell.id.split(/_/);
  var l=a.length;
  var r=parseInt(a[l-2]);
  if (r < customerGrid.buffer.totalRows) {
    customerGrid.unhighlight();
    var idx=customerGrid.winCellIndex(cell);
    customerGrid.menuIdx=idx;
    customerGrid.selectRow(idx.row);
    custid=customerGrid.columns[0].getValue(r);
    $("custid").innerHTML='Orders for '+custid;
    $("orderid").innerHTML="";
    orderGrid.columns[0].setSystemFilter("EQ",custid);
    detailGrid.resetContents();
  }
  return false;
}

function orderDrillDown(e) {
  var cell=Event.element(e);
  cell=RicoUtil.getParentByTagName(cell,'div','ricoLG_cell');
  if (!cell) return;
  Event.stop(e);
  var a=cell.id.split(/_/);
  var l=a.length;
  var r=parseInt(a[l-2]);
  if (r < orderGrid.buffer.totalRows) {
    orderGrid.unhighlight();
    var idx=orderGrid.winCellIndex(cell);
    orderGrid.menuIdx=idx;
    orderGrid.selectRow(idx.row);
    orderid=orderGrid.columns[1].getValue(r);
    $("orderid").innerHTML='Order #'+orderid;
    detailGrid.columns[0].setSystemFilter("EQ",orderid);
  }
  return false;
}

function detailDataMenu(objCell,onBlankRow) {
  return !onBlankRow;
}
</script>

<style type="text/css">
 html, body {
    height:96%;
    margin: 0px;
    padding: 0px;
    border: none;
 }


.gridcontainer {
margin-left:2%;
width:75%;
overflow:visible;
font-size: 8pt;
}

.description {
overflow:auto;
height:99%;
font-size:8pt;
color:blue;
font-family:Verdana, Arial, Helvetica, sans-serif;
}

div.ricoLG_cell {
font-size: 8pt;
height: 12px;
white-space: nowrap;
}
</style>

</head>

<body>

<table border='0' cellspacing='3' style='height:99%; width:99%; margin:0px;'>
<col width='25%'>
<tr valign='top'>
<td rowspan='3'>

<div class='description'>
Double-click on a row to see all orders for that customer.
<p>Drag the edge of a column heading to resize a column.
<p>To filter: right-click (ctrl-click in Opera, Konqueror, or Safari) on the value that you would like to use as the basis for filtering, then select the desired filtering method from the pop-up menu.
<p>Right-click anywhere in a column to see sort, hide, and show options.
<p>Notice that filters and sorting in the customer grid persist after a refresh. The saveColumnInfo option specifies that these values should be saved in cookies.
</div>

</td>
<td class="gridcontainer" height="33%">

<p class="ricoBookmark"><span class='ricoCaption'>Customers</span>
<span id="customergrid_bookmark"></span>
</p>
<table id="customergrid">
<colgroup>
<col style='width:60px;' >
<col style='width:150px;' >
<col style='width:115px;'>
<col style='width:130px;' >
<col style='width:90px;' >
<col style='width:60px;' >
<col style='width:90px;' >
<col style='width:100px;'>
<col style='width:115px;'>
<col style='width:115px;'>
</colgroup>
  <tr>
	  <th>Cust ID</th>
	  <th>Company</th>
	  <th>Contact</th>
	  <th>Address</th>
	  <th>City</th>
	  <th>Region</th>
	  <th>Postal Code</th>
	  <th>Country</th>
	  <th>Phone</th>
	  <th>Fax</th>
  </tr>
</table>

</td>
<tr height="33%"><td class="gridcontainer">

<p class="ricoBookmark"><span id="custid" class='ricoCaption'></span>
<span id="ordergrid_bookmark">&nbsp;</span>
</p>
<table id="ordergrid" class="ricoLiveGrid">
<colgroup>
<col style='width:5px;'  >
<col style='width:60px;' >
<col style='width:150px;'>
<col style='width:80px;' >
<col style='width:90px;' >
<col style='width:100px;'>
<col style='width:100px;'>
</colgroup>
  <tr>
	  <th>Customer#</th>
	  <th>Order#</th>
	  <th>Ship Name</th>
	  <th>Ship City</th>
	  <th>Ship Country</th>
	  <th>Order Date</th>
	  <th>Ship Date</th>
  </tr>
</table>

</td>
<tr height="33%"><td class="gridcontainer">

<p class="ricoBookmark"><span id="orderid" class='ricoCaption'></span>
<span id="detailgrid_bookmark">&nbsp;</span>
</p>
<table id="detailgrid" class="ricoLiveGrid">
<colgroup>
<col style='width:5px;'  >
<col style='width:150px;'>
<col style='width:125px;'>
<col style='width:80px;' >
<col style='width:50px;' >
<col style='width:80px;' >
<col style='width:80px;' >
<col style='width:90px;' >
</colgroup>
  <tr>
	  <th>Order #</th>
	  <th>Description</th>
	  <th>Unit Quantity</th>
	  <th>Unit Price</th>
	  <th>Qty</th>
	  <th>Total</th>
	  <th>Discount</th>
	  <th>Net Price</th>
  </tr>
</table>

</td>
</tr>
</table></body></html>
