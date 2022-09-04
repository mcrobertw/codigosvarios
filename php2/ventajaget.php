<?php  //Generará la salida XML
	header('Content-Type: text/xml');	//Generará el header XML
	echo '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>';
	echo '<response>';
		$mejoresMarcasPortatil=array('MAC','ASUS','DELL');
		if (isset($_GET['name']))
		{
			$name=$_GET['name'];	//Recupera el nombre del usuario
			if(in_array(strtoupper($name), $mejoresMarcasPortatil))
				echo '&#161; Hola, es una buena marca de portatiles las '.htmlspecialchars($name).'!';
			else if(trim($name)=='')
				echo 'Escriba una marca de portatiles que prefiera';
			else
				echo htmlspecialchars($name).', no he comprado máquinas de ese tipo, no las puedo calificar';
		}
		else {
			echo "No marcas reconocidas";
		}
	echo '</response>';
?>