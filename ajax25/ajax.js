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

var miPeticion=getXMLHTTPRequest();

function solicitudAjaxCliente(){
	if(miPeticion.readyState ==4 || miPeticion.readyState == 0)//Procede solo si el objeto http no está ocupado
	{
		name=encodeURIComponent(document.getElementById("saludo-nombre").value);//Recupera el nombre escrito por el usuario en el formulario
		miPeticion.open("GET", "saludo.php?nombreusuario="+name, true);//Ejecuta la página inicio.php desde el servidor
		miPeticion.onreadystatechange=manejarRespuestaAjaxServidor;
		miPeticion.send(null);

	}else {
		setTimeout('solicitudAjaxCliente()',1000);//Si la conexión está ocupada, prueba de nuevo después de un segundo
	}

}

function manejarRespuestaAjaxServidor() {
    if (miPeticion.readyState == 4) {
        if (miPeticion.status == 200) {
		    nombrecapturado=miPeticion.responseText;
		    //Actualizamos la pantalla del usuario usando datos recibidos del servidor
		    document.getElementById("muestraSaludo").innerHTML='<i>'+nombrecapturado+'</i>';
		    setTimeout('solicitudAjaxCliente()', 1000);//Reiniciamos la secuencia
        } else {
			document.getElementById('muestraSaludo').innerHTML='<img src="gusano.gif">';
    	}
	}else{//si readyState ha cambiado, pero readySate<>4
			//[Hacer algo aquí para proveer feedback al usuario]
			alert("Ha habido un problema al acceder al servidor: "+http.statusText);
	} 
}

