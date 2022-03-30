<?php
// -------------------------------------------------------------
// Check languages accepted by browser
// and see if there is a match
// -------------------------------------------------------------

function setLang() {
  $jsDir="../../../src/";  // this path will be application specific, the rest of this code should not require any customization
  $lang=strtolower($_SERVER["HTTP_ACCEPT_LANGUAGE"]);
  $arLang=explode(",",$lang);
  for ($i=0; $i<count($arLang); $i++)
  {
    $lang2=strtolower(substr(trim($arLang[$i]),0,2));
    if ($lang2=='en') break;
    $fname="translations/livegrid_".$lang2.".js";
    if (file_exists($jsDir.$fname))
    {
      echo "Rico.include('".$fname."');";
      break;
    } 
  }
}
?>

