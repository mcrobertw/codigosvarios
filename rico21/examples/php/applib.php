<?php
//
// This is where the database connection settings go.
// This is required to get the LiveGrid examples running.
// As your application develops, this would also be a logical place to put security checks.
// The Northwind database is required to run the examples. 
// Samples of this database in various formats are located in the examples/data directory.
//


require "../../plugins/php/dbClass2.php";
$appName="Northwind";
$appDB="northwind";

function CreateDbClass() {
  global $oDB;
  $oDB = new dbClass();  // from dbClass2
  
  // What dialect of SQL will we be speaking?
  
  //$oDB->Dialect="MySQL"  // this is the default, so you can leave it commented
  //$oDB->Dialect="Oracle";
  //$oDB->Dialect="TSQL";
  //$oDB->Dialect="Access";
}

function OpenDB() {
  global $oDB;
  CreateDbClass();
  
  // This is where the database connection is made
  // Uncomment the appropriate line for your database
  
  // Using MySQL
  // $oDB->Provider="MySQLremoveserver"  // required if MySQL is remote
  return $oDB->MySqlLogon($GLOBALS['appDB'], "userid", "password");
  
  // Connect via ODBC to a DSN
  //return $oDB->OdbcLogon("northwindDSN","Northwind","userid","password");
  
  // Connect to Oracle XE
  // Make sure the Oracle database is loaded with the sample database
  // $oDB->Provider="MySQLremoveserver"  // required if Oracle is remote
  //return $oDB->OracleLogon("XE","northwind","password");
}

function OpenApp($title) {
  $_retval=false;
  if (!OpenDB()) {
    return $_retval;
  }
  if (!empty($title)) {
    AppHeader($GLOBALS['appName']."-".$title);
  }
  $GLOBALS['accessRights']="rw";
  // CHECK APPLICATION SECURITY HERE  (in this example, "r" gives read-only access and "rw" gives read/write access)
  if (empty($GLOBALS['accessRights']) || !isset($GLOBALS['accessRights']) || substr($GLOBALS['accessRights'],0,1) != "r") {
    echo "<p class='error'>You do not have permission to access this application";
  }
  else {
    $_retval=true;
  }
  return $_retval;
}

function OpenTableEdit($tabname) {
  $obj= new TableEditClass();
  $obj->SetTableName($tabname);
  $obj->options["XMLprovider"]="ricoXMLquery.php";
  $obj->convertCharSet=true;   // because sample database is ISO-8859-1 encoded
  return $obj;
}

function OpenGridForm($title, $tabname) {
  $_retval=false;
  if (!OpenApp($title)) {
    return $_retval;
  }
  $GLOBALS['oForm']= OpenTableEdit($tabname);
  $CanModify=($GLOBALS['accessRights'] == "rw");
  $GLOBALS['oForm']->options["canAdd"]=$CanModify;
  $GLOBALS['oForm']->options["canEdit"]=$CanModify;
  $GLOBALS['oForm']->options["canDelete"]=$CanModify;
  session_set_cookie_params(60*60);
  $GLOBALS['sqltext']='.';
  return true;
}

function CloseApp() {
  global $oDB;
  if (is_object($oDB)) $oDB->dbClose();
  $oDB=NULL;
  $GLOBALS['oForm']=NULL;
}

function AppHeader($hdg) {
  echo "<h2 class='appHeader'>".str_replace("<dialect>",$GLOBALS['oDB']->Dialect,$hdg)."</h2>";
}
?>

