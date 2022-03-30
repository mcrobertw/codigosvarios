<?php

class ricoXmlResponse {

  // public properties
  var $orderByRef;
  var $sendDebugMsgs;
  var $readAllRows;    // always return the total number of rows? (if true, the user will always see the total number of rows, but there is a small performance hit)
  var $convertCharSet; // set to true if database is ISO-8859-1 encoded, false if UTF-8
  var $AllRowsMax;     // max # of rows to send if numrows=-1
 
  // private properties
  var $objDB;
  var $eof;
  var $oParse;
  var $sqltext;
  var $arParams;
  var $allParams;
  var $condType;

  function ricoXmlResponse() {
    if (is_object($GLOBALS['oDB'])) {
      $this->objDB=$GLOBALS['oDB'];   // use oDB global as database connection, if it exists
    }
    $this->orderByRef=false;
    $this->sendDebugMsgs=false;
    $this->readAllRows=true;    // has no effect on SQL Server 2005, Oracle, and MySQL because they use Query2xmlRaw_Limit()
    $this->convertCharSet=false;
    $this->AllRowsMax=1999;
  }

  // All Oracle and SQL Server 2005 queries *must* have an ORDER BY clause
  // "as" clauses are now ok
  // If numrows < 0, then retrieve all rows

  function Query2xml($sqlselect, $offset, $numrows, $gettotal, $filters=array()) {
    if ($numrows >= 0) {
      $Dialect=$this->objDB->Dialect;
    } else {
      $numrows=$this->AllRowsMax;
      $Dialect="";  // don't use limit query
    }
    if ($this->sendDebugMsgs) {
      echo "\n<debug>Query2xml: SQL Dialect=".htmlspecialchars($Dialect)."</debug>";
      echo "\n<debug>Query2xml: numrows=".$numrows."</debug>";
      echo "\n<debug>Query2xml: resource type=".get_resource_type($this->objDB->dbMain)."</debug>";
    }
    switch ($this->objDB->Dialect) {
      case "MySQL": $this->orderByRef=true; break;
    }
    $this->arParams=array('H'=>array(), 'W'=>array());
    $this->oParse= new sqlParse();
    $this->oParse->ParseSelect($sqlselect);
    $this->ApplyQStringParms($filters);
    $this->allParams=array_merge($this->arParams['W'],$this->arParams['H']);
    echo "\n<rows update_ui='true' offset='".$offset."'>";
    switch ($Dialect) {

      case "TSQL":
        $this->objDB->SingleRecordQuery("select @@VERSION", $version);
        if (strtoupper(substr($sqlselect,0,7))!="SELECT ") {
          $this->allParams=array();
          $totcnt=$this->Query2xmlRaw($sqlselect, $offset, $numrows);
        }
        else if (preg_match("/SQL Server 200(5|8)/i",$version[0])) {
          $this->sqltext=$this->UnparseWithRowNumber($offset, $numrows + 1, true);
          $totcnt=$this->Query2xmlRaw_Limit($this->sqltext, $offset, $numrows, 1);
        }
        else {
          $this->sqltext=$this->oParse->UnparseSelect();
          $totcnt=$this->Query2xmlRaw($this->sqltext, $offset, $numrows);
        }
        break;

      case "Oracle":
        $this->sqltext=$this->UnparseWithRowNumber($offset, $numrows + 1, false);
        $totcnt=$this->Query2xmlRaw_Limit($this->sqltext, $offset, $numrows, 1);
        break;

      case "MySQL":
        $this->sqltext=$this->oParse->UnparseSelect()." LIMIT ".$offset.",".($numrows + 1);
        $totcnt=$this->Query2xmlRaw_Limit($this->sqltext, $offset, $numrows, 0);
        break;

      default:
        $this->sqltext=$this->oParse->UnparseSelect();
        $totcnt=$this->Query2xmlRaw($this->sqltext, $offset, $numrows);
        break;
    }
    echo "\n</rows>";
    if ($this->sendDebugMsgs) {
      echo "\n<debug>origQuery=".htmlspecialchars($sqlselect)."</debug>";
      echo "\n<debug>execQuery=".htmlspecialchars($this->objDB->db->lastQuery)."</debug>";
    }
    if (!$this->eof && $gettotal) {
      $totcnt=$this->getTotalRowCount();
      if ($this->sendDebugMsgs) {
        echo "\n<debug>cntQuery=".htmlspecialchars($this->objDB->db->lastQuery)."</debug>";
      }
    }
    if ($this->eof) {
      echo "\n<rowcount>".$totcnt."</rowcount>";
    }
    $this->oParse=NULL;
    return $totcnt;
  }


