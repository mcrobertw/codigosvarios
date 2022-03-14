<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Explorando Prototype.js</title>
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
		function habilitarForm()
		{
			Form.enable("miform");
		}
		function deshabilitarForm()
		{
			Form.disable("miform");
		}
	</script>
</head>
<body style="background-color: #006666">
	<center>
		<h1 style="color: #FFFF00">Función global Form de prototype.js</h1>
		
		<form id="miform" method="post">
			<input type="text" id="textfieldnombres" name="textfield" value="me">
			<br>
		</form>
		
		<input type="button" onclick="habilitarForm()" value="Habilitar Form">
		<input type="button" onclick="deshabilitarForm()" value="Deshabilitar Form">
		
	</center>
</body>
</html>