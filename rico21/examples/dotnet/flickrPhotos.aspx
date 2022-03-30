<%@ Page Language="vb" Debug="true" validateRequest="false" %>
<%@ Register TagPrefix="Rico" TagName="XmlWriter" Src="flickrPhotos.ascx" %>

<script runat="server">

'' -----------------------------------------------------------------------------
'' This script takes a "tags" parameter from the query string
'' and returns a list of flickr photos with that tag in the Rico LiveGrid format
''
'' PLEASE USE YOUR OWN FLICKR API KEY
'' Get one at: http://flickr.com/services/
''
'' Created by Matt Brown, Dec 2007
'' -----------------------------------------------------------------------------

dim RequestId as string

Sub Page_Load(Sender As object, e As EventArgs)
  Response.CacheControl = "no-cache"
  Response.AddHeader("Pragma", "no-cache")
  Response.Expires = -1
  Response.ContentType="text/xml"
  
  RequestId=trim(Request.QueryString("id"))
  XmlObj.tags=trim(Request.QueryString("tags"))
  XmlObj.flickrKey= "3773d42a5766f0bd27caa1d584ae0bc9"
End Sub

</script>

<ajax-response><response type='object' id='<%=RequestId%>_updater'>
<Rico:XmlWriter id="XmlObj" runat="server"/>
</response></ajax-response>
