<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Pedidos Portoviejo</title>
</head>
<body background="fondo.jpg" background-repeat: no-repeat;>
	<div id="Layer1" style="position: absolute; width: 200px;height: 115px; z-index: 1; left: 46px;top: 206px;">
		<form action="procesarorden.php" method=get>
			<table border=0>
				<tr bgcolor=#cccccc>
					<td width=150><font face="Arial, Helvetica, sans-serif">Libro</font></td>
					<td width=15><font face="Arial, Helvetica, sans-serif">Cantidad</font></td>
				</tr>
				<tr>
					<td><font face="Arial, Helvetica, sans-serif">ActionScript</font></td>
					<td align=center><font face="Arial, Helvetica, sans-serif"> 
						<input type="text" name="actionqty" size=3 maxlength=3>
					</font></td>
				</tr>
				<tr>
					<td><font face="Arial, Helvetica, sans-serif">Photoshop</font></td>
					<td align=center><font face="Arial, Helvetica, sans-serif"> 
						<input type="text" name="photoqty" size=3 maxlength=3>
					</font></td>
				</tr>
				<tr>
					<td><font face="Arial, Helvetica, sans-serif">Flash MX</font></td>
					<td align=center><font face="Arial, Helvetica, sans-serif"> 
						<input type="text" name="flashqty" size=3 maxlength=3>
					</font></td>
				</tr>
				<tr>
					<td colspan=2 align=center><input type="submit" value="Enviar Pedido"></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>