<%@ Page Language="vb" Debug="true" validateRequest="false" %>
<%@ Register TagPrefix="Yahoo" TagName="weather" Src="yahooWeather.ascx" %>

<script runat="server">

'' -----------------------------------------------------------------------------
'' This script returns Yahoo weather data in the Rico LiveGrid format
''
'' Created by Matt Brown, Dec 2007
'' -----------------------------------------------------------------------------

dim RequestId as string

Sub Page_Load(Sender As object, e As EventArgs)
  Response.Expires = 60
  Response.ContentType="text/xml"
  
  RequestId=trim(Request.QueryString("id"))
  USCA0987.country=trim(Request.QueryString("c"))  ' country is a shared property, so setting it on one will set it on all
End Sub

</script>

<ajax-response><response type='object' id='<%=RequestId%>_updater'>
<rows update_ui='true' offset='0'>
<Yahoo:weather id="USCA0987" runat="server"/>
<Yahoo:weather id="USNY0996" runat="server"/>
<Yahoo:weather id="USTX0617" runat="server"/>
<Yahoo:weather id="MXDF0132" runat="server"/>
<Yahoo:weather id="MXGR0150" runat="server"/>
<Yahoo:weather id="CAXX0518" runat="server"/>
<Yahoo:weather id="CIXX0020" runat="server"/>
<Yahoo:weather id="BRXX0201" runat="server"/>
<Yahoo:weather id="ARBA0009" runat="server"/>
<Yahoo:weather id="AUXX0025" runat="server"/>
<Yahoo:weather id="BEXX0005" runat="server"/>
<Yahoo:weather id="DAXX0009" runat="server"/>
<Yahoo:weather id="FRXX0076" runat="server"/>
<Yahoo:weather id="GMXX0007" runat="server"/>
<Yahoo:weather id="ITXX0067" runat="server"/>
<Yahoo:weather id="NLXX0002" runat="server"/>
<Yahoo:weather id="NOXX0029" runat="server"/>
<Yahoo:weather id="SPXX0050" runat="server"/>
<Yahoo:weather id="SWXX0031" runat="server"/>
<Yahoo:weather id="SZXX0033" runat="server"/>
<Yahoo:weather id="UKXX0085" runat="server"/>
<Yahoo:weather id="RSXX0063" runat="server"/>
<Yahoo:weather id="CHXX0008" runat="server"/>
<Yahoo:weather id="CHXX0116" runat="server"/>
<Yahoo:weather id="INXX0096" runat="server"/>
<Yahoo:weather id="INXX0012" runat="server"/>
<Yahoo:weather id="ISXX0026" runat="server"/>
<Yahoo:weather id="IDXX0022" runat="server"/>
<Yahoo:weather id="JAXX0085" runat="server"/>
<Yahoo:weather id="SNXX0006" runat="server"/>
<Yahoo:weather id="KSXX0037" runat="server"/>
<Yahoo:weather id="ASXX0112" runat="server"/>
</rows>
</response></ajax-response>
