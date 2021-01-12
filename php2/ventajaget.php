<?php  //Generará la salida XML
	header('Content-Type: text/xml');	//Generará el header XML
	echo '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>';
	echo '<response>';
		$name=$_GET['name'];	//Recupera el nombre del usuario
		$userNames=array('MAYRA','ROBERT','AMAIA','DANTE');
		if(in_array(strtoupper($name), $userNames))
			echo '&#161; Hola, integrante de la familia MOREIRA VILLAVICENCIO '.htmlspecialchars($name).'!';
		else if(trim($name)=='')
			echo 'Desconocido, dime tu nombre, por favor';
		else
			echo htmlspecialchars($name).', no te conozco';
	echo '</response>';
?>