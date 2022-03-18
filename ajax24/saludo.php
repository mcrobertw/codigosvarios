<?php 
	$nombre=htmlspecialchars($_GET["saludo-nombre"]);
	echo utf8_encode("<p>&iexcl;Est&aacute;s iniciando Sesi&oacute;n:&#33; $nombre</p>");
?>