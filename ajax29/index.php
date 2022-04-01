<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Creación de aplicación basada en rico</title>
	<script language="JavaScript" type="text/javascript" src="prototype.js "></script>
	<script language="JavaScript" type="text/javascript" src="rico.js "></script>
	<script language="JavaScript" type="text/javascript" src="ricoAjaxEngine.js "></script>
	<script type="text/javascript">
		function llamarRICO(){
			ajaxEngine.registerRequest('mipet','respuestajax.php');
			ajaxEngine.registerAjaxElement('mostrar');
			ajaxEngine.registerAjaxElement('titular');
		}
	</script>
</head>
<body onload="llamarRICO();">
	 <div id="titular">
	 	<h3>Demostración del uso de Rico</h3>
	 </div>
	
	 <input type="button" value="Obtener Datos Servidor" onclick="ajaxEngine.sendRequest('mipet');">

	 <div id="mostrar">
	 	<p>Este texto debe ser reemplazado por los datos del servidor</p>
	 </div>
</body>
</html>