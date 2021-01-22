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

function getRssAjax(){
	var myurl='rssproxy.php?feed=';
	var myfeed=document.form1.feed.value;
	var myRand=parseInt(Math.random()*99999999999);

	var modurl=myurl+escape(myfeed)+"&rand="+myRand;
	miPeticion.open("GET",modurl,true);
	miPeticion.onreadystatechange=lectorPhpParaAjax;
	miPeticion.send(null);
}

function lectorPhpParaAjax() {
    if (miPeticion.readyState == 4) {
        if (miPeticion.status == 200) {
            //[correcto - procesa respuesta del servidor]

            //Primero elimino los nodos hijos
            //Presento en el contenedor div
            while(document.getElementById('news').hasChildNodes())
            {
            	document.getElementById('news').removeChild(document.getElementById('news').firstChild);
            }

            var titleNodes=miPeticion.responseXML.getElementsByTagName("title");
            var descriptionNodes=miPeticion.responseXML.getElementsByTagName("description");
            var linkNodes=miPeticion.responseXML.getElementsByTagName("link");
            for(var i=1;i<titleNodes.length;i++)
            {
            	//https://www.youtube.com/watch?v=Eusph1nuod4&list=PLF49E524856DAD8F7&index=8      [33:38-33:48]
                //La creación de elementos de página se va hacer  para cada uno de los titulares que se recuperen
                
                /*[36:27-36:52].- PRIMERO se extrae la información, SEGUNDO se crea un párrafo
                    TERCERO añadir párrafo como hijo al contenedor DIV, CUARTO usar como hijo del parrafo el texto
                    QUINTO aplicar estilo
                */
                var newtext=document.createTextNode(titleNodes[i].childNodes[0].nodeValue);
            	var newpara=document.createElement('p');
            	var para=document.getElementById('news').appendChild(newpara);
            	newpara.appendChild(newtext);
            	newpara.className="title";

            	var newtext2=document.createTextNode(descriptionNodes[i].childNodes[0].nodeValue);
            	var newpara2=document.createElement('p');
            	var para2=document.getElementById('news').appendChild(newpara2);
            	newpara2.appendChild(newtext2);
            	newpara2.className="descrip";

            	var newtext3=document.createTextNode(linkNodes[i].childNodes[0].nodeValue);
            	var newpara3=document.createElement('p');
            	var para3=document.getElementById('news').appendChild(newpara3);
            	newpara3.appendChild(newtext3);
            	newpara3.className="link";
            }//FIN FOR
        } else {
			//[fallo - informa del error HTTP]
    	}
	}else{//si readyState ha cambiado, pero readySate<>4
			//[Hacer algo aquí para proveer feedback al usuario]
	} 
}