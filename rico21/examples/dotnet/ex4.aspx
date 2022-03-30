<%@ Page Language="VB" ResponseEncoding="iso-8859-1" Debug="true" %>
<%@ Register TagPrefix="Rico" TagName="DemoSettings" Src="settings.ascx" %>
<%@ Register TagPrefix="Rico" TagName="LiveGrid" Src="../../plugins/dotnet/LiveGrid.ascx" %>
<%@ Register TagPrefix="Rico" TagName="Column" Src="../../plugins/dotnet/GridColumn.ascx" %>

<script runat="server">

Sub Page_Load(Sender As object, e As EventArgs)
  Session.Timeout=60
  customer.sqlQuery="select CustomerID,CompanyName,ContactName,Address,City,Region,PostalCode,Country,Phone,Fax from customers order by CustomerID"
  order.sqlQuery="select CustomerID,OrderID,ShipName,ShipCity,ShipCountry,OrderDate,ShippedDate from orders order by OrderID"
  detail.sqlQuery="select OrderID,p.ProductName,QuantityPerUnit,od.UnitPrice,Quantity,od.UnitPrice*Quantity as Total,Discount,od.UnitPrice*Quantity*(1.0-Discount) as NetPrice from order_details od left join products p on od.ProductID=p.ProductID order by od.ProductID"
End Sub

</script>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico LiveGrid-Example 4</title>

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../../src/css/greenHdg.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />

<script type="text/javascript">

var custid,orderid;

function customerDrillDown(e) {
  var cell=Event.element(e);
  cell=RicoUtil.getParentByTagName(cell,'div','ricoLG_cell');
  if (!cell) return;
  Event.stop(e);
  var a=cell.id.split(/_/);
  var l=a.length;
  var r=parseInt(a[l-2]);
  if (r < customer['buffer'].totalRows) {
    customer['grid'].unhighlight();
    var idx=customer['grid'].winCellIndex(cell);
    customer['grid'].menuIdx=idx;
    customer['grid'].selectRow(idx.row);
    custid=customer['grid'].columns[0].getValue(r);
    $("order_caption").innerHTML='Orders for '+custid;
    $("detail_caption").innerHTML="";
    order['grid'].columns[0].setSystemFilter("EQ",custid);
    detail['grid'].resetContents();
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
  if (r < order['buffer'].totalRows) {
    order['grid'].unhighlight();
    var idx=order['grid'].winCellIndex(cell);
    order['grid'].menuIdx=idx;
    order['grid'].selectRow(idx.row);
    orderid=order['grid'].columns[1].getValue(r);
    $("detail_caption").innerHTML='Order #'+orderid;
    detail['grid'].columns[0].setSystemFilter("EQ",orderid);
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

#description {
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
<col width='33%'>
<tr valign='top'>
<td rowspan='3'>
<div id='description'>
Double-click on a row to see all orders for that customer.
<p>Drag the edge of a column heading to resize a column.
<p>To filter: right-click (ctrl-click in Opera, Konqueror, or Safari) 
on the value that you would like to use as the basis for filtering, 
then select the desired filtering method from the pop-up menu.
<p>Right-click anywhere in a column to see sort, hide, and show options.
<p>Notice that filters and sorting in the customer grid persist after a refresh. 
The saveColumnInfo option specifies that these values should be saved in cookies.
</div>

</td>
<td class="gridcontainer" height="33%">

<Rico:LiveGrid runat='server' id='customer' caption='Customers' rows='-4' frozenColumns='2' menuEvent='contextmenu' DisplayTimer='false' highlightElem='menuRow' dblclick='customerDrillDown'>
<GridColumns>
  <Rico:Column runat='server' heading='Customer#' width='60' />
  <Rico:Column runat='server' heading='Company' width='150' />
  <Rico:Column runat='server' heading='Contact' width='115' />
  <Rico:Column runat='server' heading='Address' width='130' />
  <Rico:Column runat='server' heading='City' width='90' />
  <Rico:Column runat='server' heading='Region' width='60' />
  <Rico:Column runat='server' heading='Postal Code' width='90' />
  <Rico:Column runat='server' heading='Country' width='100' />
  <Rico:Column runat='server' heading='Phone' width='115' />
  <Rico:Column runat='server' heading='Fax' width='115' />
</GridColumns>
</Rico:LiveGrid>

</td>
<tr height="33%"><td class="gridcontainer">

<Rico:LiveGrid runat='server' id='order' caption='' rows='4' prefetchBuffer='false' menuEvent='contextmenu' DisplayTimer='false' highlightElem='menuRow' dblclick='orderDrillDown'>
<GridColumns>
  <Rico:Column runat='server' heading='Customer#' width='60' canSort='false' visible='false'/>
  <Rico:Column runat='server' heading='Order#' width='60' />
  <Rico:Column runat='server' heading='Ship Name' width='150' />
  <Rico:Column runat='server' heading='Ship City' width='80' />
  <Rico:Column runat='server' heading='Ship Country' width='90' />
  <Rico:Column runat='server' heading='Order Date' datatype='date' width='100' />
  <Rico:Column runat='server' heading='Ship Date' datatype='date' width='100' />
</GridColumns>
</Rico:LiveGrid>

</td>
<tr height="33%"><td class="gridcontainer">

<Rico:LiveGrid runat='server' id='detail' caption='' rows='4' prefetchBuffer='false' menuEvent='contextmenu' DisplayTimer='false' highlightElem='menuRow'>
<GridColumns>
  <Rico:Column runat='server' heading='Order#' width='60' canSort='false' visible='false' />
  <Rico:Column runat='server' heading='Description' width='150' />
  <Rico:Column runat='server' heading='Unit Quantity' width='125' />
  <Rico:Column runat='server' heading='Unit Price' width='80' format='Dollar' />
  <Rico:Column runat='server' heading='Qty' width='50' format='Qty' />
  <Rico:Column runat='server' heading='Total' width='80' format='Dollar' />
  <Rico:Column runat='server' heading='Discount' width='80' format='Percent' />
  <Rico:Column runat='server' heading='Net Price' width='90' format='Dollar' />
</GridColumns>
</Rico:LiveGrid>

</td>
</tr>
</table></body></html>
