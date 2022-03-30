<?php
if (!isset ($_SESSION)) session_start();
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico LiveGrid-Example 2</title>

<?php
session_set_cookie_params(60*60);
$_SESSION['ex2']="select OrderID,CustomerID,ShipName,ShipCity,ShipCountry,OrderDate,ShippedDate from orders order by OrderID";
?>

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../../src/css/greenHdg.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />
<?php
require "chklang2.php";
?>
<script type='text/javascript'>
var orderGrid,buffer;

Rico.onLoad( function() {
  var opts = {  
    visibleRows: -3,
    columnSpecs: [,,,,,{type:'date'},{type:'date'}]
  };
  buffer=new Rico.Buffer.AjaxJSON('ricoJSONquery.php', {TimeOut:<?php print array_shift(session_get_cookie_params())/60 ?>});
  orderGrid=new Rico.LiveGrid ('ex2', buffer, opts);
  orderGrid.menu=new Rico.GridMenu();
});

</script>

<style type="text/css">
div.ricoLG_cell {
  white-space:nowrap;
}
</style>
</head>

<body>
<p id='explanation'>This example uses AJAX to fetch order data, as required, from the server. 
In other examples, data is returned in XML format. In this example, data is returned in 
<a href='http://www.json.org/'>JSON</a> format.
<a href='ricoJSONquery.php?id=ex2&offset=0&page_size=10&get_total=true'>View the AJAX response (JSON)</a>.

<p class="ricoBookmark"><span id='ex2_timer' class='ricoSessionTimer'></span><span id="ex2_bookmark">&nbsp;</span></p>
<table id="ex2" class="ricoLiveGrid" cellspacing="0" cellpadding="0">
<colgroup>
<col style='width:40px;' >
<col style='width:60px;' >
<col style='width:150px;'>
<col style='width:120px;' >
<col style='width:90px;' >
<col style='width:100px;'>
<col style='width:100px;'>
</colgroup>
  <tr>
	  <th>Order#</th>
	  <th>Customer#</th>
	  <th>Ship Name</th>
	  <th>Ship City</th>
	  <th>Ship Country</th>
	  <th>Order Date</th>
	  <th>Ship Date</th>
  </tr>
</table>

<!--
<textarea id='ex2_debugmsgs' rows='5' cols='100' style='font-size:x-small;'></textarea>
-->

</body>
</html>