  function Query2xmlDistinct($sqlselect, $colnum, $numrows, $filters=array()) {
    if ($numrows < 0) $numrows=$this->AllRowsMax;
    $this->arParams=array('H'=>array(), 'W'=>array());
    $this->oParse= new sqlParse();
    $this->oParse->ParseSelect($sqlselect);
    $this->ApplyQStringParms($filters);
    $this->allParams=array_merge($this->arParams['W'],$this->arParams['H']);
    echo "\n<rows update_ui='true' offset='0' distinct='" . $colnum . "'>";
    $this->sqltext=$this->oParse->UnparseDistinctColumn($colnum);
    $totcnt=$this->Query2xmlRaw($this->sqltext, 0, $numrows);
    echo "\n</rows>";
    if ($this->sendDebugMsgs) {
      echo "\n<debug>origQuery=".htmlspecialchars($sqlselect)."</debug>";
      echo "\n<debug>execQuery=".htmlspecialchars($this->objDB->db->lastQuery)."</debug>";
    }
    $this->oParse=NULL;
  }


  // Tested ok with SQL Server 2005, MySQL, and Oracle
  function getTotalRowCount() {
    $countSql="SELECT ".$this->oParse->UnparseColumnList()." FROM ".$this->oParse->FromClause;
    if (!empty($this->oParse->WhereClause)) {
      $countSql.=" WHERE ".$this->oParse->WhereClause;
    }
    if (is_array($this->oParse->arGroupBy)) {
      if (count($this->oParse->arGroupBy) >  0) {
        $countSql.=" GROUP BY ".implode(",",$this->oParse->arGroupBy);
      }
    }
    if (!empty($this->oParse->HavingClause)) {
      $countSql.=" HAVING ".$this->oParse->HavingClause;
    }
    $countSql="SELECT COUNT(*) FROM (".$countSql.")";
    if ($this->objDB->Dialect != "Oracle") {
      $countSql.=" AS rico_Main";
    }
    if (count($this->allParams)>0) {
      $rsMain=$this->objDB->RunParamQuery($countSql,$this->allParams);
    } else {
      $rsMain=$this->objDB->RunQuery($countSql);
    }
    if (!$rsMain) {
      echo "\n<debug>getTotalRowCount: rsMain is null</debug>";
      return;
    }
    if (!$this->objDB->db->FetchArray($rsMain,$a)) return;
    $this->objDB->rsClose($rsMain);
    $this->eof=true;
    return $a[0];
  }


  function UnparseWithRowNumber($offset, $numrows, $includeAS) {
    if (is_array($this->oParse->arOrderBy)) {
      if (count($this->oParse->arOrderBy) >  0) {
        $strOrderBy=implode(",",$this->oParse->arOrderBy);
      }
    }
    if (empty($strOrderBy) && !preg_match("/\bjoin\b/",$this->oParse->FromClause)) {
      // order by clause should be included in main sql select statement
      // However, if it isn't, then use primary key as sort - assuming FromClause is a simple table name
      $strOrderBy=$this->objDB->PrimaryKey($this->oParse->FromClause);
    }
    $unparseText="SELECT ROW_NUMBER() OVER (ORDER BY ".$strOrderBy.") AS rico_rownum,";
    $unparseText.=$this->oParse->UnparseColumnList()." FROM ".$this->oParse->FromClause;
    if (!empty($this->oParse->WhereClause)) {
      $unparseText.=" WHERE ".$this->oParse->WhereClause;
    }
    if (is_array($this->oParse->arGroupBy)) {
      if (count($this->oParse->arGroupBy) >  0) {
        $unparseText.=" GROUP BY ".implode(",",$this->oParse->arGroupBy);
      }
    }
    if (!empty($this->oParse->HavingClause)) {
      $unparseText.=" HAVING ".$this->oParse->HavingClause;
    }
    $unparseText="SELECT * FROM (".$unparseText.")";
    if ($includeAS) {
      $unparseText.=" AS rico_Main";
    }
    $unparseText.=" WHERE rico_rownum > ".$offset." AND rico_rownum <= ".($offset + $numrows);
    return $unparseText;
  }

