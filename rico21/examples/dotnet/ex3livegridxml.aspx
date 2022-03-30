<%@ Page Language="VB" ResponseEncoding="iso-8859-1" Debug="true" %>
<%@ Register TagPrefix="Rico" TagName="LiveGrid" Src="../../plugins/dotnet/LiveGrid.ascx" %>
<%@ Register TagPrefix="Rico" TagName="Column" Src="../../plugins/dotnet/GridColumn.ascx" %>

<script runat="server">

Sub Page_Load(Sender As object, e As EventArgs)
  Session.Timeout=60
  dim sqltext as string="select OrderID,CustomerID,ShipName,ShipCity,ShipCountry,OrderDate,ShippedDate from orders order by OrderID"
  ex3.sqlQuery=sqltext
End Sub

</script>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico LiveGrid-Example 3</title>

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../../src/css/greenHdg.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />

<style type="text/css">
input, select { font-weight:normal;font-size:8pt;}
tr.ex3_hdg2 div.ricoLG_cell { 
  height:     1.4em;   /* the text boxes require a little more height than normal */
  text-align: left;
  background-color: #deeecd;
}
.ricoLG_cell {
  white-space: nowrap;
}
</style>
</head>


<body>
<div id='explanation'>
This LiveGrid demonstrates how an AjaxXML buffer can be loaded from ricoXMLquery,
and still have filters applied as the user types.
The AjaxXML buffer will load all rows into the buffer at grid startup, as opposed to the
AjaxSQL buffer which loads data in chunks as needed.
Filtering is performed on the client -- responsiveness will vary with the speed of
the client computer, the number of rows in the grid, and the efficiency of the browser.
Note the "saveColumnInfo" option - filter settings are saved in a cookie and restored
when the user returns to the page.
</div>

<Rico:LiveGrid runat='server' id='ex3' frozenColumns='1' saveColumnFilter='true' FilterLocation='-1' BufferType='AjaxXML'>
  <HeadingTop>
	  <tr>
	  <th class='ricoFrozen'>ID</th>
	  <th>ID</th>
	  <th colspan='3'>Shipment</th>
	  <th colspan='2'>Date</th>
	  </tr>
  </HeadingTop>
  <GridColumns>
    <Rico:Column runat='server' heading='Order#' width='60' />
    <Rico:Column runat='server' heading='Customer#' width='60' />
    <Rico:Column runat='server' heading='Name' width='150' filterUI='t' />
    <Rico:Column runat='server' heading='City' width='100' filterUI='t' />
    <Rico:Column runat='server' heading='Country' width='100' filterUI='s' />
    <Rico:Column runat='server' heading='Order' datatype='date' width='90' />
    <Rico:Column runat='server' heading='Ship' datatype='date' width='90' />
  </GridColumns>
</Rico:LiveGrid>

</body>
</html>
