<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Acceso a las propiedades de un objeto literal</title>
	<script>
		var oCoche=new Object();
		oCoche.color="rojo";
		oCoche.puertas=4;
		oCoche.pagado=true;

		function sintaxisMostrarArray(){
			alert(oCoche.color);
			alert(oCoche.puertas);
			alert(oCoche.pagado);
			alert(oCoche["color"]);

		}
		
	</script>
</head>
<body onload="sintaxisMostrarArray()">
<body>
</html>