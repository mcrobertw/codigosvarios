<%@ Page Language="VB" ResponseEncoding="iso-8859-1" Debug="true" %>
<%@ Register TagPrefix="Rico" TagName="SimpleGrid" Src="../../plugins/dotnet/SimpleGrid.ascx" %>
<%@ Register TagPrefix="Rico" TagName="Column" Src="../../plugins/dotnet/GridColumn.ascx" %>

<script runat="server">

Sub Page_Load(Sender As object, e As EventArgs)
  dim r as Integer, c as Integer
  const numcol=15
  
  ' define heading
  ex1.AddHeadingRow(true)
  for c=1 to numcol
    ex1.AddCell("Column " & c)
  next
  
  ' define data
  for r=1 to 100
    ex1.AddDataRow()
    ex1.AddCell(r)
    for c=2 to numcol
      ex1.AddCell("Cell " & r & ":" & c)
    next
  next
End Sub

Protected Overrides Sub Render(writer as HTMLTextWriter)
  select case lcase(Request.QueryString("fmt"))
    case "xl":  ex1.RenderExcel("rico.xls")
    case "csv": ex1.RenderDelimited("rico.csv", ",", "")
    case else:  MyBase.Render(writer)   ' output html
  end select
End Sub

</script>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico SimpleGrid-Example 1</title>

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../../src/css/greenHdg.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />

<script type='text/javascript'>
Rico.onLoad( function() {
  if (!Prototype.Browser.IE) $('owc').disabled=true;
});

function ExportGridClient(ExportType) {
  ex1['grid'].printVisible(ExportType);
}

function ExportGridServer(ExportType) {
  if (Prototype.Browser.IE) {
    location.href+='?fmt='+ExportType;
  } else {
    window.open(location.href+'?fmt='+ExportType);
  }
}
</script>

</head>


<body>
<div id='explanation'>
This grid was created using the <a href='../grids.html'>SimpleGrid</a> plug-in!
Compare it to ex1simple.aspx - which is a LiveGrid.
</div>

<div>
<button onclick="ExportGridClient('plain')">Export from client to HTML Table</button>
<button onclick="ExportGridClient('owc')" id="owc">Export from client to OWC spreadsheet</button>
<button onclick="ExportGridServer('xl')">Export from server to Excel</button>
<button onclick="ExportGridServer('csv')">Export from server to CSV</button>
</div>

<Rico:SimpleGrid runat='server' id='ex1' FrozenCols='1'>
<GridColumns>
  <Rico:Column runat='server' spec='specQty' />
</GridColumns>
</Rico:SimpleGrid>

</body>
</html>
