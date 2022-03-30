<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico LiveGrid-SQL Parsing Tests</title>

<?php
require "../../plugins/php/dbClass2.php";
?>

<style type="text/css">
ol {
  margin-top:0px;
  margin-bottom:0px;
}
</style>
</head>

<body>
<p id='explanation' style='font-size:larger;'>
This example runs through several tests of the SQL Parser that is part of Rico's PHP Plug-in.
</p>
<?php
$cnt=0;
$oParse= new sqlParse();

RunTest("select col1,col2 as 'Column 2',col3 as 'Column 3' from Table1 order by 1");

RunTest("select col1,[ from here],col2,[ to there] as 'Description' from Table1 order by 1");

RunTest("select col1,\" from here\",col2,\" to there\" as 'Description' from AnsiTable1 order by 1");

RunTest("select distinct col1,col2 as 'Column 2',col3 as 'Column 3' from Table1 order by 1");

RunTest("SELECT name, qty, descr, color FROM s, sp, p " .
        "WHERE s.sno = sp.sno AND sp.pno = p.pno");
        
RunTest("SELECT DISTINCT a.pno FROM sp a, sp b " .
        "WHERE a.pno = b.pno AND a.sno <> b.sno");

RunTest("SELECT DISTINCT pno FROM sp a " .
        "WHERE pno IN (SELECT pno FROM sp b WHERE a.sno <> b.sno)");

RunTest("SELECT pno, qty, (SELECT city FROM s WHERE s.sno = sp.sno) FROM sp");

RunTest("SELECT pno, MIN(sno), MAX(qty), AVG(qty), COUNT(DISTINCT sno) " .
        "FROM sp GROUP BY pno");

RunTest("SELECT sno, COUNT(*) as parts " .
        "FROM sp " .
        "GROUP BY sno " .
        "HAVING COUNT(*) > 1");
        
RunTest("SELECT `ActiveBatches`.`id`, IFNULL(`ActiveBatches`.`DisplayName`, `ActiveBatches`.`Name`) AS `Name`, `ActiveBatches`.`CreationTime`, `u1`.`DisplayName` AS `CreationUser`, COUNT(*) AS `loanCount`, SUM(ActiveLoans.ErrorCount > 0) AS `errorLoanCount`, SUM(ActiveLoans.ErrorCount) AS `errorCount`, SUM(ActiveLoans.MissingCount) AS `missingCount`, `ActiveBatches`.`Status` AS `BatchStatus`, `ActiveBatches`.`Comments`, `ActiveBatches`.`Last Modified Time`, `u2`.`DisplayName` AS `Last Modified User` " .
        "FROM `ActiveBatches` " .
        "INNER JOIN `ActiveLoans` ON `ActiveLoans`.`BatchID`=`ActiveBatches`.`id` " .
        "LEFT JOIN `Users` AS `u1` ON `ActiveBatches`.`CreationUser`=`u1`.`id` " .
        "LEFT JOIN `Users` AS `u2` ON `ActiveBatches`.`LastModifiedUser`=`u2`.`id` GROUP BY `ActiveBatches`.`id`");

RunTest("SELECT CatId,CatName,EntryType,BuildDays,TaskAlias,1 as 'ALL'," .
        "(select top 1 TargetDate from DueDates where TaskId in (select TaskId from vTaskDays where Alias=pbc.TaskAlias and '20080101' between EffFrom and EffTo)) as TargetDate " .
        "FROM BuildCat pbc ORDER BY BuildDays,SortOrder");


function RunTest($sqltext) {
  global $oParse, $cnt;
  $cnt++;
  echo "<hr style='height:5px;margin-top:25px;background-color:navy;'><p>Test #" . $cnt . "<br>" . htmlspecialchars($sqltext);
  $oParse->Init(0);
  $oParse->ParseSelect($sqltext);
  $oParse->DebugPrint();
}
?>

</body>
</html>

