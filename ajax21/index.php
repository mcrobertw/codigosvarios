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
		function utilizarFuncionGlobal_Form(){
			campos=Form.serialize("miform");
			alert(campos);
		}

	</script>
</head>
<body style="background-color: #006666">
	<center>
		<h1 style="color: #FFFF00">Función global Form de prototype.js</h1>
		
		<form id="miform">
			<input type="text" id="textfield" name="textfield" value="me">
			<br>
			<textarea name="areafield" id="areafield" cols="5" rows="5">gusta</textarea>
			<br>
			<select name="selectfield" id="selectfield">
				<option value="1" selected>Programar</option>
				<option value="2">Cantar</option>
			</select>
			<br>
			<input type="checkbox" id="checkfield" name="checkfield" value="1" checked/>
		</form>
		
		<input type="button" onclick="utilizarFuncionGlobal_Form()" value="Usando Prototype.js">
		
	</center>
</body>
</html>