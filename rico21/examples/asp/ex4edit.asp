<%@ LANGUAGE="VBSCRIPT" %>
<% Response.CacheControl = "no-cache" %>
<% Response.AddHeader "Pragma", "no-cache" %> 
<% Response.Expires = -1 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico LiveGrid-Example 4 (editable)</title>

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
</script>

<style type="text/css">
html, body {
  height:96%;
  margin: 0px;
  padding: 0px;
  border: none;
}

.gridcontainer {
  margin-left:2%;
  width:75%;
  overflow:visible;
  font-size: 8pt;
}

#description {
  overflow:auto;
  height:99%;
  font-size:8pt;
  color:blue;
  font-family:Verdana, Arial, Helvetica, sans-serif;
}

div.ricoLG_cell {
  font-size: 8pt !important;
  height: 12px;
  white-space: nowrap;
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

dim orderTE, detailTE

if OpenGridForm(empty,"customers") then
  set orderTE=OpenTableEdit("orders")
  set detailTE=OpenTableEdit("order_details")
  if oForm.action<>"table" then
    DefineCustTable
  elseif orderTE.action<>"table" then
    DefineOrderTable
  elseif detailTE.action<>"table" then
    DefineDetailTable
  else
    DisplayAllTables
  end if
end if
CloseApp


sub DisplayAllTables()
  response.write "<table border='0' cellspacing='3' style='height:99%; width:99%; margin:0px;'>"
  response.write "<col width='25%'>"
  response.write "<tr valign='top'>"
  response.write "<td rowspan='3'>"
  response.write "<div id='description'>"
  response.write "Double-click on a row to see all orders for that customer."
  response.write "<p>Drag the edge of a column heading to resize a column."
  response.write "<p>To filter: right-click (ctrl-click in Opera, Konqueror, or Safari) on the value that you would like to use as the basis for filtering, then select the desired filtering method from the pop-up menu."
  response.write "<p>Right-click anywhere in a column to see sort, hide, and show options."
  response.write "<p>Notice that filters and sorting in the customer grid persist after a refresh. The saveColumnInfo option specifies that these values should be saved in cookies."
  response.write "</div></td><td class='gridcontainer' height='33%'>"
  DefineCustTable
  response.write "</td><tr height='33%'><td class='gridcontainer'>"
  DefineOrderTable
  response.write "</td><tr height='33%'><td class='gridcontainer'>"
  DefineDetailTable
  createInitScript
  response.write "</td></tr></table>"

  'response.write "<p><textarea id='orders_debugmsgs' rows='5' cols='80' style='font-size:smaller;'></textarea>"
end sub

sub createInitScript()
  response.write vbLf & "<script language='javascript' type='text/javascript'>"

  response.write vbLf & "function drillDown1(e) {"
  response.write vbLf & oForm.formVar & ".drillDown(e,0,0," & orderTE.formVar & ");"
  response.write vbLf & detailTE.gridVar & ".resetContents();"
  response.write vbLf & "}"

  response.write vbLf & "function drillDown2(e) {"
  response.write vbLf & orderTE.formVar & ".drillDown(e,1,0," & detailTE.formVar & ");"
  response.write vbLf & "}"

  response.write vbLf & "function " & oForm.gridID & "_GridInit() {"
  response.write vbLf & "  var cal=new Rico.CalendarControl('Cal');"
  response.write vbLf & "  RicoEditControls.register(cal, Rico.imgDir+'calarrow.png');"
  response.write vbLf & "  " & oForm.optionsVar & ".dblclick=drillDown1;"
  response.write vbLf & "  " & orderTE.optionsVar & ".dblclick=drillDown2;"
  response.write vbLf & "  " & orderTE.InitScript
  response.write vbLf & "  " & detailTE.InitScript
  response.write vbLf & "}"

  response.write vbLf & "</script>"
end sub

sub DefineCustTable()
  oForm.options("RecordName")="Customer"
  oForm.options("visibleRows")="parent"
  oForm.options("frozenColumns")=2
  oForm.options("highlightElem")="menuRow"
  oForm.options("menuEvent")="contextmenu"
  
  oForm.AddEntryFieldW "CustomerID","Cust ID","B","<auto>",60
  oForm.ConfirmDeleteColumn
  oForm.SortAsc
  oForm.AddEntryFieldW "CompanyName","Company Name","B","",220
  oForm.AddEntryFieldW "ContactName","Contact","B","",120
  oForm.AddEntryFieldW "Address","Address","B","",200
  oForm.AddEntryFieldW "City","City","B","",110
  oForm.AddEntryFieldW "Region","Region","N","",50
  oForm.AddEntryFieldW "PostalCode","Postal Code","B","",80
  oForm.AddEntryFieldW "Country","Country","N","",90
  oForm.AddEntryFieldW "Phone","Phone","B","",110
  oForm.AddEntryFieldW "Fax","Fax","B","",110

  'oForm.AutoInit=false
  oForm.DisplayPage
end sub

sub DefineOrderTable()
  orderTE.options("RecordName")="Order"
  orderTE.options("frozenColumns")=2
  orderTE.options("prefetchBuffer")=false
  orderTE.options("visibleRows")=4
  orderTE.options("highlightElem")="menuRow"
  orderTE.options("menuEvent")="contextmenu"
  orderTE.AutoInit=false

  orderTE.AddEntryFieldW "CustomerID","Cust ID","B","<auto>",60
  orderTE.CurrentField("InsertOnly")=true   ' do not allow customer to be changed once an order is entered
  orderTE.AddPanel "Basic Info"
  orderTE.AddEntryFieldW "OrderID","Order ID","B","<auto>",60
  orderTE.ConfirmDeleteColumn
  orderTE.SortAsc
  orderTE.AddEntryFieldW "EmployeeID","Sales Person","SL","",140
  orderTE.CurrentField("SelectSql")="select EmployeeID," & oDB.concat(Array("LastName","', '","FirstName"),false) & " from Employees order by LastName,FirstName"
  orderTE.AddEntryFieldW "OrderDate","Order Date","D",Date(),90
  orderTE.CurrentField("SelectCtl")="Cal"
  orderTE.CurrentField("min")="1995-01-01"
  orderTE.CurrentField("max")=Date()
  orderTE.AddEntryFieldW "RequiredDate","Required Date","D",Date(),90
  orderTE.CurrentField("SelectCtl")="Cal"
  orderTE.CurrentField("min")="1995-01-01"
  orderTE.AddCalculatedField "select sum(UnitPrice*Quantity*(1.0-Discount)) from order_details d where d.OrderID=t.OrderID","Net Sale"
  orderTE.CurrentField("format")="DOLLAR"
  orderTE.CurrentField("width")=80

  orderTE.AddPanel "Ship To"
  orderTE.AddEntryFieldW "ShipName","Name","B","",140
  orderTE.AddEntryFieldW "ShipAddress","Address","B","",140
  orderTE.AddEntryFieldW "ShipCity","City","B","",120
  orderTE.AddEntryFieldW "ShipRegion","Region","T","",60
  orderTE.AddEntryFieldW "ShipPostalCode","Postal Code","T","",100
  orderTE.AddEntryFieldW "ShipCountry","Country","N","",100

  orderTE.DisplayPage
end sub

sub DefineDetailTable()
  detailTE.options("RecordName")="Line Item"
  detailTE.options("frozenColumns")=2
  detailTE.options("prefetchBuffer")=false
  detailTE.options("visibleRows")=4
  detailTE.options("highlightElem")="menuRow"
  detailTE.options("menuEvent")="contextmenu"
  detailTE.AutoInit=false

  detailTE.AddEntryFieldW "OrderID","Order ID","I","<auto>",60
  detailTE.AddEntryFieldW "ProductID","Product","SL","",140
  detailTE.SortAsc
  detailTE.CurrentField("SelectSql")="select ProductID,ProductName from products order by ProductName"
  detailTE.AddEntryFieldW "UnitPrice","Unit Price","F","",80
  detailTE.CurrentField("format")="DOLLAR"
  detailTE.CurrentField("min")=0.01
  detailTE.CurrentField("max")=999.99
  detailTE.AddEntryFieldW "Quantity","Quantity","I","1",80
  detailTE.CurrentField("format")="QTY"
  detailTE.CurrentField("min")=1
  detailTE.CurrentField("max")=999
  detailTE.AddEntryFieldW "Discount","Discount","F","0",80
  detailTE.CurrentField("format")="PERCENT"
  detailTE.CurrentField("min")=0.0
  detailTE.CurrentField("max")=0.5
  
  detailTE.DisplayPage
end sub

%>

</body>
</html>
