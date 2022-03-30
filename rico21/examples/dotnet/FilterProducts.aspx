<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />

<script type='text/javascript'>
Rico.include('greenHdg.css');

Rico.onLoad( function() {
  var opts = {  
    frozenColumns: 1,
    fixedHdrRows : 1,
    columnSpecs  : [,'specDollar','specQty','specQty',{ClassName:'aligncenter'}]
  };
  var grid=new Rico.LiveGrid ('inventoryGrid', new Rico.Buffer.Base($('inventoryGrid'),opts), opts);
  grid.menu=new Rico.GridMenu();
});
</script>

</head>
<body>
<form runat="server">

View Products with a price greater than:
<asp:DropDownList ID="priceList" Runat="server">
   <asp:ListItem>0</asp:ListItem>
   <asp:ListItem>10</asp:ListItem>
   <asp:ListItem>25</asp:ListItem>
   <asp:ListItem>50</asp:ListItem>
</asp:DropDownList>
dollars.
<asp:Button Text="Refresh" OnClick="SortByPrice" Runat="server"/>
 
<br><br>
View Products that are out of stock.
<asp:Button Text="View Out of Stock" OnClick="ShowOutOfStock" Runat="server"/>

<br><br>
View Products that are discontinued.
<asp:Button Text="Discontinued" OnClick="ShowDisc" Runat="server"/>

<hr>

<p class="ricoBookmark"><span id="inventoryGrid_bookmark">&nbsp;</span></p>
<asp:DataGrid ID="inventoryGrid"
             EnableViewState="False"
             AutoGenerateColumns="False"
             HeaderStyle-Font-Bold
             Runat="server">
 <Columns>
  <asp:BoundColumn DataField="ProductName" HeaderText="Product"/>
  <asp:BoundColumn DataField="UnitPrice" HeaderText="Unit Price"/>
  <asp:BoundColumn DataField="UnitsInStock" HeaderText="# In Stock"/>
  <asp:BoundColumn DataField="UnitsOnOrder" HeaderText="# On Order"/>
  <asp:BoundColumn DataField="Discontinued" HeaderText="Discontinued?"/>
 </Columns>
</asp:DataGrid>
</form>

<!--
<textarea id='inventoryGrid_debugmsgs' rows='5' cols='80' style='font-size:smaller;'></textarea>
-->

</body>
</html>

<script runat="server" language="vb">
 
Protected northwindSet as DataSet
Protected filter as String 
 
Private Sub Page_Load(Sender As Object, e As EventArgs)
  if not IsPostBack then
    InitGrid()
  else
    northwindSet = Session("NorthwindDataSet")
    filter = CStr(Session("RowFilter"))
  End If
  Bind(filter)
End Sub
 
private Sub InitGrid()
  northwindSet = new DataSet("NorthWind")
  Dim nwindCon as new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;" & _
                        "Data Source=" & server.mappath("../data/Northwind.mdb") & ";User ID=;Password=;")
  Dim nwindAdapt as new OleDbDataAdapter("Select * from Products", nwindCon)
  nwindAdapt.Fill(northwindSet, "Products")
  Session.Add("NorthwindDataSet", northwindSet)
  Session.Add("RowFilter", "")
End Sub
 
private Sub Bind(strFilter as string)
  Session("RowFilter") = strFilter
  Dim customView as DataView 
  customView = northwindSet.Tables("Products").DefaultView
  customView.RowFilter = strFilter
  inventoryGrid.DataSource = customView
  inventoryGrid.DataBind()
End Sub
 
Protected Sub SortByPrice(sender as object, e as EventArgs)
  Dim price as String = priceList.SelectedItem.Text
  Bind("UnitPrice >= " & price)
End Sub
 
Protected Sub ShowOutOfStock(sender as object, e as EventArgs)
  Bind("UnitsInStock = 0")
End Sub

Protected Sub ShowDisc(sender as object, e as EventArgs)
  Bind("Discontinued = true")
End Sub

</script>
