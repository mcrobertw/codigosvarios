<%@ LANGUAGE="VBSCRIPT" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico LiveGrid-Example 2</title>

<!-- #INCLUDE FILE = "applib.vbs" --> 
<%
CreateDbClass
session.contents("ex2")= _
  "select OrderID,CustomerID," & _
  oDB.concat(Array(oDB.Convert2Char("OrderDate"),"'<br>'",oDB.Convert2Char("ShippedDate")),false) & ", " & _
  oDB.concat(Array("ShipName","'<br>'","ShipAddress","'<br>'","ShipCity","' '","ShipRegion","' '","ShipCountry"),false) & " " & _
  "from orders order by OrderID"
CloseApp
%>

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../../src/css/greenHdg.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />
<!-- #INCLUDE FILE = "chklang2.vbs" --> 
<script type='text/javascript'>
var orderGrid,buffer;

Rico.onLoad( function() {
  var opts = {  
    columnSpecs: [{ width:60 },
                  { width:60 },
                  { width:140, control:new Rico.TableColumn.MultiLine() },
                  { width:200, control:new Rico.TableColumn.MultiLine() } ]
  };
  buffer=new Rico.Buffer.AjaxSQL('ricoXMLquery.asp', {TimeOut:<%=Session.Timeout%>});
  orderGrid=new Rico.LiveGrid ('ex2', buffer, opts);
  orderGrid.menu = new Rico.GridMenu();
});

</script>

<style type="text/css">
.ricoLG_bottom div.ricoLG_cell {
  height:3.6em;
}
.ricoLG_top div.ricoLG_cell {
  white-space:nowrap;
}
</style>
</head>


<body>
<div id='explanation'>
This example shows how LiveGrid can display multi-line content.
The Rico.TableColumn.MultiLine control overcomes issues when displaying multi-line content in IE6 and IE7.
</div>
<p class="ricoBookmark"><span id='ex2_timer' class='ricoSessionTimer'></span><span id="ex2_bookmark">&nbsp;</span></p>
<table id="ex2" class="ricoLiveGrid">
  <tr id='ex2_main'>
	  <th>Order#</th>
	  <th>Cust#</th>
	  <th>Order/Ship Date</th>
	  <th>Ship To</th>
  </tr>
</table>

</body>
</html>

