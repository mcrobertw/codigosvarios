<?php
if (!isset ($_SESSION)) session_start();
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico-Table Detail</title>

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../../src/css/greenHdg.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />

<?php
require "applib.php";
require "chklang2.php";

$arColumns=array();
$columnlist="";
$colspecs="";
if (isset($_GET["id"]) && OpenDB()) {
  $id=trim($_GET["id"]);
  $arColumns=$oDB->GetColumnInfo($id);
  for ($i=0; $i<count($arColumns); $i++) {
    if (!empty($columnlist)) {
      $columnlist.=",";
      $colspecs.=",";
    }
    $columnlist.=$arColumns[$i]->ColName;
    $colspecs.="{Hdg:'".$arColumns[$i]->ColName."'";
    if ($arColumns[$i]->ColType == "DATETIME") {
      $colspecs.=",type:'datetime'";
    }
    $colspecs.="}";
  }
  $_SESSION[$id]="select ".$columnlist." from ".$id."";
  CloseApp();
}
?>


<script type='text/javascript'>
Rico.onLoad( function() {
  var opts = {  
    useUnformattedColWidth: false,
    columnSpecs: [
<?php
echo $colspecs;
?>
    ]
  };
  var buffer=new Rico.Buffer.AjaxSQL('ricoXMLquery.php', {TimeOut:<?php print array_shift(session_get_cookie_params())/60 ?>});
  var grid=new Rico.LiveGrid ('<?php echo $id; ?>', buffer, opts);
  grid.menu = new Rico.GridMenu();
});
</script>

<style type="text/css">
html { border: none; }
div.ricoLG_cell {
  white-space:nowrap;
}
</style>
</head>


<body>
<p><strong><?php echo $id; ?></strong>
<p class="ricoBookmark"><span id='<?php echo $id; ?>_timer' class='ricoSessionTimer'></span><span id="<?php echo $id; ?>_bookmark">&nbsp;</span></p>
<div id="<?php echo $id; ?>"></div>
</body>
</html>

