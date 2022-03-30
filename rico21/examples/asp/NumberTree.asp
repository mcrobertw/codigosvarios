<%@ LANGUAGE="VBSCRIPT" %>
<!-- #INCLUDE FILE = "../../plugins/asp/ricoXmlResponse.vbs" --> 
<%
dim id,parent,oXmlResp

id=trim(Request.QueryString("id"))
parent=trim(Request.QueryString("Parent"))
numdigits=trim(Request.QueryString("digits"))
if not IsNumeric(numdigits) then numdigits=5 else numdigits=CInt(numdigits)
response.clear
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
Response.ContentType="text/xml"
Response.write "<?xml version='1.0' encoding='iso-8859-1'?>" & vbLf
response.write vbLf & "<ajax-response><response type='object' id='" & id & "_updater'>"

if id="" then
  response.write vbLf & "<rows update_ui='false' /><error>"
  response.write vbLf & "No ID provided!"
  response.write vbLf & "</error>"
else
  set oXmlResp=new ricoXmlResponse

  response.write vbLf & "<rows update_ui='true' offset='0'>"
  if parent = "" then
    oXmlResp.WriteTreeRow "","","Select a " & numdigits & "-digit number","C",0
  end if
  digitsRemaining=numdigits-len(parent)
  if digitsRemaining > 1 then
    suffix0=string(digitsRemaining-1,"0")
    suffix9=string(digitsRemaining-1,"9")
    for i=0 to 9
      oXmlResp.WriteTreeRow parent,parent & i,parent & i & suffix0 & "-" & parent & i & suffix9,"C",0
    next
  else
    for i=0 to 9
      oXmlResp.WriteTreeRow parent,parent & i,parent & i,"L",1
    next
  end if
  response.write vbLf & "</rows>"
  set oXmlResp=Nothing
end if
response.write vbLf & "</response></ajax-response>"

%>