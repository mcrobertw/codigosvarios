<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico SimpleGrid-Example 2</title>

<script src="../../src/prototype.js" type="text/javascript"></script>
<script src="../../src/rico.js" type="text/javascript"></script>
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />

<?php
require "../../plugins/php/SimpleGrid.php";
?>

<script type='text/javascript'>
Rico.loadModule('SimpleGrid','greenHdg.css');

Rico.onLoad( function() {
  var ex1=new Rico.SimpleGrid ('ex1');
});
</script>

<style type="text/css">
div.ricoLG_cell { 
  white-space: nowrap;
  text-align:  center;
  font-size:   12pt;
}
.ricoLG_bottom div.ricoLG_cell {
  height:      1.6em;
}
</style>
</head>


<body>

<?php
$action=isset($_POST["action"]) ? $_POST["action"] : "";
if ($action == "") {
  DisplayForm();
}
else {
  DisplayResult();
}

function DisplayResult() {
  echo "<table id='results' border='1' cellspacing='0' cellpadding='4'>";
  echo "<tr><th>Problem<th>Your answer<th>Result";
  foreach ($_POST as $k => $answer) {
    $a=explode("_",$k);
    switch ($a[0]) {

      case "p":
        CheckResult($a[1], $a[2], $answer, "+", intval($a[1]) + intval($a[2]));
        break;

      case "t":
        CheckResult($a[1], $a[2], $answer, "x", intval($a[1]) * intval($a[2]));
        break;
    }
  }
  echo "</table>";
}

function CheckResult($a, $b, $answer, $operator, $correctAnswer) {
  echo "<tr><td>".$a." ".$operator." ".$b."<td>".$answer."<td>";
  if (trim($answer) == "") {
    echo "no answer";
  }
  elseif (!is_numeric($answer)) {
    echo "not a number";
  }
  elseif (doubleval($answer) == $correctAnswer) {
    echo "correct!";
  }
  else {
    echo "incorrect";
  }
}

function DisplayForm() {
  $grid= new SimpleGrid();
  // define heading
  $grid->AddHeadingRow(true);
  $grid->AddCell("A");
  $grid->AddCell("B");
  $grid->AddCell("A + B");
  $grid->AddCell("A x B");
  // define data
  for ($r=3; $r<=9; $r+=2) {
    $a=$r;
    $b=$r-2;
    $grid->AddDataRow();
    $grid->AddCell($a);
    $grid->AddCell($b);
    $grid->AddCell("<input type='text' size='3' name='p_".$a."_".$b."'>");
    $grid->AddCell("<input type='text' size='3' name='t_".$a."_".$b."'>");
  }

  echo "<div id='explanation'>This example shows how to use a SimpleGrid within a form.</div>";
  echo "<p><strong>Try this simple math quiz:</strong>";
  echo "<p><form method='post'>";
  echo "<input type='hidden' name='action' value='calc_result'>";
  echo "<input type='submit' value='Submit Answers'><p>";

  $grid->Render("ex1", 2);

  echo "</form>";
}
?>


</body>
</html>
