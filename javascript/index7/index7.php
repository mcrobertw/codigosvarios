<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Codificando un array literal javascript a una cadena string json</title>
	<scrip type="text/javascript" src="json2.js"></script>
	<script>
		var oCoche=new Object();
		oCoche.puertas=4;
		oCoche.color="azul";
		oCoche.fecha=1995;
		oCoche.conductores=new Array("Lolie","Jennifer","Andrea");
		function sintaxisMostrarArray(){
			document.write(JSON.stringify(oCoche));
		}	
	</script>
</head>
<body onload="sintaxisMostrarArray()">
<body>
</html>