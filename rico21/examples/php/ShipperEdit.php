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
<title>Rico LiveGrid-Shippers (editable)</title>

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../../src/css/grayedout.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />

<?php
require "applib.php";
require "../../plugins/php/ricoLiveGridForms.php";
?>

<style type="text/css">
div.ricoLG_cell {
  white-space:nowrap;
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
if (OpenGridForm("", "shippers")) {
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
  echo "</td><td>This example demonstrates how database records can be updated via AJAX. ";
  echo "Try selecting add, edit, or delete from the pop-up menu. ";
  echo "</td></tr></table>";
  echo "<p><strong>Shippers Table</strong></p>";
  DefineFields();
  //echo "<p><textarea id='shippers_debugmsgs' rows='5' cols='80' style='font-size:smaller;'></textarea>";
}

function DefineFields() {
  global $oForm,$oDB;

  $oForm->AddEntryFieldW("ShipperID", "ID", "B", "<auto>",50);
  $oForm->AddEntryFieldW("CompanyName", "Company Name", "B", "", 150);
  $oForm->ConfirmDeleteColumn();
  $oForm->SortAsc();
  $oForm->AddEntryFieldW("Phone", "Phone Number", "B", "", 150);

  $oForm->DisplayPage();
}
?>

</body>
</html>
