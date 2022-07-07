<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Uso de librería JSon.php para codificar y decodificar mensajes JSON</title>
	

	
</head>
<body>
	<?php 

		class Persona{
			var $edad;
			var $colorPelo;
			var $nombre;
			var $nombresHermanos;

			function Persona($nombre, $edad, $colorPelo){
				$this->nombre=$nombre;
				$this->edad=$edad;
				$this->colorPelo=$colorPelo;
				$this->nombresHermanos=array();
			}

		}
		//Crear una instancia del objeto Json
		require_once("json.php");
		$oJSON=new Services_JSON();

		$oPersona= new Persona("Lolie",29,"negro");
		$oPersona->nombresHermanos[0]="Gabriela";
		$oPersona->nombresHermanos[1]="Lucia";

		//Para codificar un objeto PHP en un string JSON usamos el método encode()
		$sSalida=$oJSON->encode($oPersona);

		


		$sSalida=str_replace("\u00e1", "á", $sSalida);
		$sSalida=str_replace("\u00e9", "é", $sSalida);
		$sSalida=str_replace("\u00ed", "í", $sSalida);
		$sSalida=str_replace("\u00f3", "ó", $sSalida);
		$sSalida=str_replace("\u00fa", "ú", $sSalida);
		$sSalida=str_replace("\u00f1", "ñ", $sSalida);
		$sSalida=str_replace("\u00d1", "Ñ", $sSalida);
		$sSalida=str_replace("\u00c1", "Á", $sSalida);
		$sSalida=str_replace("\u00c9", "É", $sSalida);
		$sSalida=str_replace("\u00cd", "Í", $sSalida);
		$sSalida=str_replace("\u00d3", "Ó", $sSalida);
		$sSalida=str_replace("\u00da", "Ú", $sSalida);
		//Para decodificar un string JSON y crear un objeto PHP, le pasamos el string al método decode()

		echo "<h1>Mensaje Codificado a Json</h1>".$sSalida;


		$oPersona2=$oJSON->decode($sSalida);
//Esta línea siguiente ES OPCIONAL lo único que hace es crear manualmente la cadena JSON, 
//no es necesaria porque en la línea de arriba ya esta creado el mensaje JSON
		//$sSalida="{\"edad\":29,\"colorPelo\":\"negro\",\"nombre\":\"Lolie\",\"nombresHermanos\":[\"Gabriela\",\"Lucia\"]}";

		printf ("<h1>Mensaje Descodificado a PHP</h1>");
		print("<p>Nombre: ".$oPersona2->nombre."</br>");
		print("<p>Edad: ".$oPersona2->edad."</br>");
		print("<p>Color pelo: ".$oPersona2->colorPelo."</br>");
		
		print("<p><b>Nombre Hermanos </b><ul>");
		for($i=0;$i<count($oPersona->nombresHermanos);$i++){
			printf("<li>".$oPersona2->nombresHermanos[$i]."</li>");
		}
		print("</ul>");

	?>

</body>
</html>