  function Query2xmlRaw($rawsqltext, $offset, $numrows) {
    if (count($this->allParams)>0) {
      $rsMain=$this->objDB->RunParamQuery($rawsqltext,$this->allParams);
    } else {
      $rsMain=$this->objDB->RunQuery($rawsqltext);
    }
    if (!$rsMain) {
      echo "\n<debug>Query2xmlRaw: rsMain is null - ".htmlspecialchars(odbc_error())."</debug>";
      return;
    }
  
    $colcnt = $this->objDB->db->NumFields($rsMain);
    $totcnt = $this->objDB->db->NumRows($rsMain);
    //echo "<debug>Query2xmlRaw: NumRows=$totcnt</debug>";
    if ($offset < $totcnt || $totcnt==-1)
    {
      $rowcnt=0;
      $this->objDB->db->Seek($rsMain,$offset);
      while(($this->objDB->db->FetchRow($rsMain,$row)) && $rowcnt < $numrows)
      {
        $rowcnt++;
        print "\n<tr>";
        for ($i=0; $i < $colcnt; $i++)
          print $this->XmlStringCell($row[$i]);
        print "</tr>";
      }
      if ($totcnt < 0) {
        $totcnt=$offset+$rowcnt;
        while($this->objDB->db->FetchRow($rsMain,$row))
          $totcnt++;
      }
    }
    else
    {
      $totcnt=$offset;
    }
    $this->objDB->rsClose($rsMain);
    $this->eof=true;
    return $totcnt;
  }

  function Query2xmlRaw_Limit($rawsqltext, $offset, $numrows, $firstcol) {
    if (count($this->allParams)>0) {
      $rsMain=$this->objDB->RunParamQuery($rawsqltext,$this->allParams);
    } else {
      $rsMain=$this->objDB->RunQuery($rawsqltext);
    }
    if ($this->objDB->db->HasError()) echo "<error>" . $this->objDB->db->ErrorMsg() . "</error>";
    $totcnt=$offset;
    $this->eof=true;
    if (!$rsMain) {
      echo "<debug>Query2xmlRaw_Limit: rsMain is null</debug>";
      return;
    }
    $colcnt = $this->objDB->db->NumFields($rsMain);
    $rowcnt=0;
    while(($this->objDB->db->FetchRow($rsMain,$row)) && $rowcnt < $numrows)
    {
      $rowcnt++;
      print "\n<tr>";
      for ($i=$firstcol; $i < $colcnt; $i++)
        print $this->XmlStringCell($row[$i]);
      print "</tr>";
    }
    $totcnt+=$rowcnt;
    $this->eof=($rowcnt < $numrows);
    $this->objDB->rsClose($rsMain);
    return $totcnt;
  }

  function SetDbConn(&$dbcls) {
    $this->objDB=&$dbcls;
  }

  function PushParam($newvalue) {
    $parm=$this->convertCharSet ? utf8_decode($newvalue) : $newvalue;
    if (get_magic_quotes_gpc()) $parm=stripslashes($parm);
    array_push($this->arParams[$this->condType], $parm);
    if ($this->sendDebugMsgs) {
      echo "\n<debug>".$this->condType." param=".htmlspecialchars($parm)."</debug>";
    }
  }
  
  function setCondType($selectItem) {
    $this->condType=(preg_match("/\bmin\(|\bmax\(|\bsum\(|\bcount\(/i",$selectItem) && !preg_match("/\bselect\b/i",$selectItem)) ? 'H' : 'W';
  }
  
  function addCondition($newfilter) {
    switch ($this->condType) {
      case 'H': $this->oParse->AddHavingCondition($newfilter); break;
      case 'W': $this->oParse->AddWhereCondition($newfilter); break;
    }
  }

