<%
ScriptName=trim(Request.ServerVariables("SCRIPT_NAME"))
i=InStrRev(ScriptName,"/")
if (i>0) then ScriptName=mid(ScriptName,i+1)
scripts=array("ex1.asp","ex2.asp")
response.write "<strong style='color:brown;'>Rico LiveGrid - RTL Examples</strong>"
response.write "<table border='0' cellpadding='7'><tr>"
response.write "<td><a href='../../'>Examples Home</a></td>"
for k=0 to ubound(scripts)
  v=scripts(k)
  if (v=ScriptName) then
    response.write "<td><strong style='border:1px solid brown;color:brown;'>Ex " & mid(v,3,1) & "</strong></td>"
  else
    response.write "<td><a href='" & v & "'>Ex " & mid(v,3,1) & "</a></td>"
  end if
next
response.write "</tr></table>"
%>
