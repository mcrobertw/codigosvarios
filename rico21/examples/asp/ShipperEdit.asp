<%@ LANGUAGE="VBSCRIPT" %>
<% Response.CacheControl = "no-cache" %>
<% Response.AddHeader "Pragma", "no-cache" %> 
<% Response.Expires = -1 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico LiveGrid-Shippers (editable)</title>

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../../src/css/grayedout.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />
<!-- #INCLUDE FILE = "applib.vbs" --> 
<!-- #INCLUDE FILE = "../../plugins/asp/ricoLiveGridForms.vbs" --> 
<!-- #INCLUDE FILE = "settings.vbs" --> 

<style type="text/css">
div.ricoLG_cell {
  white-space:nowrap;
}
</style>
</head>


<body>

<%
'************************************************************************************************************
'  LiveGrid-Edit Example
'************************************************************************************************************
'  Matt Brown
'************************************************************************************************************

if OpenGridForm(empty,"shippers") then
  if oForm.action="table" then
    DisplayTable
  else
    DefineFields
  end if
end if
CloseApp


sub DisplayTable()
  response.write "<table id='explanation' border='0' cellpadding='0' cellspacing='5' style='clear:both'><tr valign='top'><td>"
  response.write "This example demonstrates how database records can be updated via AJAX. "
  response.write "Double-click on a row to see the pop-up menu, then select add, edit, or delete. "
  response.write "As shipped with the Rico distribution, the ASP LiveGrid examples use a MS Access database. "
  response.write "This database cannot be updated from the web; therefore, form save operations will fail "
  response.write "unless you change to another database."
  response.write "</td></tr></table>"
  response.write "<p><strong>Shippers Table</strong></p>"
  DefineFields

  'response.write "<p><textarea id='shippers_debugmsgs' rows='5' cols='80' style='font-size:smaller;'></textarea>"
end sub


sub DefineFields()
  oForm.AddEntryFieldW "ShipperID", "ID", "B", "<auto>",50
  oForm.AddEntryFieldW "CompanyName", "Company Name", "B", "", 150
  oForm.ConfirmDeleteColumn
  oForm.SortAsc
  oForm.AddEntryFieldW "Phone", "Phone Number", "B", "", 150

  oForm.DisplayPage
end sub

%>

</body>
</html>
