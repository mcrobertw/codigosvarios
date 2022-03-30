<%@ Page Language="VB" ResponseEncoding="iso-8859-1" Debug="true" validateRequest="false" %>
<%@ Register TagPrefix="Rico" TagName="LiveGrid" Src="../../plugins/dotnet/LiveGrid.ascx" %>
<%@ Register TagPrefix="Rico" TagName="Column" Src="../../plugins/dotnet/GridColumn.ascx" %>
<%@ Register TagPrefix="Rico" TagName="Panel" Src="../../plugins/dotnet/GridPanel.ascx" %>
<%@ Register TagPrefix="Rico" TagName="sqlCompatibilty" Src="../../plugins/dotnet/sqlCompatibilty.ascx" %>
<%@ Register TagPrefix="My" TagName="AppLib" Src="applib.ascx" %>
<My:AppLib id='app' runat='server' />


<script runat="server">

Sub Page_Load(Sender As object, e As EventArgs)
  Session.Timeout=60
  dim CustomerID as string=trim(request.querystring("id"))
  'if len(CustomerID)=5 then sqltext &= " where CustomerID='" & CustomerID & "'"
  dim arEmpSql as string() = {"LastName","', '","FirstName"}
  dim oSqlCompat=new sqlCompatibilty(app.dbDialect)
  order.columns(2).SelectSql="select EmployeeID," & oSqlCompat.Concat(arEmpSql,false) & " from employees order by LastName,FirstName" 
  'customer.debug=true
  'order.debug=true
  'detail.debug=true
  app.OpenGridForm(customer)
  app.OpenGridForm(order)
  app.OpenGridForm(detail)
End Sub

Protected Overrides Sub Render(writer as HTMLTextWriter)
  if customer.action <> "table" then
    select case customer.action
      case "ins": customer.InsertRecord(writer)
      case "upd": customer.UpdateRecord(writer)
      case "del": customer.DeleteRecord(writer)
    end select
  elseif order.action <> "table" then
    select case order.action
      case "ins": order.InsertRecord(writer)
      case "upd": order.UpdateRecord(writer)
      case "del": order.DeleteRecord(writer)
    end select
  elseif detail.action <> "table" then
    select case detail.action
      case "ins": detail.InsertRecord(writer)
      case "upd": detail.UpdateRecord(writer)
      case "del": detail.DeleteRecord(writer)
    end select
  else
    MyBase.Render(writer)
  end if
End Sub

</script>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico LiveGrid-Example 4 (editable)</title>

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />

<script type="text/javascript">
Rico.include('greenHdg.css');

var custid,orderid;

function customerDrillDown(e) {
  customer['edit'].drillDown(e,0,0,order['edit']);
  detail['grid'].resetContents();
}

function orderDrillDown(e) {
  order['edit'].drillDown(e,1,0,detail['edit']);
}

function detailDataMenu(objCell,onBlankRow) {
  return !onBlankRow;
}

function order_FormInit() {
  var cal=new Rico.CalendarControl("Cal");
  RicoEditControls.register(cal, Rico.imgDir+'calarrow.png');
  cal.addHoliday(25,12,0,'Christmas','#F55','white');
  cal.addHoliday(4,7,0,'Independence Day-US','#88F','white');
  cal.addHoliday(1,1,0,'New Years','#2F2','white');
}
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

<table border='0' cellspacing='3' style='height:99%; width:99%; margin:0px;'>
<col width='25%'>
<tr valign='top'>
<td rowspan='3'>
<div id='description'>
Double-click on a row to see all orders for that customer.
<p>Drag the edge of a column heading to resize a column.
<p>To filter: right-click (ctrl-click in Opera, Konqueror, or Safari) on the value that you would like to use as the basis for filtering, then select the desired filtering method from the pop-up menu.
<p>Right-click anywhere in a column to see sort, hide, and show options.
<p>Notice that filters and sorting in the customer grid persist after a refresh. The saveColumnInfo option specifies that these values should be saved in cookies.
</div>

</td>
<td class="gridcontainer" height="33%">

