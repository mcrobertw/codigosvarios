< script language = "JavaScript" type = "text/javascript" > 
function respuestaAjax() {
    if (miPeticion.readyState == 4) {
        if (miPeticion.status == 200) {
            //[correcto - procesa respuesta del servidor]
        } else {
			//[fallo - informa del error HTTP]
    	}
	}else{//si readyState ha cambiado, pero readySate<>4
			//[Hacer algo aquí para proveer feedback al usuario]
	} 
}
< /script>