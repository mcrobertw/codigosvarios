<?php
if (!isset ($_SESSION)) session_start();
header("Cache-Control: no-cache");
header("Pragma: no-cache");
header("Expires: ".gmdate("D, d M Y H:i:s",time()+(-1*60))." GMT");
header("Content-type: text/plain");  // for debugging
//header("Content-type: application/json");

require "applib.php";
require "../../plugins/php/ricoJSONResponse.php";

$id=isset($_GET["id"]) ? $_GET["id"] : "";
$offset=isset($_GET["offset"]) ? $_GET["offset"] : "0";
$size=isset($_GET["page_size"]) ? $_GET["page_size"] : "";
$total=isset($_GET["get_total"]) ? strtolower($_GET["get_total"]) : "false";
$distinct=isset($_GET["distinct"]) ? $_GET["distinct"] : "";

echo "{";
if (empty($id)) {
  ErrorResponse("No ID provided!");
} elseif ($distinct=="" && !is_numeric($offset)) {
  ErrorResponse("Invalid offset!");
} elseif ($distinct=="" && !is_numeric($size)) {
  ErrorResponse("Invalid size!");
} elseif ($distinct!="" && !is_numeric($distinct)) {
  ErrorResponse("Invalid distinct parameter!");
} elseif (!isset($_SESSION[$id])) {
  ErrorResponse("Your connection with the server was idle for too long and timed out. Please refresh this page and try again.");
} elseif (!OpenDB()) {
  ErrorResponse(htmlspecialchars($oDB->LastErrorMsg));
} else {
  $filters=isset($_SESSION[$id . ".filters"]) ? $_SESSION[$id . ".filters"] : array();
  $oDB->DisplayErrors=false;
  $oDB->ErrMsgFmt="MULTILINE";
  $oXmlResp= new ricoXmlResponse();
  $oXmlResp->sendDebugMsgs=true;
  $oXmlResp->convertCharSet=true;  // MySQL sample database is encoded with ISO-8859-1
  if ($distinct=="") {
    $oXmlResp->Query2xml($_SESSION[$id], intval($offset), intval($size), $total!="false", $filters);
  } else {
    $oXmlResp->Query2xmlDistinct($_SESSION[$id], intval($distinct), -1, $filters);
  }
  if (!empty($oDB->LastErrorMsg))
    echo ",\n\"error\": " . json_encode($oDB->LastErrorMsg);
  if (!empty($oXmlResp->LastErrorMsg))
    echo ",\n\"error\": " . json_encode($oXmlResp->LastErrorMsg);
  $oXmlResp=NULL;
  CloseApp();
}
echo "\n}";


function ErrorResponse($msg) {
  echo "\nupdate_ui=false,\n";
  echo "error:" . $msg;
}

?>