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
	<script language="JavaScript" type="text/javascript" src="libreria.js"></script>
	<script language="JavaScript" type="text/javascript">
		function mostrar(texto){
			var horaservidor=texto.getElementsByTagName("timenow")[0].childNodes[0].nodeValue;
			alert('La hora del servidor es:'+horaservidor);
		}	
	</script>
</head>
<body>
	
		<form name="form1">
		<input type="button" value="test" onclick="doAjax('dimehoraXML.php','','mostrar','post','1')" value="¿Cuál es la hora del servidor?">
		</form>
	
	
</body>
</html>