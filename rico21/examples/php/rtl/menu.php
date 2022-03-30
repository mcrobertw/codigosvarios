<?php
$curscript=basename($_SERVER['SCRIPT_NAME']);
$scripts=array("ex1.php","ex2.php");
print "<strong style='color:brown;'>Rico LiveGrid - RTL Examples</strong>";
print "\n<table border='0' cellpadding='5'>\n<tr>";
print "<td><a href='../../'>Examples Home</a></td>";
foreach ($scripts as $k => $v) {
  $k++;
  if ($v==$curscript)
    print "<td><strong style='border:1px solid brown;color:brown;'>Ex $k</strong></td>";
  else
    print "<td><a href='$v'>Ex $k</a></td>";
}
print "</tr>\n</table>";
?>
