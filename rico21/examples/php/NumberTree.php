<?php
header("Cache-Control: no-cache");
header("Pragma: no-cache");
header("Expires: ".gmdate("D, d M Y H:i:s",time()+(-1*60))." GMT");
header("Content-type: text/xml");
echo "<?xml version='1.0' encoding='iso-8859-1'?>\n";

require "../../plugins/php/ricoXmlResponse.php";

$id=isset($_GET["id"]) ? $_GET["id"] : "";
$parent=isset($_GET["Parent"]) ? $_GET["Parent"] : "";
$numdigits=isset($_GET["digits"]) ? $_GET["digits"] : "5";
echo "\n<ajax-response><response type='object' id='".$id."_updater'>";
$oXmlResp=new ricoXmlResponse();
echo "\n<rows update_ui='true' offset='0'>";
if ($parent == "") {
  $oXmlResp->WriteTreeRow("","","Select a ".$numdigits."-digit number","C",0);
}
$digitsRemaining=intval($numdigits)-strlen($parent);
if ($digitsRemaining > 1) {
  $suffix0=str_repeat("0",$digitsRemaining-1);
  $suffix9=str_repeat("9",$digitsRemaining-1);
  for ($i=0; $i<10; $i++) {
    $oXmlResp->WriteTreeRow($parent,$parent.$i,$parent.$i.$suffix0."-".$parent.$i.$suffix9,"C",0);
  }
} else {
  for ($i=0; $i<10; $i++) {
    $oXmlResp->WriteTreeRow($parent,$parent.$i,$parent.$i,"L",1);
  }
}
echo "\n</rows>";
$oXmlResp=NULL;
echo "\n</response></ajax-response>";

?>