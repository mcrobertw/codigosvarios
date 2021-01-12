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
		name=encodeURIComponent(document.getElementById("lenguajeProgramacion").value);//Recupera el nombre escrito por el usuario en el formulario
		miPeticion.open("GET", "inicio.php?lenguaje="+name, true);//Ejecuta la página inicio.php desde el servidor
		miPeticion.onreadystatechange=manejarRespuestaAjaxServidor;
		miPeticion.send(null);

	}else {
		setTimeout('solicitudAjaxCliente()',1000);//Si la conexión está ocupada, prueba de nuevo después de un segundo
	}
	
}

function manejarRespuestaAjaxServidor() {
    if (miPeticion.readyState == 4) {
        if (miPeticion.status == 200) {
		    xmlResponse =miPeticion.responseXML; //Extraemos el XML recuperado del servidor
		    xmlDocumentElement=xmlResponse.documentElement; //Obtenemos el "document element" (elemento raíz) de la estructura XML
		    helloMessage=xmlDocumentElement.firstChild.data; //Obtenemos el mensaje de texto, que esta en el primer hijo del document element

		    //Actualizamos la pantalla del usuario usando datos recibidos del servidor
		    document.getElementById("divMensajeConAjax").innerHTML='<i>'+helloMessage+'</i>';

		    setTimeout('solicitudAjaxCliente()', 1000);//Reiniciamos la secuencia
		    

        } else {
			document.getElementById('divMensajeConAjax').innerHTML='<img src="gusano.gif">';
    	}
	}else{//si readyState ha cambiado, pero readySate<>4
			//[Hacer algo aquí para proveer feedback al usuario]
			alert("Ha habido un problema al acceder al servidor: "+http.statusText);
	} 
}