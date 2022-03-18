<?php 
	$nombre=htmlspecialchars($_GET["nombreusuario"]);
	echo utf8_encode("<p>&iexcl;Est&aacute;s iniciando Sesi&oacute;n:&#33; $nombre</p>");
?>