function getXMLHTTPRequest(){
	return Try.these(
		function(){return new ActiveXObject("Msxml2.XMLHTTP")}, 
		function(){return new ActiveXObject("Microsoft.XMLHTTP")}, 
		function(){return new XMLHttpRequest()}
	)
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
		    var miTexto=miPeticion.responseText;
		    $('MiElementoPagina').innerHTML=miTexto;
        } else {
			$('MiElementoPagina').innerHTML="";
    	}
	}else{//si readyState ha cambiado, pero readySate<>4
			//[Hacer algo aquí para proveer feedback al usuario]
	} 
}

