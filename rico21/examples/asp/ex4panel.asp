<%@ LANGUAGE="VBSCRIPT" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico LiveGrid-Example 4</title>

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../../src/css/grayedout.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />
<!-- #INCLUDE FILE = "chklang2.vbs" --> 
<%
session.contents("customergrid")="select CustomerID,CompanyName,ContactName,Address,City,Region,PostalCode,Country,Phone,Fax from customers order by CustomerID"
session.contents("ordergrid")="select CustomerID,OrderID,ShipName,ShipCity,ShipCountry,OrderDate,ShippedDate from orders order by OrderID"
session.contents("detailgrid")="select OrderID,p.ProductName,QuantityPerUnit,od.UnitPrice,Quantity,od.UnitPrice*Quantity as Total,Discount,od.UnitPrice*Quantity*(1.0-Discount) as NetPrice from order_details od left join products p on od.ProductID=p.ProductID order by od.ProductID"
%>

<script type='text/javascript'>
var grids=[];

Rico.onLoad( function() {
  var options={panelHeight:200, hoverClass: 'panelHover', selectedClass: 'panelSelected', border: '#000000', color:'#E0E8FA', onFirstSelect: PanelSelected};
  new Rico.TabbedPanel( $$('div.panelheader'), $$('div.panelContent'), options);

  var opts = {  columnSpecs   : [
                  { Hdg: "Cust ID", width: 60 },
                  { Hdg: "Company", width: 220 },
                  { Hdg: "Contact", width: 120 },
                  { Hdg: "Address", width: 200 },
                  { Hdg: "City", width: 110 },
                  { Hdg: "Region", width: 50 },
                  { Hdg: "Postal Code", width: 80 },
                  { Hdg: "Country", width: 90 },
                  { Hdg: "Phone", width: 110 },
                  { Hdg: "Fax", width: 110 }
                ],
                frozenColumns : 2,
                menuEvent     : 'contextmenu',
                highlightElem : 'menuRow',
                windowResize  : false,
                visibleRows   : 'parent'
             };
  grids[0]=new Rico.LiveGrid ('customergrid', new Rico.Buffer.AjaxSQL('ricoXMLquery.asp'), opts);
  grids[0].menu=new Rico.GridMenu();

  var opts = {  columnSpecs   : [
                  { Hdg: "Order #", width: 60 },
                  { Hdg: "Cust ID", width: 60 },
                  { Hdg: "Ship Name", width: 180 },
                  { Hdg: "Ship City", width: 120 },
                  { Hdg: "Ship Country", width: 90 },
                  { Hdg: "Order Date", width: 90, type:'date' },
                  { Hdg: "Ship Date", width: 90, type:'date' }
                ],
                menuEvent     : 'contextmenu',
                highlightElem : 'menuRow',
                windowResize  : false,
                visibleRows   : 'parent'
             };
  grids[1]=new Rico.LiveGrid ('ordergrid', new Rico.Buffer.AjaxSQL('ricoXMLquery.asp'), opts);
  grids[1].menu=new Rico.GridMenu();

  var opts = {  columnSpecs   : [
                  { Hdg: "Order #", width: 60 },
                  { Hdg: "Product", width: 220 },
                  { Hdg: "Unit Quantity", width: 125 },
                  { Hdg: "Unit Price", width: 80, format: 'DOLLAR' },
                  { Hdg: "Qty", width: 50, format: 'QTY' },
                  { Hdg: "Total", width: 80, format: 'DOLLAR' },
                  { Hdg: "Discount", width: 80, format: 'PERCENT' },
                  { Hdg: "Net Price", width: 90, format: 'DOLLAR' }
                ],
                menuEvent     : 'contextmenu',
                highlightElem : 'menuRow',
                windowResize  : false,
                visibleRows   : 'parent'
             };
  grids[2]=new Rico.LiveGrid ('detailgrid', new Rico.Buffer.AjaxSQL('ricoXMLquery.asp'), opts);
  grids[2].menu=new Rico.GridMenu();
});

function PanelSelected(element, index) {
  // panel's tab has been clicked, but the content panel has not been made visible yet, so wait a few ticks before doing anything
  if (grids[index]) setTimeout(PanelSelected2.bind(this,index),50);
}

function PanelSelected2(index) {
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
        <p class="ricoBookmark"><span id="customergrid_bookmark">&nbsp;</span></p>
        <div id="customergrid"></div>
     </div>

     <div class="panelContent">
        <p class="ricoBookmark"><span id="ordergrid_bookmark">&nbsp;</span></p>
        <div id="ordergrid"></div>
     </div>

     <div class="panelContent">
        <p class="ricoBookmark"><span id="detailgrid_bookmark">&nbsp;</span></p>
        <div id="detailgrid"></div>
     </div>
   </div>
</div>

</body>
</html>

