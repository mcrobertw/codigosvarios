<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Lector de valores usando prototype.js</title>
	<script language="JavaScript" type="text/javascript" src="prototype.js "></script>
	<script type="text/javascript">
		function actualizar(){
			var target=$('valores');
			if(!target) return false;
			new Ajax.PeriodicalUpdater(target,'rand.php',{frequency:'3'});
		}

		Event.observe(window,'load',actualizar,false);

	</script>
</head>
<body>
	<h2>Lector valores Acciones</h2>
	<h4>Ejemplo del uso de prototype.js</h4>
	<p>El precio actual de la acción es:</p>
	<div id="valores"> </div>
</body>
</html>