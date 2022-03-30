<%@ LANGUAGE="VBSCRIPT" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico SimpleGrid-Example 2</title>

<script src="../../src/prototype.js" type="text/javascript"></script>
<script src="../../src/rico.js" type="text/javascript"></script>
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />

<!-- #INCLUDE FILE = "../../plugins/asp/SimpleGrid.vbs" -->

<script type='text/javascript'>
Rico.loadModule('SimpleGrid','greenHdg.css');

Rico.onLoad( function() {
  var ex1=new Rico.SimpleGrid ('ex1');
});
</script>

<style type="text/css">
div.ricoLG_cell { 
  white-space: nowrap;
  text-align:  center;
  font-size:   12pt;
}
.ricoLG_bottom div.ricoLG_cell {
  height:      1.6em;
}
</style>
</head>


<body>

<%
dim action

action=trim(Request.Form("action"))
if action="" then
  DisplayForm
else
  DisplayResult
end if


sub DisplayResult()
  dim k,a
  response.write "<table id='results' border='1' cellspacing='0' cellpadding='4'>"
  response.write "<tr><th>Problem<th>Your answer<th>Result"
  for each k in Request.Form
    a=split(k,"_")
    select case a(0)
      case "p": CheckResult a(1),a(2),Request.Form(k),"+",CInt(a(1))+CInt(a(2))
      case "t": CheckResult a(1),a(2),Request.Form(k),"x",CInt(a(1))*CInt(a(2))
    end select
  next
  response.write "</table>"
end sub


sub CheckResult(a,b,answer,operator,correctAnswer)
  response.write "<tr><td>" & a & " " & operator & " " & b & "<td>" & answer & "<td>"
  if trim(answer)="" then
    response.write "no answer"
  elseif not IsNumeric(answer) then
    response.write "not a number"
  elseif CDbl(answer)=correctAnswer then
    response.write "correct!"
  else
    response.write "incorrect"
  end if
end sub


sub DisplayForm()
  dim grid,r,a,b
  
  set grid=new SimpleGrid  ' create instance of class
  
  ' define heading
  grid.AddHeadingRow true
  grid.AddCell "A"
  grid.AddCell "B"
  grid.AddCell "A + B"
  grid.AddCell "A x B"
  
  ' define data
  for r=3 to 9 step 2
    a=r
    b=r-2
    grid.AddDataRow
    grid.AddCell a
    grid.AddCell b
    grid.AddCell "<input type='text' size='3' name='p_" & a & "_" & b & "'>"
    grid.AddCell "<input type='text' size='3' name='t_" & a & "_" & b & "'>"
  next
  
  response.write "<div id='explanation'>This example shows how to use a SimpleGrid within a form.</div>"
  response.write "<p><strong>Try this simple math quiz:</strong>"
  response.write "<p><form method='post'>"
  response.write "<input type='hidden' name='action' value='calc_result'>"
  response.write "<input type='submit' value='Submit Answers'><p>"

  grid.Render "ex1", 2   ' output html
  
  response.write "</form>"
  set grid=Nothing       ' clean up
end sub
%>

</body>
</html>

