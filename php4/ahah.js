function llamarAHAHCliente(url,elementoPag,mensLlamada){
	//alert(url+elementoPag+mensLlamada);
	document.getElementById(elementoPag).innerHTML=mensLlamada;
	try{
		miPeticion=new XMLHttpRequest(); /*p.e. firefox*/
	}catch(err1){
		try{
			miPeticion=new ActiveXObject("Msxml2.XMLHTTP");/*Algunas versiones de I.E.*/
		}catch(err2){
			try{
				miPeticion=new ActiveXObject("Microsoft.XMLHTTP");/*Algunas versiones de I.E.*/
			}catch(err3){
				miPeticion=false;
			}
		}
	}
	miPeticion.onreadystatechange=function(){manejarRespuestaAHAHServidor(elementoPag);};
	miPeticion.open("GET", url, true);
	miPeticion.send(null);
}

function manejarRespuestaAHAHServidor(elementoPag) {
    var resultado='';
    if (miPeticion.readyState == 4) {
        if (miPeticion.status == 200) {
		    resultado=miPeticion.responseText;
		    document.getElementById(elementoPag).innerHTML=resultado;
        } else {
			document.getElementById(elementoPag).innerHTML="";
    	}
	}else{//si readyState ha cambiado, pero readySate<>4
			//[Hacer algo aquí para proveer feedback al usuario]
	} 
}