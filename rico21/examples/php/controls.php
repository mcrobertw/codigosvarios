<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico-Popup Controls</title>

<script src="../../src/prototype.js" type="text/javascript"></script>
<script src="../../src/rico.js" type="text/javascript"></script>
<?php
require "chklang2.php";
?>
<script type='text/javascript'>
Rico.loadModule('Calendar','ColorPicker');
Rico.loadModule('Color');  // only required for ProcessColorSelection()

var cal,cal2,colorpicker,colorBox;

Rico.onLoad( function() {

  // initialize calendar  (addHoliday calls are optional)
  cal=new Rico.CalendarControl("cal1");
  cal.addHoliday(25,12,0,'Christmas','#F55','white');
  cal.addHoliday(1,1,0,'New Years','#2F2','white');
  cal.atLoad();
  cal.returnValue=function(newVal) { $('CalendarValue').value=newVal; };

  // initialize calendar #2 (show week #)
  cal2=new Rico.CalendarControl("cal2", {showWeekNumber:1});
  cal2.atLoad();
  cal2.returnValue=function(newVal) { $('CalendarValue2').value=newVal; };

  // initialize color picker
  colorpicker=new Rico.ColorPicker("colorpicker1");
  colorpicker.atLoad();
  colorpicker.returnValue=ProcessColorSelection;
  colorBox=$('ColorValue');
});

function ProcessColorSelection(newVal) {
  colorBox.value=newVal;
  // set text box background to the selected color
  colorBox.style.backgroundColor=newVal;
  colorBox.style.color= Prototype.Browser.WebKit ? 'black' : TextColor(newVal);
}

// choose black or white text - whichever gives the best contrast
function TextColor(hexval) {
  var objColor=Rico.Color.createFromHex(hexval);
  return (objColor.rgb.g > 160 || objColor.rgb.r+objColor.rgb.g+objColor.rgb.b > 480) ? 'black' : 'white';
}

function CalendarClick(e) {
  if (Element.visible(cal.container)) {
    cal.close();
  } else {
    RicoUtil.positionCtlOverIcon(cal.container,$('CalendarButton'));
    cal.open();
    cal2.close();
    colorpicker.close();
  }
  Event.stop(e);
}

function CalendarClick2(e) {
  if (Element.visible(cal2.container)) {
    cal2.close();
  } else {
    RicoUtil.positionCtlOverIcon(cal2.container,$('CalendarButton2'));
    cal.close();
    cal2.open();
    colorpicker.close();
  }
  Event.stop(e);
}

function ColorClick(e) {
  if (Element.visible(colorpicker.container)) {
    colorpicker.close();
  } else {
    RicoUtil.positionCtlOverIcon(colorpicker.container,$('ColorButton'));
    cal.close();
    cal2.close();
    colorpicker.open();
  }
  Event.stop(e);
}

var PopupCnt=0;
function DisplayText(e,winFlag) {
  var txt=$('TextBox').value;
  if (!txt) {
    alert('Enter some text first!');
    return;
  }
  var options={
    hideOnClick: false,
    zIndex     : ++PopupCnt   // ensures shadows layer correctly
  };
  var popup=new Rico.Popup(options);
  popup.options.canDragFunc=true;
  if (winFlag) {
    popup.createWindow('Window #'+PopupCnt,txt,'10em','20em');
  } else {
    popup.createPopup(document.body,txt,'10em','20em');
  }

  var color=colorBox.value || '#FFFFFF';         // get color picker value
  popup.contentDiv.style.backgroundColor=color;
  popup.contentDiv.style.color=TextColor(color);

  // pick a random location in the upper-left quadrant of the screen
  var x=Math.floor(Math.random()*RicoUtil.windowWidth()/2);
  var y=Math.floor(Math.random()*RicoUtil.windowHeight()/2);
  popup.openPopup(x,y);
  Event.stop(e);
}
</script>

<style>
body {font-family: Arial, Tahoma, Verdana;}
div.ricoPopup {
  background-color: white;
  border: 2px solid black;
  padding: 5px;
}
div.ricoWindow {
  border: 2px solid black;
}
.ricoTitle {
  padding: 3px;
  color: white;
  background-color: black;
}
#row1 span {
  font-size: 8pt;
}
</style>
</head>

<body>

<h2>Popup Controls Example</h2>

<table border='1' cellspacing='0' cellpadding='7'>
<tr id='row1' valign='top'>
<td><button id='CalendarButton' onclick='CalendarClick(event)'>Calendar</button></td>
<td><button id='CalendarButton2' onclick='CalendarClick2(event)'>Calendar with<br>Week Number</button></td>
<td><button id='ColorButton'    onclick='ColorClick(event)'>Color Picker</button></td>
</tr>
<tr>
<td><input type='text' id='CalendarValue' size='10'></td>
<td><input type='text' id='CalendarValue2' size='10'></td>
<td><input type='text' id='ColorValue' size='8'></td>
</tr>
</table>

<p><table border='1' cellspacing='0' cellpadding='7' style='background-color:#DDD;'>
<tr><td>
<span style='font-size:small;'>
Type or paste some text into the box, then click the button.
<br>Open popups can be dragged around the page.
<br>Color picker result will be used for the background color.
<br>Type "Esc" to close the popups.
</span>
<br><textarea id='TextBox' rows='6' cols='70'>
Lorem ipsum dolor sit amet, consectetur adipisicing elit, 
sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris 
nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in 
reprehenderit in voluptate velit esse cillum dolore eu fugiat 
nulla pariatur. Excepteur sint occaecat cupidatat non proident, 
sunt in culpa qui officia deserunt mollit anim id est laborum.
</textarea>
<br><button id='TextButton' onclick='DisplayText(event,false)'>Display text as popup</button>
<button id='TextButton' onclick='DisplayText(event,true)'>Display text as window</button>
</td></tr>
</table>

</body>
</html>
