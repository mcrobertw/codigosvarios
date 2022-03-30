<%@ LANGUAGE="VBSCRIPT" %>
<% Response.CacheControl = "no-cache" %>
<% Response.AddHeader "Pragma", "no-cache" %> 
<% Response.Expires = -1 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico LiveGrid-Example 2 (editable)</title>

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />
<!-- #INCLUDE FILE = "applib.vbs" --> 
<!-- #INCLUDE FILE = "../../plugins/asp/ricoLiveGridForms.vbs" --> 
<!-- #INCLUDE FILE = "settings.vbs" --> 

<script type='text/javascript'>
<%
setStyle
%>

// ricoLiveGridForms will call orders_FormInit right before grid & form initialization.

function orders_FormInit() {
  var cal=new Rico.CalendarControl("Cal");
  RicoEditControls.register(cal, Rico.imgDir+'calarrow.png');
  cal.addHoliday(25,12,0,'Christmas','#F55','white');
  cal.addHoliday(4,7,0,'Independence Day-US','#88F','white');
  cal.addHoliday(1,1,0,'New Years','#2F2','white');
  
  var CustTree=new Rico.TreeControl("CustomerTree","CustTree.asp");
  RicoEditControls.register(CustTree, Rico.imgDir+'dotbutton.gif');
}
</script>
<style type="text/css">
div.ricoLG_outerDiv thead .ricoLG_cell, div.ricoLG_outerDiv thead td, div.ricoLG_outerDiv thead th {
	height:1.5em;
}
div.ricoLG_cell {
  white-space:nowrap;
}
</style>
</head>


<body>

<%
'************************************************************************************************************
'  LiveGrid Plus-Edit Example
'************************************************************************************************************
'  Matt Brown
'************************************************************************************************************

if OpenGridForm(empty,"Orders") then
  if oForm.action="table" then
    DisplayTable
  else
    DefineFields
  end if
end if
CloseApp


sub DisplayTable()
  response.write "<table id='explanation' border='0' cellpadding='0' cellspacing='5' style='clear:both'><tr valign='top'><td>"
  GridSettingsForm
  response.write "</td><td>This example demonstrates how database records can be updated via AJAX. "
  response.write "Try selecting add, edit, or delete from the pop-up menu. "
  response.write "If you select add, then click the '...' button next to customer, you will see the Rico tree control."
  response.write "As shipped with the Rico distribution, the ASP LiveGrid examples use a MS Access database. "
  response.write "This database cannot be updated from the web; therefore, form save operations will fail "
  response.write "unless you change to another database."
  response.write "</td></tr></table>"
  oForm.options("borderWidth")=0
  GridSettingsTE oForm
  'oForm.DebugFlag=true
  DefineFields

  'response.write "<p><textarea id='orders_debugmsgs' rows='5' cols='80' style='font-size:smaller;'></textarea>"
end sub


sub DefineFields()
  dim colnum
  'oForm.options("showSaveMsg")="full"
  oForm.options("FilterLocation")=-1
  
  oForm.AddPanel "Basic Info"
  oForm.AddEntryField "OrderID","Order ID","B","<auto>"
  oForm.ConfirmDeleteColumn
  oForm.CurrentField("width")=50
  oForm.SortAsc
  oForm.AddEntryField "CustomerID","Customer","CL",""
  oForm.CurrentField("SelectCtl")="CustomerTree"
  oForm.CurrentField("SelectSql")="select CustomerID,CompanyName from Customers order by CompanyName"
  oForm.CurrentField("InsertOnly")=true   ' do not allow customer to be changed once an order is entered
  oForm.CurrentField("width")=160
  oForm.CurrentField("filterUI")="t"
  oForm.AddEntryField "EmployeeID","Sales Person","SL",""
  oForm.CurrentField("SelectSql")="select EmployeeID," & oDB.concat(Array("LastName","', '","FirstName"),false) & " from Employees order by LastName,FirstName"
  oForm.CurrentField("width")=140
  oForm.CurrentField("filterUI")="s"
  oForm.AddEntryFieldW "OrderDate","Order Date","D",Date(),90
  oForm.CurrentField("SelectCtl")="Cal"
  oForm.AddEntryFieldW "RequiredDate","Required Date","D",Date(),90
  oForm.CurrentField("SelectCtl")="Cal"
  oForm.AddCalculatedField "select sum(UnitPrice*Quantity*(1.0-Discount)) from order_details d where d.OrderID=t.OrderID","Net Sale"
  oForm.CurrentField("format")="DOLLAR"
  oForm.CurrentField("width")=80

  oForm.AddPanel "Ship To"
  oForm.AddEntryFieldW "ShipName","Name","B","",140
  oForm.AddEntryFieldW "ShipAddress","Address","B","",140
  oForm.AddEntryFieldW "ShipCity","City","B","",120
  oForm.CurrentField("filterUI")="s"
  oForm.AddEntryFieldW "ShipRegion","Region","T","",60
  oForm.AddEntryFieldW "ShipPostalCode","Postal Code","T","",100
  
  ' display ShipCountry with a link to wikipedia
  colnum=oForm.AddEntryFieldW("ShipCountry","Country","N","",100)
  oForm.CurrentField("control")="new Rico.TableColumn.link('http://en.wikipedia.org/wiki/{" & colnum & "}','_blank')"
  oForm.CurrentField("filterUI")="s"

  'oForm.AutoInit=false
  oForm.DisplayPage
end sub

%>

</body>
</html>
