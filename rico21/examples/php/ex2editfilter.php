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
<title>Rico LiveGrid-Example 2 (editable)</title>
<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />

<?php
$sqltext=".";  // force filtering to "on" in settings box
require "applib.php";
require "../../plugins/php/ricoLiveGridForms.php";
require "settings.php";
?>

<script type='text/javascript'>
<?php
setStyle();
?>

// ricoLiveGridForms will call orders_FormInit right before grid & form initialization.

function orders_FormInit() {
  var cal=new Rico.CalendarControl("Cal");
  RicoEditControls.register(cal, Rico.imgDir+'calarrow.png');
  cal.addHoliday(25,12,0,'Christmas','#F55','white');
  cal.addHoliday(4,7,0,'Independence Day-US','#88F','white');
  cal.addHoliday(1,1,0,'New Years','#2F2','white');
  
  var CustTree=new Rico.TreeControl("CustomerTree","CustTree.php");
  RicoEditControls.register(CustTree, Rico.imgDir+'dotbutton.gif');
}
</script>
<style type="text/css">
div.ricoLG_outerDiv thead .ricoLG_cell, div.ricoLG_outerDiv thead td, div.ricoLG_outerDiv thead th {
	height:1.5em;
}
div.ricoLG_cell {
  white-space:nowrap;
}
</style>
</head>
<body>

<?php
//************************************************************************************************************
//  LiveGrid Plus-Edit Example
//************************************************************************************************************
//  Matt Brown
//************************************************************************************************************
if (OpenGridForm("", "orders")) {
  if ($oForm->action == "table") {
    DisplayTable();
  }
  else {
    DefineFields();
  }
} else {
  echo 'open failed';
}
CloseApp();

function DisplayTable() {
  echo "<table id='explanation' border='0' cellpadding='0' cellspacing='5' style='clear:both'><tr valign='top'><td>";
  GridSettingsForm();
  echo "</td><td>This example demonstrates how database records can be updated via AJAX. ";
  echo "Try selecting add, edit, or delete from the pop-up menu. ";
  echo "If you select add, then click the '...' button next to customer, you will see the Rico tree control.";
  echo "The actual database updates have been disabled for security reasons and result in an error.";
  echo "</td></tr></table>";
  $GLOBALS['oForm']->options["borderWidth"]=0;
  GridSettingsTE($GLOBALS['oForm']);
  //$GLOBALS['oForm']->options["DebugFlag"]=true;
  //$GLOBALS['oDB']->debug=true;
  DefineFields();
  //echo "<p><textarea id='orders_debugmsgs' rows='5' cols='80' style='font-size:smaller;'></textarea>";
}

function DefineFields() {
  global $oForm,$oDB;
  $oForm->options["FilterLocation"]=-1;

  $oForm->AddPanel("Basic Info");
  $oForm->AddEntryField("OrderID", "Order ID", "B", "<auto>");
  $oForm->ConfirmDeleteColumn();
  $oForm->SortAsc();
  $oForm->CurrentField["width"]=50;
  $oForm->AddEntryField("CustomerID", "Customer", "CL", "");
  $oForm->CurrentField["SelectSql"]="select CustomerID,CompanyName from customers order by CompanyName";
  $oForm->CurrentField["SelectCtl"]="CustomerTree";
  $oForm->CurrentField["InsertOnly"]=true;   // do not allow customer to be changed once an order is entered
  $oForm->CurrentField["width"]=160;
  $oForm->CurrentField["filterUI"]="t";
  $oForm->AddEntryField("EmployeeID", "Sales Person", "SL", "");
  $oForm->CurrentField["SelectSql"]="select EmployeeID,".$oDB->concat(array("LastName", "', '", "FirstName"), false)." from employees order by LastName,FirstName";
  $oForm->CurrentField["width"]=140;
  $oForm->CurrentField["filterUI"]="s";
  $oForm->AddEntryField("OrderDate", "Order Date", "D", strftime('%Y-%m-%d'));
  $oForm->CurrentField["SelectCtl"]="Cal";
  $oForm->CurrentField["width"]=90;
  $oForm->AddEntryField("RequiredDate", "Required Date", "D", strftime('%Y-%m-%d'));
  $oForm->CurrentField["SelectCtl"]="Cal";
  $oForm->CurrentField["width"]=90;
  $oForm->AddCalculatedField("select sum(UnitPrice*Quantity*(1.0-Discount)) from order_details d where d.OrderID=t.OrderID","Net Sale");
  $oForm->CurrentField["format"]="DOLLAR";
  $oForm->CurrentField["width"]=80;

  $oForm->AddPanel("Ship To");
  $oForm->AddEntryFieldW("ShipName", "Name", "B", "",140);
  $oForm->AddEntryFieldW("ShipAddress", "Address", "B", "",140);
  $oForm->AddEntryFieldW("ShipCity", "City", "B", "",120);
  $oForm->CurrentField["filterUI"]="s";
  $oForm->AddEntryFieldW("ShipRegion", "Region", "T", "",60);
  $oForm->AddEntryFieldW("ShipPostalCode", "Postal Code", "T", "",100);
  
  // display ShipCountry with a link to wikipedia
  $colnum=$oForm->AddEntryFieldW("ShipCountry", "Country", "N", "",100);
  //$oForm->CurrentField["type"]="control";  // required in rc1, optional in rc2
  $oForm->CurrentField["control"]="new Rico.TableColumn.link('http://en.wikipedia.org/wiki/{".$colnum."}','_blank')";
  $oForm->CurrentField["filterUI"]="s";

  $oForm->DisplayPage();
}
?>


</body>
</html>
