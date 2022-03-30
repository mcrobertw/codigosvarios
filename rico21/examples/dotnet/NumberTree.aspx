<?xml version='1.0' encoding='iso-8859-1'?>
<%@ Page Language="vb" Debug="true" %>
<%@ Register TagPrefix="Rico" TagName="XmlWriter" Src="../../plugins/dotnet/ricoXmlResponse.ascx" %>

<script runat="server">

dim RequestId as string
dim parent as string
dim numdigits as string

Sub Page_Load(Sender As object, e As EventArgs)
  Response.CacheControl = "no-cache"
  Response.AddHeader("Pragma", "no-cache")
  Response.Expires = -1
  Response.ContentType="text/xml"
  
  RequestId=trim(Request.QueryString("id"))
  parent=trim(Request.QueryString("Parent"))
  numdigits=trim(Request.QueryString("digits"))
  dim i as integer
  dim n as integer = 5
  if IsNumeric(numdigits) then n=CInt(numdigits)

  if parent = "" then
    XmlObj.WriteTreeRow("","","Select a " & n & "-digit number","C",0)
  end if
  dim digitsRemaining as integer=n-len(parent)
  if digitsRemaining > 1 then
    dim suffix0 = New String("0",digitsRemaining-1)
    dim suffix9 = New String("9",digitsRemaining-1)
    for i=0 to 9
      XmlObj.WriteTreeRow(parent,parent & i,parent & i & suffix0 & "-" & parent & i & suffix9,"C",0)
    next
  else
    for i=0 to 9
      XmlObj.WriteTreeRow(parent,parent & i,parent & i,"L",1)
    next
  end if
End Sub

</script>

<ajax-response><response type='object' id='<%=RequestId%>_updater'>
<Rico:XmlWriter id="XmlObj" runat="server"/>
</response></ajax-response>
