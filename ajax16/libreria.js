function createREQ(){
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

	return miPeticion;
}

function requestGET(url, query, req){
	var myRand=parseInt(Math.random()*99999999999);
	req.open("GET",url+'?'+'query'+'&rand='+myRand,true);
	req.send(null);
}

function requestPOST(url,query,req){
	req.open("POST",url,true);
	req.setRequestHeader('Content-Type', 'application/x-www-form-unlencoded');
	req.send(query);
}


//Argumento 1: Función que se quiere usar como funcion de respuesta.
//Argumento 2: item, indicará si se gestion un texto o un xml
function doCallback(callback,item){
	eval(callback+'(item)');
}

function doAjax(url,query,callback,reqtype,getxml){
	//url:argumento al cual se hará la petición
	//query: La petición misma, debe estar codificada si es GET
	//callback: Función que se quiere ejecutar, que normalmente esta en la página, y es la encargada de hacer algo con la informaciòn
	//			qué sea recibida a través de la petición AJAX
	//reqtype: para especificar si es una petición GET o POST.
	//getxml: parámetro que como argumento hay que pasarle un "1" o un "0", ya que a  través de la funciòn
	//		  "doCallBack" se permitirá especificar si se quiere un retorno text o un retorno XML.
	var myreq=createREQ();
	myreq.onreadystatechange=function () {
		if(myreq.readyState==4){
			if(myreq.status==200){
				var item=myreq.responseText;
				if(getxml==1){
					item=myreq.responseXML;
				}
				doCallback(callback,item);
			}
		}
	}

	if(reqtype=='post'){
		requestPOST(url,query,myreq);
	}else{
		requestGET(url,query,myreq);
	}

}