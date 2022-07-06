<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Convirtiendo un string JSon a array literal javascript</title>
	<scrip type="text/javascript" src="json2.js"></script>
	<script>
		var sJSON="{\"coloresDisponibles\":[\"rojo\",\"azul\"],\"puertasDisponibles\":[2,4]}"
		//var oCocheInfo=eval("("+sJSON+")");
		var oCocheInfo=JSON.parse(sJSON);
		function sintaxisMostrarArray(){
			alert(oCocheInfo.coloresDisponibles[0]); //Imprime "rojo"
			alert(oCocheInfo.puertasDisponibles[1]);//Imprime 4
		}
		
	</script>
</head>
<body onload="sintaxisMostrarArray()">
<body>
</html>