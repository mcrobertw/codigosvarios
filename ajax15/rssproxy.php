<?php
	//https://www.youtube.com/watch?v=Eusph1nuod4&list=PLF49E524856DAD8F7&index=8     
	header('Content-type: text/xml');
	
	//[40:09-40:35] En algunos programas de servidor es necesario activarlos
	$mysession=curl_init($_GET['feed']);
	
	//[41:30-41:39] Indica que no se quiere recibir las cabeceras que envie la página RSS
	curl_setopt($mysession,CURLOPT_HEADER,false);
	
	//[41:41-41:46] Indica que si se quiere recibir los contenidos que tiene el archivo RSS
	curl_setopt($mysession,CURLOPT_RETURNTRANSFER,true);
	
	//[41:47-41:54] Lleva a cabo la transferencia de datos
	$out=curl_exec($mysession);

	//$out=utf8_encode($out);	//Si se ubica esta línea, aunque parezca mentira, no muestra ni eñes ni tildes

	echo $out;
	curl_close($mysession);
?>