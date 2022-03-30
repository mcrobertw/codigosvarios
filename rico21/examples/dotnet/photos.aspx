<%@ Page Language="VB" ResponseEncoding="iso-8859-1" Debug="true" %>
<%@ Register TagPrefix="Rico" TagName="LiveGrid" Src="../../plugins/dotnet/LiveGrid.ascx" %>
<%@ Register TagPrefix="Rico" TagName="Column" Src="../../plugins/dotnet/GridColumn.ascx" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico LiveGrid-Photo Example</title>

<script src="../../src/min.rico.js" type="text/javascript"></script>
<link href="../../src/css/min.rico.css" type="text/css" rel="stylesheet" />
<link href="../../src/css/greenHdg.css" type="text/css" rel="stylesheet" />
<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />

<script type='text/javascript'>
var img_popup, animator;

function photogrid_InitComplete() {
  // do something special when the mouse hovers over an image
  var c0=photogrid['grid'].columns[0];
  for (var i=0; i<c0._img.length; i++) {
    c0._img[i].onmouseover=img_mouseover;
    c0._img[i].onmouseout=img_mouseout;
  }
  img_popup=$('img_popup');
  animator=new Rico.Effect.Animator();
}

function img_mouseover(e) {
  e=e || event;
  Event.stop(e);
  var elem=Event.element(e);
  img_popup.style.display='block';
  var imgPos=Position.page(elem);
  img_popup.src=elem.src.replace(/_s\.jpg/,'_m.jpg');
  img_popup.style.left=(imgPos[0]+elem.offsetWidth+10)+'px';
  var winHt=RicoUtil.windowHeight();
  if (imgPos[1] > winHt/2) {
    img_popup.style.bottom=(winHt-imgPos[1]-elem.offsetHeight)+'px';
    window.status=img_popup.style.bottom;
    img_popup.style.top='';
  } else {
    img_popup.style.top=(imgPos[1])+'px';
    window.status=img_popup.style.top;
    img_popup.style.bottom='';
  }
  animator.stop();
  animator.play(new Rico.Effect.FadeIn(img_popup),{duration:750});
}

function img_mouseout(e) {
  e=e || event;
  Event.stop(e);
  animator.stop();
  animator.play(new Rico.Effect.FadeOut(img_popup),{duration:750});
}

function UpdateGrid() {
  var tags=$('tags').value;
  if (tags) {
    photogrid['buffer'].options.requestParameters=['tags='+tags];
    photogrid['grid'].filterHandler();
  } else {
    alert('Please enter one or more keywords separated by commas');
  }
}
</script>

<style type="text/css">
.ricoLG_bottom div.ricoLG_cell { height:80px; }  /* thumbnails are 75x75 pixels */
#explanation * { font-size: 8pt; }
</style>

</head>

<body>

<div id='explanation'><form onsubmit='UpdateGrid(); return false;'>
<p>Get <a href="http://www.flickr.com">Flickr</a> photos tagged with these keywords (separate words with commas):
<p><input type='text' id='tags'>
<input type='submit' value='Get Photos'>
<p>Then try moving your cursor over each photo...
</form></div>

<Rico:LiveGrid runat='server' id='photogrid' prefetchBuffer='false' dataProvider='flickrPhotos.aspx' headingSort='hover'>
<GridColumns>
  <Rico:Column runat='server' heading='Photo' width='90' control='new Rico.TableColumn.image()' />
  <Rico:Column runat='server' heading='Title' width='100' />
  <Rico:Column runat='server' heading='Owner' width='100' />
  <Rico:Column runat='server' heading='Date Taken' width='100' DataType='datetime' />
  <Rico:Column runat='server' heading='Tags' width='200' />
</GridColumns>
</Rico:LiveGrid>

<img id='img_popup' style='display:none;position:absolute;'>

</body>
</html>

