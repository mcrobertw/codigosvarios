<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Propiedad "Select" JavaScript</title>
	<script type="text/javascript">
		function seleccionCajaTexto(){
			opcion= prompt("Ingrese");
			var oTextbox=document.getElementById(opcion);
			oTextbox.select();
		}
	</script>
</head>
<body>
			<table border=0>
				<tr bgcolor=#cccccc>
					<td colspan=2 align=center><font face="Arial, Helvetica, sans-serif">El jugo m&aacute;s refrescante</font></td>
				</tr>
				<tr>
					<td><font face="Arial, Helvetica, sans-serif">Opci&oacute;n 1:</font></td>
					<td align=center><font face="Arial, Helvetica, sans-serif"> 
						<input type="text" id="sabor1" size=10 maxlength=10 value="naranja">
					</font></td>
				</tr>
				<tr>
					<td><font face="Arial, Helvetica, sans-serif">Opci&oacute;n 2:</font></td>
					<td align=center><font face="Arial, Helvetica, sans-serif"> 
						<input type="text" id="sabor2" size=10 maxlength=10 value="maracuya">
					</font></td>
				</tr>
				<tr>
					<td colspan=2 align=center>
						<button onclick="seleccionCajaTexto()">Escriba "sabor1" o "sabor2"</button>
					</td>
				</tr>
			</table>
</body>
</html>