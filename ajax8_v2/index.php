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
	<script language="JavaScript" type="text/javascript" src="rico.js "></script>
	<script language="JavaScript" type="text/javascript" src="ricoAjaxEngine.js "></script>
	<script type="text/javascript">
		function llamarRICO(){
			ajaxEngine.registerRequest('mipeticion','dimehoraXML.php');
			ajaxEngine.registerAjaxElement('mostrar');
		}
	</script>
</head>
<body style="background-color: #006666" onload="llamarRICO();">		
	<center>
		<h1 class="Estilo2" style="color: #FFFF00">Nuestra primera aplicación Ajax</h1>
		<h2 class="Estilo1">Obtener la hora del servidor sin actualizar la página</h1>
		<form>
			<input type="button" class="Estilo2" onclick="ajaxEngine.sendRequest('mipeticion');" value="¿Cuál es la hora del servidor?">

		</form>
		<div id="mostrar" class="displaybox"></div>
	</center>
</body>
</html>