<?php
if (!isset ($_SESSION)) session_start();
header("Cache-Control: no-cache");
header("Pragma: no-cache");
header("Expires: ".gmdate("D, d M Y H:i:s",time()+(-1*60))." GMT");
header('Content-type: text/html; charset=utf-8');
?>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico LiveGrid-Example 4 (editable)</title>

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../../src/css/greenHdg.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />
<?php
require "applib.php";
require "../../plugins/php/ricoLiveGridForms.php";
?>

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
  font-size: 8pt !important;
  height: 12px;
  white-space: nowrap;
}
</style>
</head>



<body>

<?php
//************************************************************************************************************
//  LiveGrid-Edit Example
//************************************************************************************************************
//  Matt Brown
//************************************************************************************************************
if (OpenGridForm("", "customers")) {
  $orderTE=OpenTableEdit("orders");
  $detailTE=OpenTableEdit("order_details");
  if ($oForm->action != "table") {
    DefineCustTable();
  }
  elseif ($orderTE->action != "table") {
    DefineOrderTable();
  }
  elseif ($detailTE->action != "table") {
    DefineDetailTable();
  }
  else {
    DisplayAllTables();
  }
}
CloseApp();

function DisplayAllTables() {
  echo "<table border='0' cellspacing='3' style='height:99%; width:99%; margin:0px;'>";
  echo "<col width='25%'>";
  echo "<tr valign='top'>";
  echo "<td rowspan='3'>";
  echo "<div id='description'>";
  echo "Double-click on a row to see all orders for that customer.";
  echo "<p>Drag the edge of a column heading to resize a column.";
  echo "<p>To filter: right-click (ctrl-click in Opera, Konqueror, or Safari) on the value that you would like to use as the basis for filtering, then select the desired filtering method from the pop-up menu.";
  echo "<p>Right-click anywhere in a column to see sort, hide, and show options.";
  echo "<p>Notice that filters and sorting in the customer grid persist after a refresh. The saveColumnInfo option specifies that these values should be saved in cookies.";
  echo "</div></td><td class='gridcontainer' height='33%'>";
  DefineCustTable();
  echo "</td><tr height='33%'><td class='gridcontainer'>";
  DefineOrderTable();
  echo "</td><tr height='33%'><td class='gridcontainer'>";
  DefineDetailTable();
  createInitScript();
  echo "</td></tr></table>";
  //response.write "<p><textarea id='orders_debugmsgs' rows='5' cols='80' style='font-size:smaller;'></textarea>"
}

function createInitScript() {
  global $oForm;
  echo "\n<script language='javascript' type='text/javascript'>";
  echo "\nfunction drillDown1(e) {";
  echo "\n".$oForm->formVar.".drillDown(e,0,0,".$GLOBALS['orderTE']->formVar.");";
  echo "\n".$GLOBALS['detailTE']->gridVar.".resetContents();";
  echo "\n}";
  echo "\nfunction drillDown2(e) {";
  echo "\n".$GLOBALS['orderTE']->formVar.".drillDown(e,1,0,".$GLOBALS['detailTE']->formVar.");";
  echo "\n}";
  echo "\nfunction ".$oForm->gridID."_GridInit() {";
  echo "\n  var cal=new Rico.CalendarControl('Cal');";
  echo "\n  RicoEditControls.register(cal, Rico.imgDir+'calarrow.png');";
  echo "\n  ".$oForm->optionsVar.".dblclick=drillDown1;";
  echo "\n  ".$GLOBALS['orderTE']->optionsVar.".dblclick=drillDown2;";
  echo "\n  ".$GLOBALS['orderTE']->InitScript();
  echo "\n  ".$GLOBALS['detailTE']->InitScript();
  echo "\n}";
  echo "\n</script>";
}

function DefineCustTable() {
  global $oForm;
  $oForm->options["RecordName"]="Customer";
  $oForm->options["visibleRows"]="parent";
  $oForm->options["frozenColumns"]=2;
  $oForm->options["highlightElem"]="menuRow";
  $oForm->options["menuEvent"]="contextmenu";
  $oForm->AddEntryFieldW("CustomerID", "Cust ID", "B", "<auto>", 60);
  $oForm->ConfirmDeleteColumn();
  $oForm->SortAsc();
  $oForm->AddEntryFieldW("CompanyName", "Company Name", "B", "", 220);
  $oForm->AddEntryFieldW("ContactName", "Contact", "B", "", 120);
  $oForm->AddEntryFieldW("Address", "Address", "B", "", 200);
  $oForm->AddEntryFieldW("City", "City", "B", "", 110);
  $oForm->AddEntryFieldW("Region", "Region", "N", "", 50);
  $oForm->AddEntryFieldW("PostalCode", "Postal Code", "B", "", 80);
  $oForm->AddEntryFieldW("Country", "Country", "N", "", 90);
  $oForm->AddEntryFieldW("Phone", "Phone", "B", "", 110);
  $oForm->AddEntryFieldW("Fax", "Fax", "B", "", 110);
  //oForm.AutoInit=false
  $oForm->DisplayPage();
}

