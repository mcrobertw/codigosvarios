<%@ LANGUAGE="VBSCRIPT" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico LiveGrid-Example 2</title>

<%
Session.Timeout=60
session.contents("ex2")="select OrderID,CustomerID,ShipName,ShipCity,ShipCountry,OrderDate,ShippedDate from orders order by OrderID"
%>

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />
<!-- #INCLUDE FILE = "chklang2.vbs" --> 

<script type='text/javascript'>
var orderGrid,buffer;

Rico.onLoad( function() {
  var opts = {  
    visibleRows: -3,
    headingSort: 'hover',
    columnSpecs: [,,,,,{type:'date'},{type:'date'}]
  };
  buffer=new Rico.Buffer.AjaxSQL('ricoXMLquery.asp', {TimeOut:<%=Session.Timeout%>});
  orderGrid=new Rico.LiveGrid ('ex2', buffer, opts);
  orderGrid.menu = new Rico.GridMenu();
  var a=location.search.split('=');
  var colorSel=$('colors');
  var v=colorSel.value;
  if (a.length==2) {
    v=a[1];
    var o=colorSel.options;
    for (var i=0; i<o.length; i++)
      if (o[i].value==v) {
        o[i].selected=true;
        break;
      }
  }
  var colors=v.split('_');
  for (var i=0; i<orderGrid.columns.length; i++) {
    var c=orderGrid.columns[i];
    Rico.Color.createGradientV(c.hdrCellDiv,colors[0],colors[1]);
    if (colors.length > 2) c.hdrCellDiv.style.color='#'+colors[2];
  }
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
<p>This example demonstrates how to create a cross-browser gradient background.
<form method='get'>
<p>Pick a color scheme:
<select id='colors' name='colors' onchange='this.form.submit();'>
<option value='ffffff_dcdcdc'>Light Gray</option>
<option value='888888_000000_cccccc'>Black</option>
<option value='0000ff_000000_B274DC'>Midnight Blue</option>
<option value='ffff00_00cc00'>Green Bay</option>
<option value='C7DFDE_5CA2A0_FFFFFF'>Steel Blue</option>
<option value='F7AFB3_EA151E_FFFFFF'>Peppermint</option>
</select>
</p>
</form>
</div>

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
  <tr id='ex2_main'>
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
