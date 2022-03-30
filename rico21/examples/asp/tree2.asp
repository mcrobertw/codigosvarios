<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>Rico-Tree Control</title>

<link href="../client/css/demo.css" type="text/css" rel="stylesheet" />
<script src="../../src/prototype.js" type="text/javascript"></script>
<script src="../../src/rico.js" type="text/javascript"></script>
<!-- #INCLUDE FILE = "chklang2.vbs" --> 
<script type='text/javascript'>
Rico.loadModule('Tree');
var tree1;

// initialize tree
Rico.onLoad( function() {
  tree1=new Rico.TreeControl("tree1", "NumberTree.asp", {showCheckBox:true});
  tree1.atLoad();
  tree1.returnValue=function(valueArray) { $('TreeValue1').value=valueArray.join(','); };
});

function TreeClick1(e) {
  if (Element.visible(tree1.container)) {
    tree1.close();
  } else {
    RicoUtil.positionCtlOverIcon(tree1.container,$('TreeButton1'));
    tree1.open();
  }
  Event.stop(e);
}
</script>

<style type="text/css">
div.ricoTree {
  background-color:#eeeedd;
}
</style>


</head>

<body>

<h2>Rico Tree Example #2</h2>

This example demonstrates a pop-up tree control where multiple items
may be selected using the checkboxes next to each item.
The data is contrived -- the tree consists of all possible 5-digit numbers.
However, it does demonstrate a tree with many, many nodes.

<p><button id='TreeButton1' onclick='TreeClick1(event)'>Show Tree</button>
<p><input type='text' id='TreeValue1' size='30'> (selected numbers)

<pre style='border:1px solid black;padding:3px;font-size:8pt;'>
Rico.onLoad( function() {
  tree1=new Rico.TreeControl("tree1", "NumberTree.asp", {showCheckBox:true});
  tree1.atLoad();
  tree1.returnValue=function(valueArray) { $('TreeValue1').value=valueArray.join(','); };
});
</pre>

</body>
</html>
