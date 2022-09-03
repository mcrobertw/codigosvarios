<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Negocio Auto Partes - Portoviejo</title>
</head>
<body>
	<h1>Librer&iacute;a Online</h1>
	<h2>Resumen de pedido</h2>
	<?php
		echo "<p> Pedido procesado el ";//Start printing order

		echo date("jS F,H:i");
		echo "<br>";
		echo "<p>Su pedido es el siguiente:";
		echo "<br>";
		echo $_GET["actionqty"]." ActionScript<br>";
		echo $_GET["photoqty"]." Photoshop<br>";
		echo $_GET["flashqty"]." Flash MX<br>";

		$totalqty=0;
		$totalamount=0.00;

		define("ACTIONPRICE",100);
		define("PHOTOPRICE",10);
		define("FLASHPRICE",4);


		$totalqty=$_GET["actionqty"]+$_GET["photoqty"]+$_GET["flashqty"];
		$totalamount=$_GET["actionqty"]*ACTIONPRICE+$_GET["photoqty"]*PHOTOPRICE+$_GET["flashqty"]*FLASHPRICE;

		echo "<br>\n";
		echo "Artículos Pedidos: ".$totalqty."<br>\n";
		echo "Subtotal: $".number_format($totalamount,2);
		echo "<br>\n";
		$taxrate=0.10;
		$totalamount=$totalamount*(1+$taxrate);
		$totalamount=number_format($totalamount,2);
		echo "Total incluyendo inpuestos: ".$totalamount."<br>\n";

	?>
</body>
</html>