<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Document</title>
	<style>
		displaybox{
			width: 150px;
			background-color: #CC9900;
			border: 2px solid #000000;
			padding:10px;
			font: 24p normal verdana, helvetica, arial, sans-serif;
		}
	</style>
</head>
<body>
	<div class="displaybox">
		<?php
			echo "<?xml version=\"1.0\" ?>
			<saludo>Bienvenido, usuario de Ajax</saludo>
			";	
		?>	
	</div>
	<div class="displaybox">
		<?php
			echo "<img src=\"fondo.jpg\">";
		?>
	</div>
	
	
</body>
</html>