  function ApplyQStringParms($filters) {
    foreach($_GET as $qs => $value) {
      $prefix=substr($qs,0,1);
      switch ($prefix) {

        // user-invoked condition
        case "w":
        case "h":
          $i=substr($qs,1);
          if (!is_numeric($i)) break;
          $i=intval($i);
          if ($i<0 || $i>=count($filters)) break;
          $newfilter=$filters[$i];
          $this->condType=strtoupper($prefix);

          $j=strpos($newfilter," in (?)");
          if ($j !== false) {
            $a=explode(",", $value);
            for ($i=0; $i < count($a); $i++) {
              $this->PushParam($a[$i]);
              $a[$i]="?";
            }
            $newfilter=substr($newfilter,0,$j+4) . implode(",",$a) . substr($newfilter,$j+5);
          } elseif (strpos($newfilter,"?") !== false) {
            $this->PushParam($value);
          }

          $this->addCondition($newfilter);
          break;

        // sort
        case "s":
          $i=substr($qs,1);
          if (!is_numeric($i)) break;
          $i=intval($i);
          if ($i<0 || $i>=count($this->oParse->arSelList)) break;
          $value=strtoupper(substr($value,0,4));
          if (!in_array($value,array('ASC','DESC'))) $value="ASC";
          if ($this->orderByRef)
            $this->oParse->AddSort(($i + 1)." ".$value);
          else
            $this->oParse->AddSort($this->oParse->arSelList[$i]." ".$value);
          break;

        // user-supplied filter
        case "f":
          //print_r($value);
          foreach($value as $i => $filter) {
            if ($i<0 || $i>=count($this->oParse->arSelList)) break;
            $newfilter=$this->oParse->arSelList[$i];
            $this->setCondType($newfilter);
            switch ($filter['op']) {
              case "EQ":
                if ($filter[0]=="") {
                  if ($this->objDB->Dialect=="Access") {
                    $newfilter="iif(IsNull(" . $newfilter . "),''," . $newfilter . ")";
                  } else {
                    $newfilter="coalesce(" . $newfilter . ",'')";
                  }
                }
                $newfilter.="=?";
                $this->PushParam($filter[0]);
                break;
              case "LE":
                $newfilter.="<=?";
                $this->PushParam($filter[0]);
                break;
              case "GE":
                $newfilter.=">=?";
                $this->PushParam($filter[0]);
                break;
              case "NULL": $newfilter.=" is null"; break;
              case "NOTNULL": $newfilter.=" is not null"; break;
              case "LIKE":
                $newfilter.=" LIKE ?";
                $this->PushParam(str_replace("*",$this->objDB->Wildcard,$filter[0]));
                break;
              case "NE":
                $flen=$filter['len'];
                if (!is_numeric($flen)) break;
                $flen=intval($flen);
                $newfilter.=" NOT IN (";
                for ($j=0; $j<$flen; $j++) {
                  if ($j > 0) $newfilter.=",";
                  $newfilter.='?';
                  $this->PushParam($filter[$j]);
                }
                $newfilter.=")";
                break;
            }
            $this->addCondition($newfilter);
          }
          break;
      }
    }
  }

  function XmlStringCell($value) {
    if (!isset($value)) {
      $result="";
    }
    else {
      if ($this->convertCharSet) $value=utf8_encode($value);
      $result=htmlspecialchars($value, ENT_COMPAT, 'UTF-8');
    }
    return "<td>".$result."</td>";
  }

  // for the root node, parentID should "" (empty string)
  // containerORleaf: L/zero (leaf), C/non-zero (container)
  // selectable:      0->not selectable, 1->selectable
  function WriteTreeRow($parentID, $ID, $description, $containerORleaf, $selectable) {
    echo "\n<tr>";
    echo $this->XmlStringCell($parentID);
    echo $this->XmlStringCell($ID);
    echo $this->XmlStringCell($description);
    echo $this->XmlStringCell($containerORleaf);
    echo $this->XmlStringCell($selectable);
    echo "</tr>";
  }

}

?>

