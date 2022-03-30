<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html dir="rtl">
<head>
<title>Rico LiveGrid-Example 1</title>

<?php
require "chklang.php";
require "settings.php";
?>

<script src="../../../src/rico.js" type="text/javascript"></script>
<link href="../../client/css/demo.css" type="text/css" rel="stylesheet" />
<script type='text/javascript'>
Rico.loadModule('LiveGrid');
Rico.loadModule('LiveGridMenu');
<?php
setStyle();
setLang();
?>

Rico.onLoad( function() {
  var opts = {  
    <? GridSettingsScript(); ?>,
    columnSpecs   : ['specQty']
  };
  var ex1=new Rico.LiveGrid ('ex1', new Rico.Buffer.Base($('ex1').tBodies[0]), opts);
  ex1.menu=new Rico.GridMenu(<? GridSettingsMenu(); ?>);
});
</script>

</head>

<body>

<?php
require "menu.php";

print "<table id='explanation' border='0' cellpadding='0' cellspacing='5' style='clear:both'><tr valign='top'><td>";
GridSettingsForm();
?>
</td><td>This example demonstrates a pre-filled grid (no AJAX data fetches). 
LiveGrid Plus just provides scrolling, column resizing, and sorting capabilities.
The first column sorts numerically, the others sort in text order.
Use the panel to the left to change grid settings.
Filtering is not supported on pre-filled grids.
</td></tr></table>

<p class="ricoBookmark"><span id="ex1_bookmark">&nbsp;</span></p>
<table id="ex1" class="ricoLiveGrid" cellspacing="0" cellpadding="0">
<colgroup>
<?php
$numcol=15;
for ($c=1; $c<=$numcol; $c++) {
  print "<col style='width:80px;' />";
}
?>
</colgroup>
<thead><tr>
<?php
for ($c=1; $c<=$numcol; $c++) {
  print "<th>Column $c</th>";
}
?>
</tr></thead><tbody>
<?php
for ($r=1; $r<=100; $r++) {
  print "<tr>";
  print "<td>$r</td>";
  for ($c=2; $c<=$numcol; $c++) {
    print "<td>Cell $r:$c</td>";
  }
  print "</tr>";
}
?>
</tbody></table>

<!--
<textarea id='ex1_debugmsgs' rows='5' cols='80' style='font-size:smaller;'></textarea>
-->

</body>
</html>

