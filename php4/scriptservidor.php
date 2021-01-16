<?php 
	header('Content-type: text/html; charset=utf-8');
	$tags=@get_meta_tags('http://'.$_GET["url"]);
	var_dump($tags); //Por si se quiere imprimir todos los meta de una página
?>