<?php 
	header('Content-type: text/html; charset=utf-8');
	$tags=@get_meta_tags('http://'.$_GET["url"]);
	//$result=@$tags['keywords']; //Ya no se usa "keywords" según: https://es.semrush.com/blog/meta-keywords-definicion-y-mitos/
	$result=@$tags['description'];
	if(strlen($result)>0)
		echo $result;
	else
		echo "No disponible metatag Description";
	//var_dump($tags); Por si se quiere imprimir todos los meta de una página
?>