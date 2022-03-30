<%@ Page Language="VB" ResponseEncoding="iso-8859-1" Debug="true" %>
<%@ Register TagPrefix="Rico" TagName="LiveGrid" Src="../../plugins/dotnet/LiveGrid.ascx" %>
<%@ Register TagPrefix="Rico" TagName="Column" Src="../../plugins/dotnet/GridColumn.ascx" %>


<script runat="server">

Sub Page_Load(Sender As object, e As EventArgs)
  Session.Timeout=60
  ex2.sqlQuery="select OrderID,CustomerID,ShipName,ShipCity,ShipCountry,OrderDate,ShippedDate from orders order by OrderID"
  ex2.dataProvider="ricoXMLquery.aspx"
End Sub

</script>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico LiveGrid-Example 2</title>

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../../src/css/greenHdg.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />

<script type='text/javascript'>
Rico.onLoad( function() {
  var popup=new Rico.Popup({ hideOnClick: false, canDragFunc: true });
  popup.createWindow('Grid Window (drag me)','','390px','500px');
  popup.contentDiv.appendChild($('ex2'));
  popup.openPopup(50,100);
});
</script>

<style type="text/css">
div.ricoWindow {
  border: 2px solid black;
}
div.ricoWindow div.ricoTitle {
  padding: 3px;
  color: white;
  background-color: black;
}
div.ricoWindow div.ricoContent {
  background-color: #AAF;
  margin: 0px;
  overflow: hidden !important;  /* for Safari */
}
div.ricoLG_cell {
  white-space:nowrap;
}
#background {
  color:#CCC; 
  font-size:24pt; 
  font-family: Times New Roman;
}
</style>
</head>


<body>
<p id='explanation'>This example demonstrates a LiveGrid inside an absolutely positioned &lt;div&gt;. 
Setting options.visibleRows to 'parent' (or -4) makes this possible.

<p>&nbsp;

<!-- just some text to show that the div containing the grid has position:absolute -->
<p id='background'>
Lorem ipsum dolor sit amet, consectetur adipisicing elit, 
sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris 
nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in 
reprehenderit in voluptate velit esse cillum dolore eu fugiat 
nulla pariatur. Excepteur sint occaecat cupidatat non proident, 
sunt in culpa qui officia deserunt mollit anim id est laborum.

<Rico:LiveGrid runat='server' id='ex2' rows='-4' DisplayBookmark='false' DisplayTimer='false'>
<GridColumns>
  <Rico:Column runat='server' heading='Order#' width='60' />
  <Rico:Column runat='server' heading='Customer#' width='60' />
  <Rico:Column runat='server' heading='Ship Name' width='150' />
  <Rico:Column runat='server' heading='Ship City' width='120' />
  <Rico:Column runat='server' heading='Ship Country' width='90' />
  <Rico:Column runat='server' heading='Order Date' datatype='date' width='100' />
  <Rico:Column runat='server' heading='Ship Date' datatype='date' width='100' />
</GridColumns>
</Rico:LiveGrid>

</body>
</html>
