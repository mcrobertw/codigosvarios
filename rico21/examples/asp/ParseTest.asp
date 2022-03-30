<%@ LANGUAGE="VBSCRIPT" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico LiveGrid-SQL Parsing Tests</title>

<!-- #INCLUDE FILE = "../../plugins/asp/dbClass2.vbs" -->

<style type="text/css">
ol {
  margin-top:0px;
  margin-bottom:0px;
}
</style>
</head>

<body>
<p id='explanation' style='font-size:larger;'>
This example runs through several tests of the SQL Parser that is part of Rico's ASP Plug-in.
</p>
<%
dim oParse,cnt
cnt=0
set oParse=new sqlParse
RunTest "select col1,col2 as 'Column 2',col3 as 'Column 3' from Table1 order by 1"

RunTest "select col1,[ from here],col2,[ to there] as 'Description' from Table1 order by 1"

RunTest "select col1,"" from here"",col2,"" to there"" as 'Description' from AnsiTable1 order by 1"

RunTest "select distinct col1,col2 as 'Column 2',col3 as 'Column 3' from Table1 order by 1"

RunTest "SELECT name, qty, descr, color FROM s, sp, p " & _
        "WHERE s.sno = sp.sno AND sp.pno = p.pno"
        
RunTest "SELECT DISTINCT a.pno FROM sp a, sp b " & _
        "WHERE a.pno = b.pno AND a.sno <> b.sno"

RunTest "SELECT DISTINCT pno FROM sp a " & _
        "WHERE pno IN (SELECT pno FROM sp b WHERE a.sno <> b.sno)"

RunTest "SELECT pno, qty, (SELECT city FROM s WHERE s.sno = sp.sno) FROM sp"

RunTest "SELECT pno, MIN(sno), MAX(qty), AVG(qty), COUNT(DISTINCT sno) " & _
        "FROM sp GROUP BY pno"

RunTest "SELECT sno, COUNT(*) as parts " & _
        "FROM sp " & _
        "GROUP BY sno " & _
        "HAVING COUNT(*) > 1"
        
RunTest "SELECT `ActiveBatches`.`id`, IFNULL(`ActiveBatches`.`DisplayName`, `ActiveBatches`.`Name`) AS `Name`, `ActiveBatches`.`CreationTime`, `u1`.`DisplayName` AS `CreationUser`, COUNT(*) AS `loanCount`, SUM(ActiveLoans.ErrorCount > 0) AS `errorLoanCount`, SUM(ActiveLoans.ErrorCount) AS `errorCount`, SUM(ActiveLoans.MissingCount) AS `missingCount`, `ActiveBatches`.`Status` AS `BatchStatus`, `ActiveBatches`.`Comments`, `ActiveBatches`.`Last Modified Time`, `u2`.`DisplayName` AS `Last Modified User` " & _
        "FROM `ActiveBatches` " & _
        "INNER JOIN `ActiveLoans` ON `ActiveLoans`.`BatchID`=`ActiveBatches`.`id` " & _
        "LEFT JOIN `Users` AS `u1` ON `ActiveBatches`.`CreationUser`=`u1`.`id` " & _
        "LEFT JOIN `Users` AS `u2` ON `ActiveBatches`.`LastModifiedUser`=`u2`.`id` GROUP BY `ActiveBatches`.`id`"

RunTest "SELECT CatId,CatName,EntryType,BuildDays,TaskAlias,1 as 'ALL'," & _
        "(select top 1 TargetDate from DueDates where TaskId in (select TaskId from vTaskDays where Alias=pbc.TaskAlias and '20080101' between EffFrom and EffTo)) as TargetDate " & _
        "FROM BuildCat pbc ORDER BY BuildDays,SortOrder"


set oParse=Nothing

sub RunTest(sqltext)
  cnt=cnt+1
  response.write "<hr style='height:5px;margin-top:25px;background-color:navy;'><p>Test #" & cnt & "<br>" & Server.HTMLEncode(sqltext)
  oParse.Init(0)
  oParse.ParseSelect sqltext
  oParse.DebugPrint
end sub
%>

</body>
</html>

