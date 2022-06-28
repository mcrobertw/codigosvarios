<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Javascript, mezclando objetos y arrays literales</title>
	<script>
		//Objeto que contiene dos arrays
		var oCocheInfo={
			"coloresDisponibles":["rojo","blanco","azul"],
			"puertasDisponibles":[2,4]
		};

		//Array que contiene tres objetos
		var aCoches=[
			{"color":"rojo","puertas":2,"pagado":true},
			{"color":"azul","puertas":4,"pagado":true},
			{"color":"blanco","puertas":2,"pagado":false}
		];

		function sintaxisMostrarArray(){
			alert(oCocheInfo.coloresDisponibles[1]); //Imprime "blanco"
			alert(aCoches[1].puertas);//Imprime 4
		}
		
	</script>
</head>
<body onload="sintaxisMostrarArray()">
<body>
</html>