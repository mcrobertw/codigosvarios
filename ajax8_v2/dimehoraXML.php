<?php
	header('Content-type: text/xml');
	header("Cache-Control:no-cache");
	header("Pragma:no-cache");
	echo ("<?xml version=\"1.0\" encoding=\"UTF-8\"?>
						<ajax-response>
							<response type=\"element\" id=\"mostrar\"><p>".date('H:i:s')."</p></response>
					  	</ajax-response>");

?>