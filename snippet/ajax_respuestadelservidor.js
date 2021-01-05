< script language = "JavaScript" type = "text/javascript" > 
	function respuestaAjax() {
	    if (miPeticion.readyState == 4) {
	        if (miPeticion.status == 200) {
	            //Declaraciones a ejecutar por el programa
	        }
	    } else {
	        alert("Ha ocurrido un error: " + miPeticion.statusText);
	    }
	} 
< /script>