<?xml version='1.0' encoding='iso-8859-1'?>
<%@ Page Language="vb" Debug="true" %>
<%@ Register TagPrefix="Rico" TagName="XmlWriter" Src="../../plugins/dotnet/ricoXmlResponse.ascx" %>
<%@ Register TagPrefix="My" TagName="AppLib" Src="applib.ascx" %>
<My:AppLib id='app' runat='server' />

<script runat="server">

dim RequestId as string
dim parent as string

Sub Page_Load(Sender As object, e As EventArgs)
  Response.CacheControl = "no-cache"
  Response.AddHeader("Pragma", "no-cache")
  Response.Expires = -1
  Response.ContentType="text/xml"
  
  RequestId=trim(Request.QueryString("id"))
  parent=trim(Request.QueryString("Parent"))

  if RequestId="" then
    XmlObj.ErrorMsg="No ID provided!"
  elseif not app.OpenDB() then
    XmlObj.ErrorMsg=app.LastErrorMsg
  else
    XmlObj.dbConnection=app.dbConnection
    XmlObj.dbDialect=app.dbDialect
    if parent <> "" then
      XmlObj.sqlText="SELECT '" & parent & "',CustomerID,CompanyName,'L',1 FROM customers where CompanyName like '" & parent & "%'"
    else
      XmlObj.WriteTreeRow("","root","Customer names starting with...","C",0)
      XmlObj.sqlText="SELECT distinct 'root',left(CompanyName,1),left(CompanyName,1),'C',0 FROM customers"
    end if
  end if
End Sub

</script>

<ajax-response><response type='object' id='<%=RequestId%>_updater'>
<Rico:XmlWriter id="XmlObj" runat="server"/>
</response></ajax-response>
