<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico-Table List</title>

<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />

<style type="text/css">
html, body {
  height:97%;
  margin: 0px;
  padding: 0px;
  border: none;
}

#tablist {
  height:100%;
  width:25%;
  overflow:auto;
  float:left;
  border: 1px solid #EEE;
  font-size:smaller;
}

#detail {
  height:100%;
  width:70%;
  float:left;
  border: 1px solid #EEE;
}
</style>
</head>

<body>

<div id='tablist'>
<p><strong>Rico Raw Data Viewer</strong>
<?php
require "applib.php";

OpenDB();
DisplaysObjects("TABLE");
DisplaysObjects("VIEW");
CloseApp();

function DisplaysObjects($ObjType) {
  global $oDB;
  $arTables=$oDB->GetTableList($ObjType);
  echo "<p><strong>" . $ObjType . "S</strong>";
  if (!is_array($arTables)) return;
  echo "<ul>";
  foreach ($arTables as $tabName) {
    echo "<li><a href='RicoDbViewerDetail.php?id=".$tabName."' target='detail'>".$tabName."</a>";
  }
  echo "</ul>";
}
?>
</div>

<iframe id='detail' name='detail'>

</body>
</html>
