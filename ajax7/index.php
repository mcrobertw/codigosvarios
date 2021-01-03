<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Document</title>
	<script language="JavaScript" type="text/javascript">
			
			function getXMLHTTPRequest(){
				try{
						req=new XMLHttpRequest(); /*p.e. firefox*/
				}catch(err1){
						try{
							req=new ActiveXObject("Msxml2.XMLHTTP");/*Algunas versiones de I.E.*/
						}catch(err2){
							try{
								req=new ActiveXObject("Microsoft.XMLHTTP");/*Algunas versiones de I.E.*/
							}catch(err3){
								req=false;
							}
						}
				}
				return req;

			}

			

			function llamarAjax(){
				var apellido=document.form1.minombre.value;//Declara una variable que contiene alguna información para pasar al servidor
				var miAleatorio=parseInt(Math.random()*99999999);
				//var miAleatorio= new Date().getTime();Otra forma de engañar a la cache
				var url="miscriptdeservidor.php?apellido="+apellido+"&rand="+miAleatorio;//Construye la URL del script del servidor que queremos llamar 
				miPeticion.open("GET", url, true);//Pedimos a nuestro objeto XMLHTTPRequest que abra una conexión con el servidor
				miPeticion.onreadystatechange=respuestaAjax;//Preparamos la función respuestaAjax() para ejecutarse cuando la respuesta haya llegado
				miPeticion.send(null);
			}

			
			function respuestaAjax(){//respuestaAjax
				if(miPeticion.readyState == 4)
				{
					if(miPeticion.status == 200)
					{
						var nodoSaludo=miPeticion.responseXML.getElementsByTagName("saludo")[0];
						var textoSaludo=nodoSaludo.childNodes[0].nodeValue;
						document.getElementById('esperando').innerHTML=("Texto del saludo: "+textoSaludo);
					}
					else
					{
						alert("Ha ocurrido un error: " + miPeticion.statusText);
					}
				}else{
					document.getElementById('esperando').innerHTML='<img src="gusano.gif">';
				}
			}

			var miPeticion=getXMLHTTPRequest();
	</script>
</head>
<body>
			<div id="esperando"></div>
			<form name="form1">
				Nombre: <input type='text' name='minombre' onblur='llamarAjax()'><br>
				Teléfono: <input type='text' name='teln'><br>
				<input type="submit">
			</form>

</body>
</html>
