<?php
header("Cache-Control: no-cache");
header("Pragma: no-cache");
header("Expires: ".gmdate("D, d M Y H:i:s",time()+(-1*60))." GMT");
header("Content-type: text/xml");
echo "<"."?xml version='1.0' encoding='UTF-8'?".">\n";

include("weather/class.xml.parser.php");

// -----------------------------------------------------------------------------
// This script takes a "tags" parameter from the query string
// and returns a list of flickr photos with that tag in the Rico LiveGrid format
//
// PLEASE USE YOUR OWN FLICKR API KEY
// Get one at: http://flickr.com/services/
//
// Created by Matt Brown, Dec 2007
// -----------------------------------------------------------------------------

$flickrKey="3773d42a5766f0bd27caa1d584ae0bc9";
$id=isset($_GET["id"]) ? $_GET["id"] : "";
$tags=isset($_GET["tags"]) ? $_GET["tags"] : "";

echo "\n<ajax-response><response type='object' id='".$id."_updater'>";

print "\n<rows update_ui='true'>";

$url="http://api.flickr.com/services/rest/?method=flickr.photos.search";
$cnt=0;
if ($tags != "") {
  $url.="&safe_search=1";
  $url.="&tag_mode=all";
  $url.="&sort=interestingness-desc";
  $url.="&extras=date_taken,owner_name,geo,tags";
  $url.="&tags=".$tags;
  $url.="&api_key=".$flickrKey;
  $parser = new xmlParser();
  $parser->parse($url);
  $status=$parser->output[0]['attrs']['STAT'];
  
  // FOR DEBUGGING PURPOSES
  //print $status;
  //print "<hr><pre>";
  //print_r($parser->output);
  //print "</pre>";

  $content=&$parser->output[0]['child'][0]['child'];
  foreach ($content as $item) {
    if ($item['name'] == "PHOTO") {
      print "<tr>";
      // "_s" suffix specifies a 75x75 pixel format
      $photourl="http://farm".$item['attrs']['FARM'].".static.flickr.com/".$item['attrs']['SERVER']."/".$item['attrs']['ID']."_".$item['attrs']['SECRET']."_s.jpg";
      //print "<p><img src='".$photourl."'>";
      print XmlCell($photourl);
      print XmlCell($item['attrs']['TITLE']);
      print XmlCell($item['attrs']['OWNERNAME']);
      print XmlCell($item['attrs']['DATETAKEN']);
      print XmlCell($item['attrs']['TAGS']);
      print "</tr>";
      $cnt++;
    }
  }
}

print "\n"."</rows>";
echo "\n</response></ajax-response>";

function XmlCell($value) {
  return "<td>".htmlspecialchars($value)."</td>";
}

?>