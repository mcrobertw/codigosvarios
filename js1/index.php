<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Uso de métodos DOM</title>
	<script language="javascript">
		function saludo()
		{
			var nodotexto=document.createTextNode('¡Buenos días!');
			document.getElementById('mostrardiv').appendChild(nodotexto);
		}
	</script>
</head>
<body onload="saludo()">
	Queremos colocar un texto aquí: </br>
	<div id="mostrardiv"></div>
</body>
</html>