<%@ Page Language="VB" ResponseEncoding="iso-8859-1" Debug="true" %>
<%@ Register TagPrefix="Rico" TagName="SimpleGrid" Src="../../plugins/dotnet/SimpleGrid.ascx" %>
<%@ Register TagPrefix="Rico" TagName="Column" Src="../../plugins/dotnet/GridColumn.ascx" %>
<%@ Register TagPrefix="My" TagName="AppLib" Src="applib.ascx" %>
<My:AppLib id='app' runat='server' />

<script runat="server">

Sub Page_Load(Sender As object, e As EventArgs)

  ' define heading
  ex3.AddHeadingRow(false)
  ex3.AddCell("ID")
  ex3.AddCell("ID")
  ex3.AddCell("Shipment")
  ex3.SetCellAttr("colspan",3)
  ex3.AddCell("Date")
  ex3.SetCellAttr("colspan",2)
  
  ex3.AddHeadingRow(true)
  ex3.AddCell("Order")
  ex3.AddCell("Customer")
  ex3.AddCell("Name")
  ex3.AddCell("City")
  ex3.AddCell("Country")
  ex3.AddCell("Order")
  ex3.AddCell("Ship")

  if not app.OpenDB() then exit sub
  dim command = app.dbConnection.CreateCommand()
  command.CommandText="select OrderID,CustomerID,ShipName,ShipCity,ShipCountry,OrderDate,ShippedDate from orders order by OrderID"
  dim rdr = command.ExecuteReader()
  dim fldNum as Integer
  while rdr.Read()
    ex3.AddDataRow()
    for fldNum = 0 to rdr.FieldCount-1
      if rdr.IsDBNull(fldNum) then
        ex3.AddCell("")
      else
        ex3.AddCell(server.HTMLEncode(rdr.GetValue(fldNum)))
      end if
    next
  end while
  rdr.Close()
End Sub

</script>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico SimpleGrid-Example 3</title>

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />
<link href="../../src/css/greenHdg.css" type="text/css" rel="stylesheet" />

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
This SimpleGrid demonstrates how filters can be applied as the user types.
Entries in the text boxes are case-insensitive.
Filtering is performed on the client -- responsiveness will vary with the speed of
the client computer, the number of rows in the grid, and the efficiency of the browser.
</div>

<p><button onclick="ex3['grid'].printVisible()">Export</button>
<Rico:SimpleGrid runat='server' id='ex3' FrozenCols='1' FilterLocation='-1'>
<GridColumns>
  <Rico:Column runat='server' />
  <Rico:Column runat='server' />
  <Rico:Column runat='server' filterUI='t' width='150' />
  <Rico:Column runat='server' filterUI='t' width='100' />
  <Rico:Column runat='server' filterUI='s' width='100' />
  <Rico:Column runat='server' width='90' />
  <Rico:Column runat='server' width='90' />
</GridColumns>
</Rico:SimpleGrid>

</body>
</html>
