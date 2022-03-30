<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico LiveGrid-Example 1</title>

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />
<?php
require "chklang2.php";
require "settings.php";
?>

<script type='text/javascript'>
<?php
setStyle();
?>

Rico.onLoad( function() {
  var opts = {
    <?php GridSettingsScript(); ?>,
    defaultWidth : 90,
    useUnformattedColWidth: false,
    columnSpecs  : ['specQty']
  };
  var ex1=new Rico.LiveGrid ('ex1', new Rico.Buffer.Base($('ex1').tBodies[0]), opts);
  ex1.menu=new Rico.GridMenu(<?php GridSettingsMenu(); ?>);
});
</script>

</head>

<body>

<table id='explanation' border='0' cellpadding='0' cellspacing='5' style='clear:both'><tr valign='top'><td>
<?php
GridSettingsForm();
?>
</td><td>This example demonstrates a pre-filled grid (no AJAX data fetches). 
LiveGrid just provides scrolling, column resizing, filtering, and sorting capabilities.
The first column sorts numerically, the others sort in text order.
</td></tr></table>

<p class="ricoBookmark"><span id="ex1_bookmark">&nbsp;</span></p>
<table id="ex1" class="ricoLiveGrid" cellspacing="0" cellpadding="0" border="1">
<thead><tr>
<?php
$numcol=15;
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

</body>
</html>

