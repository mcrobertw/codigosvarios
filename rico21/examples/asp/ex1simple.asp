<%@ LANGUAGE="VBSCRIPT" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico LiveGrid-Example 1</title>

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../../src/css/greenHdg.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />
<!-- #INCLUDE FILE = "chklang2.vbs" --> 

<script type='text/javascript'>
Rico.onLoad( function() {
  alert('We are stopping here, at the start of the onload event, to show you that the grid is populated with data from a regular HTML table. This is what browsers with javascript disabled would display.');
  var opts = {  
    defaultWidth : 90,
    useUnformattedColWidth: false,
    columnSpecs  : ['specQty']  // display first column as a numeric quantity
  };
  var ex1=new Rico.LiveGrid ('ex1', new Rico.Buffer.Base($('ex1').tBodies[0]), opts);
  ex1.menu=new Rico.GridMenu();
});
</script>


</head>

<body>
<p class="ricoBookmark"><span id="ex1_bookmark">&nbsp;</span></p>
<table id="ex1" class="ricoLiveGrid" cellspacing="0" cellpadding="0">
<thead><tr>
<%
const numcol=15
for c=1 to numcol
  response.write "<th>Column " & c & "</th>"
next
%>
</tr></thead><tbody>
<%
for r=1 to 100
  response.write vbLf & "<tr>"
  response.write "<td>" & r & "</td>"
  for c=2 to numcol
    response.write "<td>Cell " & r & ":" & c & "</td>"
  next
  response.write "</tr>"
next
%>
</tbody></table>

</body>
</html>

