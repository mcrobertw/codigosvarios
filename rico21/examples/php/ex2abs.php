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
  var popup=new Rico.Popup({ hideOnClick: false, canDragFunc: true });
  popup.createWindow('Grid Window (drag me)','','390px','500px');
  popup.contentDiv.appendChild($('ex2'));
  popup.openPopup(50,100);

  var grid_options = {  
    visibleRows : 'parent',
    useUnformattedColWidth: false,
    columnSpecs : [{width:60},{width:60},{width:150},,,{type:'date'},{type:'date'}]
  };
  buffer=new Rico.Buffer.AjaxSQL('ricoXMLquery.php', {TimeOut:<?php print array_shift(session_get_cookie_params())/60 ?>});
  orderGrid=new Rico.LiveGrid ('ex2', buffer, grid_options);
  orderGrid.menu = new Rico.GridMenu();
});

function testMsg() {
  orderGrid.showMsg('testing...');
}

</script>

<style type="text/css">
div.ricoWindow {
  border: 2px solid black;
}
div.ricoWindow div.ricoTitle {
  padding: 3px;
  color: white;
  background-color: black;
  font-weight: bold;
  font-size: smaller;
}
div.ricoWindow div.ricoContent {
  background-color: #AAF;
  margin: 0px;
  overflow: hidden !important;  /* for Safari */
}
div.ricoLG_cell {
  white-space:nowrap;
}
#background {
  color:#CCC; 
  font-size:24pt; 
  font-family: Times New Roman;
}
</style>
</head>

<body>

<p id='explanation'>This example demonstrates a LiveGrid inside an absolutely positioned &lt;div&gt;. 
Setting options.visibleRows to 'parent' (or -4) makes this possible.

<p>&nbsp;

<!-- just some text to show that the div containing the grid has position:absolute -->
<p id='background'>
Lorem ipsum dolor sit amet, consectetur adipisicing elit, 
sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris 
nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in 
reprehenderit in voluptate velit esse cillum dolore eu fugiat 
nulla pariatur. Excepteur sint occaecat cupidatat non proident, 
sunt in culpa qui officia deserunt mollit anim id est laborum.

<table id="ex2" class="ricoLiveGrid" cellspacing="0" cellpadding="0">
  <tr id='ex2_main'>
	  <th>Order#</th>
	  <th>Cust#</th>
	  <th>Ship Name</th>
	  <th>Ship City</th>
	  <th>Ship Country</th>
	  <th>Order Date</th>
	  <th>Ship Date</th>
  </tr>
</table>

</body>
</html>

