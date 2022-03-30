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
<link href="../../src/css/grayedout.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />

<script type="text/javascript">

Rico.onLoad( function() {
  var options={panelHeight:200, hoverClass: 'panelHover', selectedClass: 'panelSelected', border: '#000000', color:'#E0E8FA', onFirstSelect: PanelSelected};
  new Rico.TabbedPanel( $$('div.panelheader'), $$('div.panelContent'), options);
});

function PanelSelected(element, index) {
  // panel's tab has been clicked, but the content panel has not been made visible yet, so wait a few ticks before doing anything
  setTimeout(PanelSelected2.bind(this,index),50);
}

function PanelSelected2(index) {
  var grids=[customer['grid'], order['grid'], detail['grid']];
  if (!grids[index]) return;
  grids[index].sizeDivs();     // initial sizing was bad due to display:none on panel, so fix this first
  grids[index].resizeWindow(); // now we can add rows
}
</script>

<style type="text/css">
body {font-family: Arial, Tahoma, Verdana;}

#tabsExample {
  width: 650px;
}

.panelContentContainer {
  border : 1px solid #4f4f4f;
  clear:both;
}

.panelheader{
  height: 1.5em;
  color : black;
  font-weight : normal;
  background: #E0E8FA;
  float: left;
  margin-left: 1px;
  margin-right: 1px;
  margin-bottom: 0px;
  margin-top: 0.3em;
  text-align: center;
  white-space:nowrap;
  overflow:hidden;
  width: 20%;
}

.panelHover {
  background: #D8E0F2;
  cursor: pointer;
}

.panelSelected {
  background: url(../../src/images/grayedout.gif) #FFFFFF repeat-x scroll center left;
  font-weight : bold;
  cursor: auto;
  height: 1.8em;
  margin-top: 1px;
  margin-bottom: -1px;
}

.panelContent {
    background: #f8f8f8;
    overflow: hidden;
    position: relative;
}
</style>

</head>



<body>

<div id='explanation'>
This example shows the 3 grids organized into tabbed panels. Right-click on a grid row to see the popup menu.
</div>

<div id="tabsExample">
   <div>
     <div class="panelheader">Customer Grid</div>
     <div class="panelheader">Order Grid</div>
     <div class="panelheader">Order Detail</div>
   </div>

   <div class="panelContentContainer">
     <div class="panelContent">
<Rico:LiveGrid runat='server' id='customer' caption='Customers' rows='-4' frozenColumns='2' menuEvent='contextmenu' DisplayTimer='false' highlightElem='menuRow'>
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
     </div>

     <div class="panelContent">
<Rico:LiveGrid runat='server' id='order' caption='' rows='-4' menuEvent='contextmenu' DisplayTimer='false' highlightElem='menuRow'>
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
     </div>

     <div class="panelContent">
<Rico:LiveGrid runat='server' id='detail' caption='' rows='-4' menuEvent='contextmenu' DisplayTimer='false' highlightElem='menuRow'>
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
     </div>
   </div>
</div>

</body></html>
