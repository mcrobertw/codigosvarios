<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Capturador del Metatag 'Description'</title>
	<script language="JavaScript" type="text/javascript" src="ahah.js"></script>
</head>
<body>
	<form>
		<table>
			<tr><!--FILA 1-->
				<td>URL: http://</td>
				<td>
					<input type="text" id="miurl" size=30>
					<input type="button" onClick="llamarAHAHCliente('scriptservidor.php?url='+document.getElementById('miurl').value,'mostrardiv','Wait.. updating page')" value="Encuentra">
				</td>
			</tr>
			<tr><!--FILA 2-->
				<td colspan=2 height=50 id="mostrardiv"></td>

			</tr>
		</table>
	</form>	
</body>
</html>