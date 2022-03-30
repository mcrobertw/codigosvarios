<%@ Page Language="VB" ResponseEncoding="iso-8859-1" Debug="true" validateRequest="false" %>
<%@ Register TagPrefix="Rico" TagName="DemoSettings" Src="settings.ascx" %>
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
  ex8.columns(2).SelectSql="select EmployeeID," & oSqlCompat.Concat(arEmpSql,false) & " from employees order by LastName,FirstName" 
  settingsCtl.ApplyGridSettings(ex8)
  app.OpenGridForm(ex8)
End Sub

Protected Overrides Sub Render(writer as HTMLTextWriter)
  select case ex8.action
    case "table": MyBase.Render(writer)
    case "ins":   ex8.InsertRecord(writer)
    case "upd":   ex8.UpdateRecord(writer)
    case "del":   ex8.DeleteRecord(writer)
  end select
End Sub

</script>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico LiveGrid-Example 2 (editable)</title>

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />

<script type='text/javascript'>
<%= settingsCtl.StyleInclude %>

// ricoLiveGridForms will call orders_FormInit right before grid & form initialization.

function ex8_FormInit() {
  var cal=new Rico.CalendarControl("Cal");
  RicoEditControls.register(cal, Rico.imgDir+'calarrow.png');
  cal.addHoliday(25,12,0,'Christmas','#F55','white');
  cal.addHoliday(4,7,0,'Independence Day-US','#88F','white');
  cal.addHoliday(1,1,0,'New Years','#2F2','white');
  
  var CustTree=new Rico.TreeControl("CustomerTree","CustTree.aspx");
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
<table id='explanation' border='0' cellpadding='0' cellspacing='5' style='clear:both'><tr valign='top'>

<td><form method='post' id='settings' runat='server'>
<Rico:DemoSettings runat='server' id='settingsCtl' FilterEnabled='true' />
</form></td>

<td>This example demonstrates how database records can be updated via AJAX. 
Try selecting add, edit, or delete from the pop-up menu. 
If you select add, then click the '...' button next to customer, you will see the Rico tree control.
As shipped with the Rico distribution, the .net LiveGrid examples use a MS Access database.
This database cannot be updated from the web; therefore, form save operations will fail 
unless you change to another database.</td>
</tr></table>

<Rico:LiveGrid runat='server' id='ex8' formView='true' TableName='orders' DefaultSort='OrderID' FilterLocation='-1'>
<GridColumns>
  <Rico:Panel runat='server' heading='Basic Info' />
  <Rico:Column runat='server' heading='Order#'        width='60'  ColName='OrderID'      EntryType='B' ColData='<auto>' />
  <Rico:Column runat='server' heading='Customer'      width='160' ColName='CustomerID'   EntryType='CL' InsertOnly='true' SelectCtl='CustomerTree' SelectSql="select CustomerID,CompanyName from customers order by CompanyName" filterUI='t' />
  <Rico:Column runat='server' heading='Sales Person'  width='140' ColName='EmployeeID'   EntryType='SL' filterUI='s' />
  <Rico:Column runat='server' heading='Order Date'    width='100' ColName='OrderDate'    EntryType='D' ColData='Today' SelectCtl='Cal' />
  <Rico:Column runat='server' heading='Required Date' width='100' ColName='RequiredDate' EntryType='D' ColData='Today' SelectCtl='Cal' />
  <Rico:Column runat='server' heading='Net Sale'      width='80'  format='DOLLAR'        Formula='select sum(UnitPrice*Quantity*(1.0-Discount)) from order_details d where d.OrderID=t.OrderID' />

  <Rico:Panel runat='server' heading='Ship To' />
  <Rico:Column runat='server' heading='Name'        width='150' ColName='ShipName'       EntryType='B' />
  <Rico:Column runat='server' heading='Address'     width='150' ColName='ShipAddress'    EntryType='B' />
  <Rico:Column runat='server' heading='City'        width='80'  ColName='ShipCity'       EntryType='B' filterUI='s' />
  <Rico:Column runat='server' heading='Region'      width='80'  ColName='ShipRegion'     EntryType='T' />
  <Rico:Column runat='server' heading='Postal Code' width='80'  ColName='ShipPostalCode' EntryType='T' />
  <Rico:Column runat='server' heading='Country'     width='90'  ColName='ShipCountry'    EntryType='N' filterUI='s' control="new Rico.TableColumn.link('http://en.wikipedia.org/wiki/{11}','_blank')" />
</GridColumns>
</Rico:LiveGrid>

</body>
</html>
