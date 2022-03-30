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
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />

<script type='text/javascript'>

function ex2_InitComplete() {
  var a=location.search.split('=');
  var colorSel=$('colors');
  var v=colorSel.value;
  if (a.length==2) {
    v=a[1];
    var o=colorSel.options;
    for (var i=0; i<o.length; i++)
      if (o[i].value==v) {
        o[i].selected=true;
        break;
      }
  }
  var colors=v.split('_');
  for (var i=0; i<ex2['grid'].columns.length; i++) {
    var c=ex2['grid'].columns[i];
    Rico.Color.createGradientV(c.hdrCellDiv,colors[0],colors[1]);
    if (colors.length > 2) c.hdrCellDiv.style.color='#'+colors[2];
  }
}
</script>

<style type="text/css">
div.ricoLG_cell {
  white-space:nowrap;
}
</style>
</head>


<body>
<div id='explanation'>
<p>This example demonstrates how to create a cross-browser gradient background.
<form method='get'>
<p>Pick a color scheme:
<select id='colors' name='colors' onchange='this.form.submit();'>
<option value='ffffff_dcdcdc'>Light Gray</option>
<option value='888888_000000_cccccc'>Black</option>
<option value='0000ff_000000_B274DC'>Midnight Blue</option>
<option value='ffff00_00cc00'>Green Bay</option>
<option value='C7DFDE_5CA2A0_FFFFFF'>Steel Blue</option>
<option value='F7AFB3_EA151E_FFFFFF'>Peppermint</option>
</select>
</p>
</form>
</div>

<Rico:LiveGrid runat='server' id='ex2' rows='-3' headingSort='hover'>
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
