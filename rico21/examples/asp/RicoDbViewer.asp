<%@ LANGUAGE="VBSCRIPT" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico-Table List</title>

<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />

<!-- #INCLUDE FILE = "applib.vbs" --> 

<style type="text/css">
html, body {
  height:97%;
  margin: 0px;
  padding: 0px;
  border: none;
}

#tablist {
  height:100%;
  width:25%;
  overflow:auto;
  float:left;
  border: 1px solid #EEE;
  font-size:smaller;
}

#detail {
  height:100%;
  width:70%;
  float:left;
  border: 1px solid #EEE;
}
</style>
</head>

<body>

<div id='tablist'>
<p><strong>Rico Raw Data Viewer</strong>
<%
if OpenDB then
  DisplaysObjects "TABLE"
  DisplaysObjects "VIEW"
end if
CloseApp


Sub DisplaysObjects(ObjType)
  Dim conn,rs,dbname,owner,table

  oDB.SplitTabName "X",dbname,owner,table
  set conn = oDB.Connection()
  Set rs = conn.OpenSchema (20, Array(dbname, owner, Empty, ObjType))
  response.write vbLf & "<p><strong>" & ObjType & "S</strong>"
  response.write vbLf & "<ul>"
  while not rs.eof
    response.write vbLf & "<li><a href='RicoDbViewerDetail.asp?id=" & rs("TABLE_NAME") & "' target='detail'>" & rs("TABLE_NAME") & "</a>"
    rs.movenext
  wend
  response.write vbLf & "</ul>"
  rs.Close
End Sub
%>
</div>

<iframe id='detail' name='detail'>

</body>
</html>
