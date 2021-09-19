<?php
	header('Content-Type: text/xml');
	echo "<?xml version=\"1.0\" ?><clock1><timenow>" . date('H:i:s') . "</timenow></clock1>";
?>
