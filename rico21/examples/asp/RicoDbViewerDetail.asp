<%@ LANGUAGE="VBSCRIPT" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico-Table Detail</title>

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../../src/css/greenHdg.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />

<!-- #INCLUDE FILE = "applib.vbs" --> 
<!-- #INCLUDE FILE = "chklang2.vbs" -->

<%
dim id,arColumns(100),i,columnlist,colspecs,colcnt
id=trim(request.querystring("id"))
if OpenDB then
  colcnt=oDB.GetColumnInfo(id,arColumns)
  for i=0 to colcnt-1
    if not IsEmpty(columnlist) then
      columnlist=columnlist & ","
      colspecs=colspecs & ","
    end if
    if left(arColumns(i).ColType,3)<>"???" then
      columnlist=columnlist & arColumns(i).ColName
    else
      columnlist=columnlist & "'?'"
    end if
    colspecs=colspecs & "{Hdg:'" & arColumns(i).ColName & "'"
    if arColumns(i).ColType="DATETIME" then colspecs=colspecs & ",type:'datetime'"
    colspecs=colspecs & "}"
  next
end if
CloseApp
session.contents(id)="select " & columnlist & " from [" & id & "]"
%>

<script type='text/javascript'>
Rico.onLoad( function() {
  var opts = {  
    useUnformattedColWidth: false,
    columnSpecs: [<%=colspecs%>]
  };
  var buffer=new Rico.Buffer.AjaxSQL('ricoXMLquery.asp', {TimeOut:<%=Session.Timeout%>});
  var grid=new Rico.LiveGrid ('<%=id%>', buffer, opts);
  grid.menu = new Rico.GridMenu();
});
</script>

<style type="text/css">
html { border: none; }
div.ricoLG_cell {
  white-space:nowrap;
}
</style>
</head>


<body>
<p><strong><%=id%></strong>
<p class="ricoBookmark"><span id='<%=id%>_timer' class='ricoSessionTimer'></span><span id="<%=id%>_bookmark">&nbsp;</span></p>
<div id="<%=id%>"></div>
</body>
</html>

