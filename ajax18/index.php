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
		function utilizarFuncionGlobal(){
			var nuevosdatos = $('caja1','caja2','caja3');
			$(nuevosdatos[0]).innerHTML="Estoy";
			$(nuevosdatos[1]).innerHTML="utilizando";
			$(nuevosdatos[2]).innerHTML="prototype.js";

		}

	</script>
</head>
<body style="background-color: #006666" onload="doAjax('dimehoraXML.php','','mostrar','post','1')">
	<center>
		<h1 style="color: #FFFF00">Función global $ de prototype.js</h1>
		<form>
			<input type="button" class="Estilo2" onclick="utilizarFuncionGlobal()" value="Usando Prototype.js">
		</form>
		<div id="caja1" class="displaybox">a</div>
		<div id="caja2" class="displaybox">b</div>
		<div id="caja3" class="displaybox">c</div>
	</center>
	
</body>
</html>