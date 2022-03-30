<?php ob_start(); ?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico SimpleGrid-Example 1</title>

<script src="../../src/prototype.js" type="text/javascript"></script>
<script src="../../src/rico.js" type="text/javascript"></script>
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />

<?php
require "../../plugins/php/SimpleGrid.php";
?>

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
Compare it to ex1simple.php - which is a LiveGrid.
</div>

<div>
<button onclick="ExportGridClient('plain')">Export from client to HTML Table</button>
<button onclick="ExportGridClient('owc')" id="owc">Export from client to OWC spreadsheet</button>
<button onclick="ExportGridServer('xl')">Export from server to Excel</button>
<button onclick="ExportGridServer('csv')">Export from server to CSV</button>
</div>

<?php
$numcol=15;
$grid=new SimpleGrid();

$grid->AddHeadingRow(true);
for ($c=1; $c<=$numcol; $c++) {
  $grid->AddCell("Column $c");
}

for ($r=1; $r<=100; $r++) {
  $grid->AddDataRow();
  $grid->AddCell($r);
  for ($c=2; $c<=$numcol; $c++) {
    $grid->AddCell("Cell $r:$c");
  }
}

$fmt=isset($_GET["fmt"]) ? $_GET["fmt"] : "";
switch (strtolower($fmt)) {
  case "xl": 
    $grid->RenderExcel("rico.xls");
    break;
  case "csv":
    $grid->RenderDelimited("rico.csv", ",", "");
    break;
  default:
    $grid->Render("ex1", 1);   // output html
    break;
}

?>

</body>
</html>

