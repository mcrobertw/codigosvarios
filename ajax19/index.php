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
		function utilizarFuncionGlobal_F(){
			alert($F('checkfield'));
		}

	</script>
</head>
<body style="background-color: #006666">
	<center>
		<h1 style="color: #FFFF00">Función global F de prototype.js</h1>
		
		<input type="text" id="entrada1" name="campotexto">
		<br>
		<select name="seleccion" id="entrada2">
			<option value="0">Opción A</option>
			<option value="1">Opción B</option>
			<option value="2">Opción C</option>
		</select>
		<br>
		<input type="text" id="textfield" name="textfield" value="campo de texto">
		<br>
		<textarea name="areafield" id="areafield" cols="5" rows="5"></textarea>
		<br>
		<select name="selectfield" id="selectfield">
			<option value="1" selected>One</option>
			<option value="2">Two</option>
		</select>
		<br>
		<input type="checkbox" id="checkfield" name="checkfield" value="1" checked/>
		
		<form>
			<input type="button" onclick="utilizarFuncionGlobal_F()" value="Usando Prototype.js">
		</form>


	</center>
</body>
</html>