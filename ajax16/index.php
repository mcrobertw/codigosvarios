<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Nuestra Primera Aplicación Ajax</title>
	<style>
		.displaybox{
			width: 150px;
			background-color: #CC9900;
			border: 2px solid #000000;
			padding:10px;
			font: 24p normal verdana, helvetica, arial, sans-serif;
		}
	</style>
	<script language="JavaScript" type="text/javascript" src="libreria.js "></script>
	<script language="JavaScript" type="text/javascript">
		function mostrar(texto){
			var timeValue=miPeticion.responseXML.getElementsByTagName("timenow")[0];
		    document.getElementById('showtime').innerHTML=timeValue.childNodes[0].nodeValue;
		}	
	</script>
</head>
<body style="background-color: #006666" onload="doAjax('dimehoraXML.php','','mostrar','post','1')">
	<center>
		<h1 class="Estilo2" style="color: #FFFF00">Nuestra primera aplicación Ajax</h1>
		<h2 class="Estilo1">Obtener la hora del servidor sin actualizar la página</h1>
		<form>
			<input type="button" class="Estilo2" onclick="doAjax('dimehoraXML.php','','mostrar','post','1')" value="¿Cuál es la hora del servidor?">
		</form>
		<div id="showtime" class="displaybox"></div>
	</center>
	
</body>
</html>