<%@ Page Language="VB" ResponseEncoding="iso-8859-1" Debug="true" %>
<%@ Register TagPrefix="Rico" TagName="DemoSettings" Src="settings.ascx" %>
<%@ Register TagPrefix="Rico" TagName="LiveGrid" Src="../../plugins/dotnet/LiveGrid.ascx" %>
<%@ Register TagPrefix="Rico" TagName="Column" Src="../../plugins/dotnet/GridColumn.ascx" %>
<%@ Register TagPrefix="Rico" TagName="sqlCompatibilty" Src="../../plugins/dotnet/sqlCompatibilty.ascx" %>
<%@ Register TagPrefix="My" TagName="AppLib" Src="applib.ascx" %>

<My:AppLib id='app' runat='server' />
<script runat="server">

Sub Page_Load(Sender As object, e As EventArgs)
  Session.Timeout=60
  dim oSqlCompat=new sqlCompatibilty()
  ex6.sqlQuery="select CustomerID,ShipName," & oSqlCompat.SqlYear("ShippedDate") & " as yr,count(*) as cnt from orders group by CustomerID,ShipName," & oSqlCompat.SqlYear("ShippedDate") & " order by CustomerID"
  settingsCtl.ApplyGridSettings(ex6)
End Sub

</script>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico LiveGrid-Example 6</title>

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />

<script type='text/javascript'>
<%= settingsCtl.StyleInclude %>
</script>

<script type='text/javascript'>

var yrboxes;
function setFilter() {
  for (var i=0; i<yrboxes.length; i++) {
    if (yrboxes[i].checked==true) {
      var yr=yrboxes[i].value;
      ex6['grid'].columns[2].setSystemFilter('EQ',yr);
      return;
    }
  }
}

function initFilter() {
  yrboxes=document.getElementsByName('year');
  setFilter();
}
</script>

<style type="text/css">
.ricoLG_top div.ricoLG_col {
  white-space:nowrap;
}
</style>

</head>



<body>
<table id='explanation' border='0' cellpadding='0' cellspacing='5' style='clear:both'><tr valign='top'><td>

<form method='post' id='settings' runat='server'>
<Rico:DemoSettings runat='server' id='settingsCtl' FilterEnabled='true' />
</form>

</td>
<td>This example shows how to apply a filter to the initial data set - even though that filter may change later.
It also demonstrates an alternative way of formatting the headings and handling click events on them.
Finally, the "Refresh" button demonstrates how the information in the grid can be updated without
losing scroll position (doesn't do anything useful in this situation because the data is static).
</td></tr></table>

<p>Count orders for: 
<input type='radio' name='year' onclick='setFilter()' value='1996' checked>&nbsp;1996
<input type='radio' name='year' onclick='setFilter()' value='1997'>&nbsp;1997
<button onclick='ex6.buffer.refresh()' style='margin-left:1em;font-size:8pt;'>Refresh</button>
</p>

<Rico:LiveGrid runat='server' id='ex6' prefetchBuffer='false' headingSort='hover' afterInit='initFilter();'>
<GridColumns>
  <Rico:Column runat='server' heading='Cust#' width='60' />
  <Rico:Column runat='server' heading='Ship Name' width='260' control="new Rico.TableColumn.link('ex2.aspx?id={0}','_blank')" />
  <Rico:Column runat='server' heading='Year' width='50' />
  <Rico:Column runat='server' heading='Orders' width='60' format='Qty' />
</GridColumns>
</Rico:LiveGrid>

</body>
</html>

