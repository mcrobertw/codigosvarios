<%@ Page Language="VB" ResponseEncoding="iso-8859-1" Debug="true" %>

<script  runat="server">
' Populate the table
Sub Page_Load(sender As Object, e As EventArgs)
  dim rows,cells,j,i
  rows=100
  cells=15
  dim r0 As New TableRow()
  r0.TableSection=TableRowSection.TableHeader
  For i=1 To cells
    dim hdg As New TableCell()
    hdg.Controls.Add(New LiteralControl("Column " & i))
    r0.Cells.Add(hdg)
  Next
  ex1.Rows.Add(r0)
  For j=1 To rows
     dim r As New TableRow()
     dim c0 As New TableCell()
     c0.Controls.Add(New LiteralControl(j))
     r.Cells.Add(c0)
     For i=2 To cells
       dim c As New TableCell()
       c.Controls.Add(New LiteralControl("Cell " & j & ":" & i))
       r.Cells.Add(c)
     Next
     ex1.Rows.Add(r)
  Next
End Sub
</script>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico LiveGrid-Example 1</title>

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../../src/css/greenHdg.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />

<script type='text/javascript'>

Rico.onLoad( function() {
  alert('We are stopping here, at the start of the onload event, to show you that the grid is populated with data from a regular HTML table. This is what browsers with javascript disabled would display.');
  var opts = {  
    defaultWidth : 90,
    useUnformattedColWidth: false,
    columnSpecs  : ['specQty']
  };
  var buffer=new Rico.Buffer.Base($('ex1').tBodies[0]);
  var ex1=new Rico.LiveGrid ('ex1', buffer, opts);
  ex1.menu=new Rico.GridMenu();
});

</script>

</head>

<body>

<p class="ricoBookmark"><span id="ex1_bookmark">&nbsp;</span></p>
<asp:Table id="ex1" class="ricoLiveGrid" CellSpacing="0" runat="server" />

</body>
</html>
