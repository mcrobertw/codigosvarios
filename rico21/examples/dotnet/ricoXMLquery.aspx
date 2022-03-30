<?xml version='1.0' encoding='iso-8859-1'?>
<%@ Page Language="vb" Debug="true" validateRequest="false" %>
<%@ Register TagPrefix="Rico" TagName="sqlParse" Src="../../plugins/dotnet/sqlParse.ascx" %>
<%@ Register TagPrefix="Rico" TagName="XmlWriter" Src="../../plugins/dotnet/ricoXmlResponse.ascx" %>
<%@ Register TagPrefix="My" TagName="AppLib" Src="applib.ascx" %>
<My:AppLib id='app' runat='server' />

<script runat="server">

dim RequestId as string

Sub Page_Load(Sender As object, e As EventArgs)
  Response.CacheControl = "no-cache"
  Response.AddHeader("Pragma", "no-cache")
  Response.Expires = -1
  Response.ContentType="text/xml"
  
  RequestId=trim(Request.QueryString("id"))
  dim RequestOffset as string = trim(Request.QueryString("offset"))
  dim RequestSize as string   = trim(Request.QueryString("page_size"))
  dim RequestTotal as string  = lcase(Request.QueryString("get_total"))
  dim distinct as string      = trim(Request.QueryString("distinct"))
  if not IsNumeric(RequestOffset) then RequestOffset="0"

  if RequestId="" then
    XmlObj.ErrorMsg="No ID provided!"
  elseif distinct="" and not IsNumeric(RequestOffset) then
    XmlObj.ErrorMsg="Invalid offset!"
  elseif distinct="" and not IsNumeric(RequestSize) then
    XmlObj.ErrorMsg="Invalid size!"
  elseif distinct<>"" and not IsNumeric(distinct) then
    XmlObj.ErrorMsg="Invalid distinct parameter!"
  elseif IsNothing(session.contents(RequestId)) then
    XmlObj.ErrorMsg="Your connection with the server was idle for too long and timed out. Please refresh this page and try again."
  elseif not app.OpenDB() then
    XmlObj.ErrorMsg=app.LastErrorMsg
  else
    dim sqltext as string = session.contents(RequestId)
    if RequestOffset<>"" then XmlObj.offset=CLng(RequestOffset)
    if RequestSize<>"" then XmlObj.numrows=CLng(RequestSize)
    if distinct<>"" then XmlObj.distinctCol=CLng(distinct)
    XmlObj.filters=session.contents(RequestId & ".filters")
    if ucase(left(sqltext,7))="SELECT " then
      XmlObj.oParse=new sqlParse()
      XmlObj.oParse.ParseSelect(sqltext)
    else
      ' stored procedure
      XmlObj.sqlText=sqltext
    end if
    XmlObj.dbConnection=app.dbConnection
    XmlObj.dbDialect=app.dbDialect
    XmlObj.sendDebugMsgs=true   ' true for development, false for production
    XmlObj.LogSqlOnError=true   ' true for development, false for production
    XmlObj.gettotal=(RequestTotal="true")
  end if
End Sub

</script>

<ajax-response><response type='object' id='<%=RequestId%>_updater'>
<Rico:XmlWriter id="XmlObj" runat="server"/>
</response></ajax-response>
