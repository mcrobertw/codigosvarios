<?php 
	$dias=array ('Lunes','Martes','Mi&eacute;rcoles','Jueves','Viernes','S&aacute;bado','Domingo');
	echo "<table border='2'>";
	echo utf8_encode("<tr><th>N&uacute;mero d&iacute;a</th><th>Nombre d&iacute;a</th></tr>");
		for($i=0;$i<7;$i++)
		{
		echo utf8_encode("<tr><td>".($i+1)."</td><td>".$dias[$i]."</td></tr>");
		}
	echo "</table>";
?>

