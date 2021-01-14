<?php 
	$dias=array ('Lunes','Martes','Mi&eacute;rcoles','Jueves','Viernes','S&aacute;bado','Domingo');
	$numdias=sizeof($dias);
	for($i=0;$i<($numdias-1);$i++)
		echo utf8_encode($dias[$i]."|");
	echo utf8_encode($dias[$numdias-1]);
?>