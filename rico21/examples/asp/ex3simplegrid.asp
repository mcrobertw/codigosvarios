<%@ LANGUAGE="VBSCRIPT" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico SimpleGrid-Example 3</title>

<!-- #INCLUDE FILE = "applib.vbs" --> 
<!-- #INCLUDE FILE = "../../plugins/asp/SimpleGrid.vbs" -->

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../../src/css/greenHdg.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet">
<!-- #INCLUDE FILE = "chklang2.vbs" --> 
<script type='text/javascript'>
var ex3;
Rico.onLoad( function() {
  // filterUI='t' --> text box
  // filterUI='s' --> select list
  var grid_options = {
    useUnformattedColWidth: false,
    FilterLocation:   -1,     // put filter on a new header row
    columnSpecs:  [,,{filterUI:'t',width:150},
                   {filterUI:'t',width:100}, {filterUI:'s',width:100},
                   {type:'date',width:90}, {type:'date',width:90}]
  };
  ex3=new Rico.SimpleGrid ('ex3',grid_options);
});
</script>


<style type="text/css">
input, select { font-weight:normal;font-size:8pt;}
tr.ex3_hdg2 div.ricoLG_cell { 
  height:     1.4em;   /* the text boxes require a little more height than normal */
  text-align: left;
  background-color: #deeecd;
}
.ricoLG_cell {
  white-space: nowrap;
}
</style>
</head>


<body>
<div id='explanation'>
This SimpleGrid demonstrates how filters can be applied as the user types.
Entries in the text boxes are case-insensitive.
Filtering is performed on the client -- responsiveness will vary with the speed of
the client computer, the number of rows in the grid, and the efficiency of the browser.
<pre>
  // filterUI='t' --> text box
  // filterUI='s' --> select list
  var grid_options = {
    useUnformattedColWidth: false,
    FilterLocation:   -1,     // put filter on a new header row
    columnSpecs:  [,,{filterUI:'t',width:150},
                   {filterUI:'t',width:100}, {filterUI:'s',width:100},
                   {type:'date',width:90}, {type:'date',width:90}]
  };
</pre>
</div>

<p><button onclick='ex3.printVisible()'>Export</button>
<%
dim grid,sqltext,rsMain
set grid=new SimpleGrid  ' create instance of class

grid.AddHeadingRow false
grid.AddCell "ID"
grid.AddCell "ID"
grid.AddCell "Shipment"
grid.SetCellAttr "colspan",3
grid.AddCell "Date"
grid.SetCellAttr "colspan",2

grid.AddHeadingRow true
grid.AddCell "Order"
grid.AddCell "Customer"
grid.AddCell "Name"
grid.AddCell "City"
grid.AddCell "Country"
grid.AddCell "Order"
grid.AddCell "Ship"

if OpenDB then
  sqltext="select OrderID,CustomerID,ShipName,ShipCity,ShipCountry,OrderDate,ShippedDate from orders order by OrderID"
  set rsMain = oDB.RunQuery(sqltext)
  while not rsMain.eof
    grid.AddDataRow
    grid.AddCell Server.HTMLEncode(rsMain("OrderID"))
    grid.AddCell Server.HTMLEncode(rsMain("CustomerID"))
    grid.AddCell Server.HTMLEncode(rsMain("ShipName"))
    grid.AddCell Server.HTMLEncode(rsMain("ShipCity"))
    grid.AddCell Server.HTMLEncode(rsMain("ShipCountry"))
    grid.AddCell rsMain("OrderDate")
    grid.AddCell rsMain("ShippedDate")
    rsMain.movenext
  wend
  oDB.rsClose rsMain
end if
grid.Render "ex3", 1   ' output html
set grid=Nothing
%>

</body>
</html>
