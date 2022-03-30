<%@ LANGUAGE="VBSCRIPT" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico LiveGrid-Example 2</title>

<%
session.contents("ex2")="select OrderID,CustomerID,ShipName,ShipCity,ShipCountry,OrderDate,ShippedDate from orders order by OrderID"
%>
<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../../src/css/greenHdg.css" type="text/css" rel="stylesheet" />
<!-- #INCLUDE FILE = "chklang2.vbs" --> 

<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />
<script type='text/javascript'>
var orderGrid,buffer;

Rico.onLoad( function() {
  var grid_opts = {  
    columnSpecs   : [,,,,,{type:'date'},{type:'date'}]
  };
  var buffer_opts = {
    requestParameters:[{name:'get_total',value:'false'}],
    TimeOut:<%=Session.Timeout%>
  };
  buffer=new Rico.Buffer.AjaxSQL('ricoXMLquery.asp', buffer_opts);
  orderGrid=new Rico.LiveGrid ('ex2', buffer, grid_opts);
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

<div id='explanation'>
This example uses AJAX to fetch order data as required. 
It shows how the grid reacts when fetching the total # of rows is disabled.
In some situations, this may be desirable for performance reasons.
<pre>
var buffer_opts = {
  requestParameters:[{name:'get_total',value:'false'}]
};
</pre>
</div>

<p class="ricoBookmark"><span id='ex2_timer' class='ricoSessionTimer'></span><span id="ex2_bookmark">&nbsp;</span></p>
<table id="ex2" class="ricoLiveGrid" cellspacing="0" cellpadding="0">
<colgroup>
<col style='width:40px;' >
<col style='width:60px;' >
<col style='width:150px;'>
<col style='width:80px;' >
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

</body>
</html>

