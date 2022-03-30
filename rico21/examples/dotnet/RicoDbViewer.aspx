<%@ Page Language="VB" ResponseEncoding="iso-8859-1" Debug="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Register TagPrefix="My" TagName="AppLib" Src="applib.ascx" %>
<My:AppLib id='app' runat='server' />

<script runat="server">

Sub Page_Load(Sender As object, e As EventArgs)
  Dim restrictions() As String = New String(3) {}
  if app.OpenDB() then
    restrictions(3)="TABLE"
    TableList.DataSource = app.dbConnection.GetSchema ("Tables", restrictions)
    TableList.DataBind()
    restrictions(3)="VIEW"
    ViewList.DataSource = app.dbConnection.GetSchema ("Tables", restrictions)
    ViewList.DataBind()
  end if
End Sub

</script>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico-Table List</title>

<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />

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

<p><strong>TABLES</strong>

<ul>
<asp:Repeater ID="TableList" Runat="server">
<ItemTemplate>
<li>
<asp:HyperLink runat="server" NavigateUrl='<%# "RicoDbViewerDetail.aspx?id=" & DataBinder.Eval(Container.DataItem, "TABLE_NAME")%>' Text='<%#DataBinder.Eval(Container.DataItem, "TABLE_NAME")%>' Target="detail" />
</li>
</ItemTemplate>
</asp:Repeater>
</ul>

<p><strong>VIEWS</strong>

<ul>
<asp:Repeater ID="ViewList" Runat="server">
<ItemTemplate>
<li>
<asp:HyperLink runat="server" NavigateUrl='<%# "RicoDbViewerDetail.aspx?id=" & DataBinder.Eval(Container.DataItem, "TABLE_NAME")%>' Text='<%#DataBinder.Eval(Container.DataItem, "TABLE_NAME")%>' Target="detail" />
</li>
</ItemTemplate>
</asp:Repeater>
</ul>

</div>

<iframe id='detail' name='detail'>

</body>
</html>
