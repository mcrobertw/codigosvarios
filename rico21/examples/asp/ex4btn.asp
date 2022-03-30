<%@ LANGUAGE="VBSCRIPT" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico LiveGrid-Example 4</title>

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../../src/css/grayedout.css" type="text/css" rel="stylesheet" />
<!-- #INCLUDE FILE = "chklang2.vbs" --> 
<%
session.contents("ex4customer")="select CustomerID,CompanyName,ContactName,Address,City,Region,PostalCode,Country,Phone,Fax from customers order by CustomerID"
session.contents("ex4order")="select OrderID,CustomerID,ShipName,ShipCity,ShipCountry,OrderDate,ShippedDate from orders order by OrderID"
session.contents("ex4detail")="select OrderID,p.ProductName,QuantityPerUnit,od.UnitPrice,Quantity,od.UnitPrice*Quantity as Total,Discount,od.UnitPrice*Quantity*(1.0-Discount) as NetPrice from order_details od left join products p on od.ProductID=p.ProductID order by OrderID,od.ProductID"
%>

<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />
<script type='text/javascript'>
var ex4_grid,ex4_buffer,options={};
options['customer'] = {
  frozenColumns : 1,
  highlightElem : 'cursorRow',
  columnSpecs   : [
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
  ]
};
options['order'] = {
  frozenColumns : 1,
  highlightElem : 'cursorRow',
  columnSpecs   : [
    { Hdg: "Order #", width: 60 },
    { Hdg: "Cust ID", width: 60 },
    { Hdg: "Ship Name", width: 180 },
    { Hdg: "Ship City", width: 120 },
    { Hdg: "Ship Country", width: 90 },
    { Hdg: "Order Date", width: 90, type:'date' },
    { Hdg: "Ship Date", width: 90, type:'date' }
  ]
};
options['detail'] = {
  frozenColumns : 1,
  highlightElem : 'cursorRow',
  columnSpecs   : [
    { Hdg: "Order #", width: 60 },
    { Hdg: "Product", width: 220 },
    { Hdg: "Unit Quantity", width: 125 },
    { Hdg: "Unit Price", width: 80, format: 'DOLLAR' },
    { Hdg: "Qty", width: 50, format: 'QTY' },
    { Hdg: "Total", width: 80, format: 'DOLLAR' },
    { Hdg: "Discount", width: 80, format: 'PERCENT' },
    { Hdg: "Net Price", width: 90, format: 'DOLLAR' }
  ]
};

function newGrid(TableName) {
  if (ex4_grid) {
    //ex4_grid.unplugSelect();
    //ex4_grid.unplugScroll();
    //ex4_grid.unplugWindowResize();
    //ex4_grid.unplugHighlightEvents();
    if (Event.unloadCache) {
      Event.unloadCache();   // this does all of the "unplugs", and is critical to enable memory to be released
    } else if (Event.destroyCache) {
      Event.destroyCache();  // unloadCache was removed from Prototype 1.6
    }
    ex4_buffer.clear();
  }
  var outerDiv=$('ex4_outerDiv');
  outerDiv.innerHTML='';
  ex4_buffer=null;
  ex4_grid=null;
  ex4_buffer=new Rico.Buffer.AjaxSQL('ricoXMLquery.asp', { requestParameters: ['id=ex4'+TableName] }); // override the id sent in the ajax request
  ex4_grid=new Rico.LiveGrid ('ex4', ex4_buffer, options[TableName]);
  ex4_grid.menu = new Rico.GridMenu();
}

</script>

</head>

<body>
<table id='explanation' border='0' cellpadding='0' cellspacing='5' style='clear:both'><tr valign='top'><td>
</td><td>This example shows how a grid can be created and destroyed dynamically. Click on each button to see the different grids. Double-click on a grid row to see the popup menu.
</td></tr></table>

<p>
<button onclick='newGrid("customer")'>Customer Grid</button>
<button onclick='newGrid("order")'>Order Grid</button>
<button onclick='newGrid("detail")'>Order Detail Grid</button>
</p>

<p class="ricoBookmark"><span id='ex4_timer' class='ricoSessionTimer'></span><span id="ex4_bookmark">&nbsp;</span></p>
<div id="ex4_outerDiv"></div>

</body>
</html>