<Rico:LiveGrid runat='server' id='customer' rows='-4' formView='true' TableName='customers' RecordName='Customer' frozenColumns='2' menuEvent='contextmenu' highlightElem='menuRow' dblclick='customerDrillDown'>
<GridColumns>
  <Rico:Column runat='server' heading='Cust ID'      width='60'  ColName='CustomerID'   EntryType='B' />
  <Rico:Column runat='server' heading='Company Name' width='220' ColName='CompanyName'  EntryType='B' />
  <Rico:Column runat='server' heading='Contact'      width='120' ColName='ContactName'  EntryType='B' />
  <Rico:Column runat='server' heading='Address'      width='200' ColName='Address'      EntryType='B' />
  <Rico:Column runat='server' heading='City'         width='110' ColName='City'         EntryType='B' />
  <Rico:Column runat='server' heading='Region'       width='50'  ColName='Region'       EntryType='N' />
  <Rico:Column runat='server' heading='Postal Code'  width='80'  ColName='PostalCode'   EntryType='B' />
  <Rico:Column runat='server' heading='Country'      width='90'  ColName='Country'      EntryType='N' />
  <Rico:Column runat='server' heading='Phone'        width='110' ColName='Phone'        EntryType='B' />
  <Rico:Column runat='server' heading='Fax'          width='110' ColName='Fax'          EntryType='B' />
</GridColumns>
</Rico:LiveGrid>

</td>
<tr height="33%"><td class="gridcontainer">

<Rico:LiveGrid runat='server' id='order' rows='4' formView='true' prefetchBuffer='false' TableName='orders' RecordName='Order' frozenColumns='2' DefaultSort='OrderID' menuEvent='contextmenu' highlightElem='menuRow' dblclick='orderDrillDown' >
<GridColumns>
  <Rico:Panel runat='server' heading='Basic Info' />
  <Rico:Column runat='server' heading='Cust ID'       width='60'  ColName='CustomerID'   EntryType='B' InsertOnly='true' />
  <Rico:Column runat='server' heading='Order ID'      width='60'  ColName='OrderID'      EntryType='B' ColData='<auto>' />
  <Rico:Column runat='server' heading='Sales Person'  width='140' ColName='EmployeeID'   EntryType='SL' />
  <Rico:Column runat='server' heading='Order Date'    width='90'  ColName='OrderDate'    EntryType='D' ColData='Today' SelectCtl='Cal' min='1995-01-01' />
  <Rico:Column runat='server' heading='Required Date' width='90'  ColName='RequiredDate' EntryType='D' ColData='Today' SelectCtl='Cal' min='1995-01-01' />
  <Rico:Column runat='server' heading='Net Sale'      width='80'  format='DOLLAR'        Formula='select sum(UnitPrice*Quantity*(1.0-Discount)) from order_details d where d.OrderID=t.OrderID' />

  <Rico:Panel runat='server' heading='Ship To' />
  <Rico:Column runat='server' heading='Name'        width='140' ColName='ShipName'       EntryType='B' />
  <Rico:Column runat='server' heading='Address'     width='140' ColName='ShipAddress'    EntryType='B' />
  <Rico:Column runat='server' heading='City'        width='120' ColName='ShipCity'       EntryType='B' />
  <Rico:Column runat='server' heading='Region'      width='60'  ColName='ShipRegion'     EntryType='T' />
  <Rico:Column runat='server' heading='Postal Code' width='100' ColName='ShipPostalCode' EntryType='T' />
  <Rico:Column runat='server' heading='Country'     width='100' ColName='ShipCountry'    EntryType='N' />
</GridColumns>
</Rico:LiveGrid>

</td>
<tr height="33%"><td class="gridcontainer">

<Rico:LiveGrid runat='server' id='detail' rows='4' formView='true' prefetchBuffer='false' TableName='order_details' RecordName='Line Item' frozenColumns='2' menuEvent='contextmenu' highlightElem='menuRow'>
<GridColumns>
  <Rico:Column runat='server' heading='Order ID'    width='60'  ColName='OrderID'   EntryType='B' InsertOnly='true' />
  <Rico:Column runat='server' heading='Product'     width='140' ColName='ProductID' EntryType='SL' SelectSql='select ProductID,ProductName from products order by ProductName' />
  <Rico:Column runat='server' heading='Unit Price'  width='80'  ColName='UnitPrice' EntryType='F' format='Dollar' min='0.01' max='999.99' />
  <Rico:Column runat='server' heading='Quantity'    width='80'  ColName='Quantity'  EntryType='I' format='Qty' min='1' max='999' />
  <Rico:Column runat='server' heading='Discount'    width='80'  ColName='Discount'  EntryType='F' format='Percent' min='0.0' max='0.5' />
</GridColumns>
</Rico:LiveGrid>

</td>
</tr>
</table></body></html>
