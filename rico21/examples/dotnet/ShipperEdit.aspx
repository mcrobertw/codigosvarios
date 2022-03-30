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
<title>Rico LiveGrid-Shippers (editable)</title>

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../../src/css/greenHdg.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />

<style type="text/css">
div.ricoLG_cell {
  white-space:nowrap;
}
</style>
</head>


<body>
<table id='explanation' border='0' cellpadding='0' cellspacing='5' style='clear:both'><tr valign='top'>
<td>This example demonstrates how database records can be updated via AJAX. 
Double-click on a row to see the pop-up menu, then select add, edit, or delete.
As shipped with the Rico distribution, the .net LiveGrid examples use a MS Access database.
This database cannot be updated from the web; therefore, form save operations will fail 
unless you change to another database.</td>
</tr></table>

<p><strong>Shippers Table</strong></p>

<Rico:LiveGrid runat='server' id='ex8' formView='true' TableName='shippers' DefaultSort='ShipperID'>
<GridColumns>
  <Rico:Column runat='server' heading='ID'           width='50'  ColName='ShipperID'   EntryType='B' ColData='<auto>' />
  <Rico:Column runat='server' heading='CompanyName'  width='150' ColName='CompanyName' EntryType='B' />
  <Rico:Column runat='server' heading='Phone Number' width='150' ColName='Phone'       EntryType='B' />
</GridColumns>
</Rico:LiveGrid>

</body>
</html>
