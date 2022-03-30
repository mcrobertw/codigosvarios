<%@ Page Language="VB" ResponseEncoding="iso-8859-1" Debug="true" %>
<%@ Register TagPrefix="Rico" TagName="SimpleGrid" Src="../../plugins/dotnet/SimpleGrid.ascx" %>

<script runat="server">

Sub Page_Load(Sender As object, e As EventArgs)
  dim r as integer, a as integer, b as integer
  
  ' define heading
  ex1.AddHeadingRow(true)
  ex1.AddCell("A")
  ex1.AddCell("B")
  ex1.AddCell("A + B")
  ex1.AddCell("A x B")
  
  ' define data
  for r=3 to 9 step 2
    a=r
    b=r-2
    ex1.AddDataRow
    ex1.AddCell(a)
    ex1.AddCell(b)
    ex1.AddCell("<input type='text' size='3' name='p_" & a & "_" & b & "'>")
    ex1.AddCell("<input type='text' size='3' name='t_" & a & "_" & b & "'>")
  next
End Sub

Protected Overrides Sub Render(writer as HTMLTextWriter)
  dim action as string=trim(Request.Form("action"))
  if action="" then
    MyBase.Render(writer)
  else
    dim k,a
    writer.write("<table id='results' border='1' cellspacing='0' cellpadding='4'>")
    writer.write("<tr><th>Problem<th>Your answer<th>Result")
    for each k in Request.Form
      a=split(k,"_")
      select case a(0)
        case "p": writer.write(CheckResult(a(1),a(2),Request.Form(k),"+",CInt(a(1))+CInt(a(2))))
        case "t": writer.write(CheckResult(a(1),a(2),Request.Form(k),"x",CInt(a(1))*CInt(a(2))))
      end select
    next
    writer.write("</table>")
  end if
End Sub

Function CheckResult(a,b,answer,op,correctAnswer)
  dim s as string="<tr><td>" & a & " " & op & " " & b & "<td>" & answer & "<td>"
  if trim(answer)="" then
    s &= "no answer"
  elseif not IsNumeric(answer) then
    s &= "not a number"
  elseif CDbl(answer)=correctAnswer then
    s &= "correct!"
  else
    s &= "incorrect"
  end if
  CheckResult=s
end Function

</script>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico SimpleGrid-Example 2</title>

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../../src/css/greenHdg.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />

<style type="text/css">
div.ricoLG_cell { 
  white-space: nowrap;
  text-align:  center;
  font-size:   12pt !important;
}
.ricoLG_bottom div.ricoLG_cell {
  height:      1.5em;
}
</style>
</head>

<body>

<div id='explanation'>
This example shows how to use a SimpleGrid within a form.
</div>

<p><strong>Try this simple math quiz:</strong>
<p><form method='post'>
<input type='hidden' name='action' value='calc_result'>
<input type='submit' value='Submit Answers'>

<p><Rico:SimpleGrid runat='server' id='ex1' FrozenCols='2' />

</form>
</body>
</html>
