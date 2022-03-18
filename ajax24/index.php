<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Probando prototype.js</title>
	<script language="JavaScript" type="text/javascript" src="prototype.js "></script>
	<script language="JavaScript" type="text/javascript" src="ajax.js"></script>
</head>
<body>
	<form method="get" action="saludo.php" id="saludo-form">
		<div>
			<label for="saludo-nombre">Escribe tu nombre: </label>
			<input id="saludo-nombre" type="text"/>
			<input id="saludo-enviar" type="submit" value="Salúdame"/>
		</div>
		<div id="muestraSaludo"></div>
	</form>
</body>
</html>