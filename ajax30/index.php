<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Creación de aplicación basada en rico</title>
	<style>
		body{
			font: 16px normal arial, helvetica, verdana;
			color: #660099;
			background-color: #009999;
		}

		div.simpleDropPanel{
			width:  260px;
			height: 180px;
			background-color:  #ffffff;
			padding:  5px;
			border:  1px solid #333333;
		}

		div.simpleDropPanel2{
			width:  260px;
			height: 180px;
			background-color:  #999999;
			padding:  5px;
			border:  1px solid #333333;
		}

		div.box{
			width:  200px;
			cursor: hand;
			background-color:  #ffffff;
			-moz-opacity: 0.6;
			filter:  alpha(Opacity=60);
			border:  1px solid #333333;
		}
	</style>
	
	<script language="JavaScript" type="text/javascript" src="rico.js "></script>
	<script language="JavaScript" type="text/javascript" src="ricoStyles.js "></script>
	<script language="JavaScript" type="text/javascript" src="ricoEffects.js "></script>
	<script language="JavaScript" type="text/javascript" src="ricoDragDrop.js "></script>
	<script language="JavaScript" type="text/javascript" src="prototype.js "></script>
	
</head>
<body>
	<table width="550">
	 	<tr>
		 	<td><h3>Arrastrar y Soltar</h3>
		 		<p>Arrastra y suelta los campos de datos dentro del campo de destino usando el bot&oacute;n izquierdo del rat&oacute;n del modo habitual en las aplicaciones de escritorio. Observa como el campo de destino disponible cambia de color durante la operaci&oacute;n de arrastre.</p>
		 		<p>Recarga la p&aacute;gina para empezar de nuevo.</p>
		 		<div class="box" id="draggable1">Puedes arrastrar este campo de datos</div>
		 		<div class="box" id="draggable2">Lo mismo puedes hacer con este</div>
		 		<div class="box" id="draggable3">Este tercero exactamente lo mismo</div>
		 		<br/>
			<table>
				<tr>
					<td>
						<div id="droponme" class="simpleDropPanel">
							<b>Zona Descarga 1</b> <br />
						</div>
					</td>
			 		<td>
						<div id="droponme2" class="simpleDropPanel2">
							<b>Zona Descarga 2</b> <br />
						</div>
					</td>
				</tr>
			 </table>
			</td>
		</tr>
	</table>
	<script>
		dndMgr.registerDraggable(new Rico.Draggable('foo','draggable1'));
		dndMgr.registerDraggable(new Rico.Draggable('foo','draggable2'));
		dndMgr.registerDraggable(new Rico.Draggable('foo','draggable3'));
		dndMgr.registerDropZone(new Rico.Dropzone('droponme'));
		dndMgr.registerDropZone(new Rico.Dropzone('droponme2'));
	</script>
</body>
</html>