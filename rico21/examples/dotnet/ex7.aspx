<%@ Page Language="VB" ResponseEncoding="iso-8859-1" Debug="true" %>
<%@ Register TagPrefix="Rico" TagName="DemoSettings" Src="settings.ascx" %>
<%@ Register TagPrefix="Rico" TagName="ChkLang" Src="chklang.ascx" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico LiveGrid-Example 7</title>

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />

<script type='text/javascript'>
<%= settingsCtl.StyleInclude %>
</script>
<Rico:ChkLang runat='server' id='translation' />

<script type='text/javascript'>

var grid,buffer;

Rico.onLoad( function() {
  var opts = {  
    useUnformattedColWidth: false,
    columnSpecs   : [{canHide:false,control:new Rico.TableColumn.checkbox('1','0'),ClassName:'aligncenter'},'specQty'],
    <%= settingsCtl.GridSettingsScript %>,
    offset        : 20  // first row to display
  };
  buffer=new Rico.Buffer.Base($('ex7').tBodies[0]);
  grid=new Rico.LiveGrid ('ex7', buffer, opts);
  grid.menu=new Rico.GridMenu({ menuEvent : '<%= settingsCtl.MenuSetting %>'});
});
</script>

<style type="text/css">
div.ricoLG_cell { 
height:1.5em;
white-space: nowrap;
}  /* the check boxes require a little more height than normal */
td.ex7_col_0 { text-align:center; }
</style>

</head>



<body>
<table id='explanation' border='0' cellpadding='0' cellspacing='5' style='clear:both'><tr valign='top'><td>

<form method='post' id='settings' runat='server'>
<Rico:DemoSettings runat='server' id='settingsCtl' FilterEnabled='true' />
</form>

</td><td>This example demonstrates a pre-filled grid (same as example 1),
except that checkboxes have been placed in the first column. 
Click on a checkbox - notice that the box stays checked as the grid scrolls.
It also demonstrates how the grid can be initialized to start at a specified row
(this example skips the first 20 rows). Finally, it also shows how sorting and hide/show
can be disabled for individual columns (the first column in this example).
</td></tr></table>

<p class="ricoBookmark"><span id="ex7_bookmark">&nbsp;</span></p>
<table id="ex7" class="ricoLiveGrid" cellspacing="0" cellpadding="0">
<thead><tr>
<%
const numcol=12
dim c as integer
dim r as integer
for c=1 to numcol
  response.write("<th>Column " & c & "</th>")
next
%>
</tr></thead><tbody>
<%
for r=1 to 100
  response.write("<tr>")
  response.write("<td>")
  if r mod 10=0 then response.write("1") else response.write("0")
  response.write("</td>")
  response.write("<td>" & r & "</td>")
  for c=3 to numcol
    response.write("<td>Cell " & r & ":" & c & "</td>")
  next
  response.write("</tr>")
next
%>
</tbody></table>
<!--
<textarea id='ex7_debugmsgs' rows='5' cols='80' style='font-size:smaller;'></textarea>
-->
</body>
</html>

