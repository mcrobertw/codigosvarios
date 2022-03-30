<%@ Page Language="VB" ResponseEncoding="iso-8859-1" Debug="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Register TagPrefix="Rico" TagName="ChkLang" Src="chklang.ascx" %>
<%@ Register TagPrefix="My" TagName="AppLib" Src="applib.ascx" %>

<My:AppLib id='app' runat='server' />

<script runat="server">

sub DisplayTable()
  Dim cmd as OleDbCommand, rdr as OleDbDataReader, LastCountry as String
  if not app.OpenDB() then exit sub

  response.write("<p class='ricoBookmark'><span id='emptab_bookmark' style='font-size:10pt;'>&nbsp;</span></p>")
  response.write("<table id='emptab'>")

  ' put categories across the top
  response.write("<thead><tr><th>ID</th><th>Company</th>")
  cmd = new OleDbCommand("Select CategoryID, CategoryName From Categories Order By CategoryName", app.dbConnection)
  rdr = cmd.ExecuteReader()
  while rdr.Read()
    response.write("<th style='width:100px;'>" & rdr.GetString(1) & "</th>")
  end while
  rdr.Close()
  response.write("</tr></thead><tbody>")
  
  ' put countries down the side
  cmd = new OleDbCommand("Select CustomerID, CompanyName From Customers Order By CompanyName", app.dbConnection)
  rdr = cmd.ExecuteReader()
  while rdr.Read()
    response.write("<tr><td>" & rdr.GetValue(0) & "</td><td>" & rdr.GetValue(1) & "</td></tr>")
  end while
  rdr.Close()
  response.write("</tbody></table>")

  ' populate the pop-up menu
  response.write(vbLf & "<script type='text/javascript'>")
  response.write(vbLf & "function createSubMenus() {")
  cmd = new OleDbCommand("Select Country, EmployeeID, LastName From Employees Order By Country, LastName", app.dbConnection)
  rdr = cmd.ExecuteReader()
  while rdr.Read()
    if LastCountry <> rdr.GetValue(0) then
      LastCountry=rdr.GetValue(0)
      response.write(vbLf & "  var submenu = new Rico.Menu();")
      response.write(vbLf & "  submenu.createDiv();")
      response.write(vbLf & "  menu.addSubMenuItem('" & rdr.GetValue(0) & "',submenu);")
    end if
    response.write(vbLf & "  submenu.addMenuItem('" & rdr.GetValue(2) & "',function() {setEmployee('" & rdr.GetValue(1) & "','" & rdr.GetValue(2) & "');});")
  end while
  rdr.Close()
  response.write(vbLf & "}")
  response.write(vbLf & "<" & "/script>")
  app.CloseApp()
end sub

</script>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>

<title>Sales Assignments</title>

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />
<script type='text/javascript'>
Rico.include('greenHdg.css');

var menu,grid;

Rico.onLoad( function() {
  var gridopts = {  
    highlightElem    : 'selection',
    highlightSection : 2,
    canDragSelect    : true,
    frozenColumns    : 2,
    menuSection      : 2,
    visibleRows      : 'data',
    menuEvent        : 'contextmenu'
  };
  grid=new Rico.LiveGrid ('emptab', new Rico.Buffer.Base($('emptab').tBodies[0]), gridopts);
  menu=new Rico.Menu('7em');
  menu.createDiv();
  createSubMenus();
  grid.menu=menu;
});

function setEmployee(EmpId, Name) {
  menu.cancelmenu();
  grid.FillSelection(Name);
  grid.ShowSelection();
  grid.ClearSelection();
}
</script>

<style type="text/css">
div.container {
float:left;
margin-left:2%;
width:75%;
overflow:hidden; /* this is very important! */
}
</style>
<Rico:ChkLang runat='server' id='translation' />
</head>

<body>
<div style='float:left;font-size:9pt;width:18%;color:blue;font-family:Verdana, Arial, Helvetica, sans-serif;'>
<p>In this scenario, you are a sales manager and you must assign your sales staff by customer and product category.
<p>Drag over cells to select them (doesn't work in FF if the cell is empty). You can also select using shift-click and ctrl-click. 
Ctrl-click cannot be used to select in Safari or Opera because this is the combination to invoke the context menu on those browsers.
<p>Once some cells are selected, right-click (ctrl-click in Opera or Safari) to select an employee from the pop-up menu.
<p>The selection will be filled with the selected employee. Notice that the
employee names and selections scroll with the grid.
</div>

<div class="container">
<h2 class='appHeader'>Sales Assignments By Customer &amp; Product Category</h2>
<% 
DisplayTable()
%>
  
</div>
<!--
<textarea id='emptab_debugmsgs' rows='5' cols='80' style='font-size:smaller;'></textarea>
-->

</body>
</html>
