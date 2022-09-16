<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Propiedad "createTextRange" IE</title>
	<script type="text/javascript">
		function seleccionCajaTexto(){
			var oTextbox=document.getElementById("cajatexto");
			var oRange=oTextbox.createTextRange();
			oRange.moveStart("character",0);
			oRange.moveEnd("character",3-oTextbox.value.length);
			oRange.select();
			oTextbox.focus();
		}
		var getBrowserInfo = function() {
		     var ua= navigator.userAgent, tem, 
		     M= ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
		    if(/trident/i.test(M[1])){
		         tem=  /\brv[ :]+(\d+)/g.exec(ua) || [];
		        return 'IE '+(tem[1] || '');
		    }
		    if(M[1]=== 'Chrome'){
		        tem= ua.match(/\b(OPR|Edg)\/(\d+)/);
		        if(tem!= null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
		    }
		    M= M[2]? [M[1], M[2]]: [navigator.appName, navigator.appVersion, '-?'];
		    if((tem= ua.match(/version\/(\d+)/i))!= null) M.splice(1, 1, tem[1]);
		    return M.join(' ');
		};
		function cargarTipoNavegador(){
			document.getElementById("tiponavegador").innerHTML=getBrowserInfo();
		}
	</script>
</head>
<body onload="cargarTipoNavegador()">
	<table border=0>
		<tr bgcolor=#cccccc>
			<td colspan=2 align=center id="tiponavegador"><font face="Arial, Helvetica, sans-serif"></font></td>
		</tr>
		<tr>
			<td><font face="Arial, Helvetica, sans-serif">Texto:</font></td>
			<td align=center><font face="Arial, Helvetica, sans-serif"> 
					<input type="text" id="cajatexto" size=55 maxlength=50 value="Es bueno dejar la bebida, lo malo es no acordarse d&oacute;nde.">
			</font></td>
		</tr>
		<tr>
			<td colspan=2 align=center>
				<button onclick="seleccionCajaTexto()">Seleccionar</button>
			</td>
		</tr>
	</table>
</body>
</html>