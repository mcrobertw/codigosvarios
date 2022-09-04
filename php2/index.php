<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Paso de parámetro get</title>
	<style>
		displaybox{
			width: 150px;
			background-color: #CC9900;
			border: 2px solid #000000;
			padding:10px;
			font: 24p normal verdana, helvetica, arial, sans-serif;
		}
	</style>
</head>
<body>
	<div class="displaybox">
		<?php  //Generará la salida XML
			//header('Content-Type: text/xml');	//Generará el header XML
			echo '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>';
			echo '<response>';
				$mejoresMarcasPortatil=array('MAC','ASUS','DELL');
				if (isset($_GET['name'])){
					$name=$_GET['name'];	//Recupera el nombre del usuario
					if(in_array(strtoupper($name), $mejoresMarcasPortatil))
						echo '&#161; Hola, es una buena marca de portatiles las '.htmlspecialchars($name).'!';
					else if(trim($name)=='')
						echo 'Escriba una marca de portatiles que prefiera';
					else
						echo htmlspecialchars($name).', no he comprado máquinas de ese tipo, no las puedo calificar';
				}
				else {
					echo "
						<ul>
						 	<li>Escriba una marca de portátiles (dell, asus, mac) para un resultado<br>
						 		Debe añadir a la  url el texto: <b>?name=asus</b> por ejemplo</li>
						 	<li>Cualquier otra marca para el otro resultado</li>
						 </ul>";
				}
			echo '</response>';
		?>
	</div>
	<div class="displaybox">
		<form action="ventajaget.php" method=get>
			<label for="name">Marca de Portatil</label><br>
  			<input type="text" name="name" value="asus">
  			<input type="submit" value="Archivo xml generado con php">
		</form>
	</div>
</body>
</html>