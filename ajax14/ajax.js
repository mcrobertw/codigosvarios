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
	var myurl='textoservidor.php';
	myRand=parseInt(Math.random()*99999999999);
	var modurl=myurl+"?rand="+myRand;
	miPeticion.open("GET", modurl, true);
	miPeticion.onreadystatechange=manejarRespuestaAjaxServidor;
	miPeticion.send(null);
}

function manejarRespuestaAjaxServidor() {
    if (miPeticion.readyState == 4) {
        if (miPeticion.status == 200) {
		    var miTexto=miPeticion.responseText.split("|");
		    var corte=miTexto.splice(0, 3);
		    document.getElementById('MiElementoPagina').innerHTML=miTexto;
        } else {
			document.getElementById('MiElementoPagina').innerHTML="";
    	}
	}else{//si readyState ha cambiado, pero readySate<>4
			//[Hacer algo aquí para proveer feedback al usuario]
	} 
}

