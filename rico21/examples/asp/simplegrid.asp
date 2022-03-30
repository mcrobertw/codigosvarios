<%@ LANGUAGE="VBSCRIPT" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico SimpleGrid-Example 1</title>

<script src="../../src/prototype.js" type="text/javascript"></script>
<script src="../../src/rico.js" type="text/javascript"></script>
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />

<!-- #INCLUDE FILE = "../../plugins/asp/SimpleGrid.vbs" -->

<script type='text/javascript'>
Rico.loadModule('SimpleGrid','greenHdg.css');

var ex1;
Rico.onLoad( function() {
  var opts = {  
    columnSpecs   : ['specQty']  // display first column as a numeric quantity
  };
  ex1=new Rico.SimpleGrid ('ex1', opts);
  if (!Prototype.Browser.IE) $('owc').disabled=true;
});

function ExportGridClient(ExportType) {
  ex1.printVisible(ExportType);
}

function ExportGridServer(ExportType) {
  if (Prototype.Browser.IE) {
    location.href+='?fmt='+ExportType;
  } else {
    window.open(location.href+'?fmt='+ExportType);
  }
}
</script>

</head>

<body>

<div id='explanation'>
This grid was created using the <a href='../grids.html'>SimpleGrid</a> plug-in!
Compare it to ex1simple.asp - which is a LiveGrid.
</div>

<div>
<button onclick="ExportGridClient('plain')">Export from client to HTML Table</button>
<button onclick="ExportGridClient('owc')" id="owc">Export from client to OWC spreadsheet</button>
<button onclick="ExportGridServer('xl')">Export from server to Excel</button>
<button onclick="ExportGridServer('csv')">Export from server to CSV</button>
</div>

<%
dim grid,r,c
const numcol=15

set grid=new SimpleGrid  ' create instance of class

' define heading
grid.AddHeadingRow true
for c=1 to numcol
  grid.AddCell "Column " & c
next

' define data
for r=1 to 100
  grid.AddDataRow
  grid.AddCell r
  for c=2 to numcol
    grid.AddCell "Cell " & r & ":" & c
  next
next

select case lcase(Request.QueryString("fmt"))
  case "xl":  grid.RenderExcel "rico.xls"
  case "csv": grid.RenderDelimited "rico.csv", ",", ""
  case else:  grid.Render "ex1", 1   ' output html
end select
set grid=Nothing       ' clean up
%>

</body>
</html>