function DefineOrderTable() {
  global $oDB;
  $GLOBALS['orderTE']->options["RecordName"]="Order";
  $GLOBALS['orderTE']->options["frozenColumns"]=2;
  $GLOBALS['orderTE']->options["prefetchBuffer"]=false;
  $GLOBALS['orderTE']->options["visibleRows"]=4;
  $GLOBALS['orderTE']->options["highlightElem"]="menuRow";
  $GLOBALS['orderTE']->options["menuEvent"]="contextmenu";
  $GLOBALS['orderTE']->AutoInit=false;
  $GLOBALS['orderTE']->AddEntryFieldW("CustomerID", "Cust ID", "B", "<auto>", 60);
  $GLOBALS['orderTE']->CurrentField["InsertOnly"]=true;  // do not allow customer to be changed once an order is entered
  $GLOBALS['orderTE']->AddPanel("Basic Info");
  $GLOBALS['orderTE']->AddEntryFieldW("OrderID", "Order ID", "B", "<auto>", 60);
  $GLOBALS['orderTE']->ConfirmDeleteColumn();
  $GLOBALS['orderTE']->SortAsc();
  $GLOBALS['orderTE']->AddEntryFieldW("EmployeeID", "Sales Person", "SL", "", 140);
  $GLOBALS['orderTE']->CurrentField["SelectSql"]="select EmployeeID,".$oDB->concat(array("LastName", "', '", "FirstName"), false)." from employees order by LastName,FirstName";
  $GLOBALS['orderTE']->AddEntryFieldW("OrderDate", "Order Date", "D", strftime('%Y-%m-%d'), 90);
  $GLOBALS['orderTE']->CurrentField["SelectCtl"]="Cal";
  $GLOBALS['orderTE']->CurrentField["min"]="1995-01-01";
  $GLOBALS['orderTE']->CurrentField["max"]=strftime('%Y-%m-%d');
  $GLOBALS['orderTE']->AddEntryFieldW("RequiredDate", "Required Date", "D", strftime('%Y-%m-%d'), 90);
  $GLOBALS['orderTE']->CurrentField["SelectCtl"]="Cal";
  $GLOBALS['orderTE']->CurrentField["min"]="1995-01-01";
  $GLOBALS['orderTE']->AddCalculatedField("select sum(UnitPrice*Quantity*(1.0-Discount)) from order_details d where d.OrderID=t.OrderID", "Net Sale");
  $GLOBALS['orderTE']->CurrentField["format"]="DOLLAR";
  $GLOBALS['orderTE']->CurrentField["width"]=80;
  $GLOBALS['orderTE']->AddPanel("Ship To");
  $GLOBALS['orderTE']->AddEntryFieldW("ShipName", "Name", "B", "", 140);
  $GLOBALS['orderTE']->AddEntryFieldW("ShipAddress", "Address", "B", "", 140);
  $GLOBALS['orderTE']->AddEntryFieldW("ShipCity", "City", "B", "", 120);
  $GLOBALS['orderTE']->AddEntryFieldW("ShipRegion", "Region", "T", "", 60);
  $GLOBALS['orderTE']->AddEntryFieldW("ShipPostalCode", "Postal Code", "T", "", 100);
  $GLOBALS['orderTE']->AddEntryFieldW("ShipCountry", "Country", "N", "", 100);
  $GLOBALS['orderTE']->DisplayPage();
}

function DefineDetailTable() {
  $GLOBALS['detailTE']->options["RecordName"]="Line Item";
  $GLOBALS['detailTE']->options["frozenColumns"]=2;
  $GLOBALS['detailTE']->options["prefetchBuffer"]=false;
  $GLOBALS['detailTE']->options["visibleRows"]=4;
  $GLOBALS['detailTE']->options["highlightElem"]="menuRow";
  $GLOBALS['detailTE']->options["menuEvent"]="contextmenu";
  $GLOBALS['detailTE']->AutoInit=false;
  $GLOBALS['detailTE']->AddEntryFieldW("OrderID", "Order ID", "I", "<auto>", 60);
  $GLOBALS['detailTE']->AddEntryFieldW("ProductID", "Product", "SL", "", 140);
  $GLOBALS['detailTE']->SortAsc();
  $GLOBALS['detailTE']->CurrentField["SelectSql"]="select ProductID,ProductName from products order by ProductName";
  $GLOBALS['detailTE']->AddEntryFieldW("UnitPrice", "Unit Price", "F", "", 80);
  $GLOBALS['detailTE']->CurrentField["format"]="DOLLAR";
  $GLOBALS['detailTE']->CurrentField["min"]=0.01;
  $GLOBALS['detailTE']->CurrentField["max"]=999.99;
  $GLOBALS['detailTE']->AddEntryFieldW("Quantity", "Quantity", "I", "1", 80);
  $GLOBALS['detailTE']->CurrentField["format"]="QTY";
  $GLOBALS['detailTE']->CurrentField["min"]=1;
  $GLOBALS['detailTE']->CurrentField["max"]=999;
  $GLOBALS['detailTE']->AddEntryFieldW("Discount", "Discount", "F", "0", 80);
  $GLOBALS['detailTE']->CurrentField["format"]="PERCENT";
  $GLOBALS['detailTE']->CurrentField["min"]=0.0;
  $GLOBALS['detailTE']->CurrentField["max"]=0.5;
  $GLOBALS['detailTE']->DisplayPage();
}
?>


</body>
</html>
