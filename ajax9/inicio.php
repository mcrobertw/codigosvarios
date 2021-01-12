<?php  //Generará la salida XML
	header('Content-Type: text/xml');	//Generará el header XML
	echo '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>';
	echo '<response>';
		$name=$_GET['lenguaje'];	//Recupera el nombre del usuario
		$nombreLenguajes=array('C++','PYTHON','JAVA','PHP');
		if(in_array(strtoupper($name), $nombreLenguajes))
			echo '&#161; Hola, que buen lenguaje de programación! '.htmlspecialchars($name).'!';
		else if(trim($name)=='')
			echo 'Desconocido, dime el nombre de un lenguaje de programación(c++,python,java,php)';
		else
			echo htmlspecialchars($name).', no conozco ese lenguaje';
	echo '</response>';
?>