<!DOCTYPE html>
<html lang="en">
<head>
	
	<meta charset="UTF-8">

	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Un lector de Titulares RSS Ajax</title>
</head>
	<style>
		.title{
			font: 16px bold helvetica, arial, sans-serif;
			padding: 0px 30px 0px 30px;
			text-decoration: underline;
		}

		.descrip{
			font: 14px normal helvetica, arial, sans-serif;
			text-decoration: italic;
			padding: 0px 30px 0px 30px;
			background-color: #ccccc;
		}

		.link{
			font: 9px bold helvetica, arial, sans-serif;
			padding: 0px 30px 0px 30px;
		}

		.displaybox{
			border: 1px solid black;
			padding: 0px 50px 0px 50px;
		}
	</style>
	<script language="JavaScript" type="text/javascript" src="ajax.js"></script>
<body>
	<h3>Un lector RSS Ajax</h3>
	<form name="form1">
		URL o feed RSS: <input type="text" name="feed" size="50" value="http://">
		<input type="button" onClick="getRssAjax()" value="Obtener Feed">
		<br/><br/>
		<div id="news" lang="es" class="displaybox"><h4>Titulares Feeds</h4></div>
	</form>
</body>
</html>