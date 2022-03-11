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
	<script language="JavaScript" type="text/javascript" src="prototype.js "></script>
	<script language="JavaScript" type="text/javascript">
		function identificarObjeto(){
			var nuevosdatos1=document.getElementById("MiElementoPagina1");
			nuevosdatos1.innerHTML="<a>Hola javascript</a>";
			var nuevosdatos2=$("MiElementoPagina2");
			nuevosdatos2.innerHTML="<a>Hola Prototype.js</a>"
		}
	
	</script>
</head>
<body style="background-color: #006666">
	<center>
		<h1 style="color: #FFFF00">Usando JavaScript con librerías</h1>
		<h2>Cambiar el contenido de objetos usando javascript puro y luego a través de la librería Prototype.js</h1>
		<form>
			<input type="button" onclick="identificarObjeto()" value="Cambiar contenido de los dos divs de abajo: ">
		</form>
		<div id="MiElementoPagina1" class="displaybox"></div>
		<div id="MiElementoPagina2" class="displaybox"></div>
	</center>
	
</body>
</html>