/*
	* Un control de caja de texto Autosugerencias.
	* @clase
	* @alcance público
*/

function AutoSuggestControl(oTextbox /*:ElmentoInputHTML*/,
							oProvider /*:ProveedorSugerencias*/
							){
	/**
	 * Las sugerencias actualmente seleccionadas
	 * @alcance privado
	*/
	this.cur /*:int*/=-1;

	/**
	 	* La capa de la lista desplegabble
	 	* @alcance privado
	*/
	this.layer=null;

	/**
	 	* El proveedor de sugerencias para la característica "autosuggest"
	 	* @scope private
	*/
	this.provider /*:Proveedor de Sugerencias*/=oProvider;

	/**
	 	* La capa de texto a capturar
	 	* @alcance privado
	*/
	this.textbox /*:ElementoInputHTML*/=oTextbox;

	/**
	 	* Timeout ID para escritura rápida
	 	* @alcance privado
	*/
	this.timeoutId /*:int*/=null;

	/**
	 	* El texto que el usuario ha escrito
	 	* @alcance privado
	*/
	this.userText /*:String*/=oTextbox.value;

	//inicializa el control
	this.init();
}

/**
	* Autosugiere una o más sugerencias para lo que el usuario ha escrito.
	* Si no son pasadas sugerencias, entonces la autosugerencia no tiene lugar.
	* @alcance privado
	* @param aSuggestions un array de strings de sugerencias
	* @param bTypeAhead Si el control debe proveer una sugerencia "type ahead".
*/

AutoSuggestControl.prototype.autosuggest=function(aSuggestions /*:Array*/,
													bTypeAhead /*:boolean*/){
	//re-inicializa el indicador a la sugerencia actual
	this.cur=-1;

	//Se asegura que haya almenos una sugerencia
	if(aSuggestions.length>0){
		if (bTypeAhead){
			this.typeAhead(aSuggestions[0]);
		}
		this.showSuggestions(aSuggestions);
	}else{
		this.hideSuggestions();
	}
};


/**
	* Construye el contenido de la capa de sugerencias, lo coloca correctamente,
	* y muestra la capa.
	* @alcance privado
	* @param aSuggestions un array de sugerencias para el control.
*/

AutoSuggestControl.prototype.showSuggestions=function(aSuggestions /*:Array*/){
	var oDiv=null;
	this.layer.innerHTML=""; //limpiar contenidos de la capa

	for(var i=0;i<aSuggestions.length;i++){
		oDiv=document.createElement("div");
		oDiv.appendChild(document.createTextNode(aSuggestions[i]));
		this.layer.appendChild(oDiv);
	}

	this.layer.style.left=this.getLeft()+"px";
	this.layer.style.top=(this.getTop()+this.textbox.offsetHeight)+"px";
	this.layer.style.visibility = "visible";
};



/**
	* Crea la capa desplegable para mostrar múltiples sugerencias
	* @alcance privado
*/

AutoSuggestControl.prototype.createDropDown=function(){

	//Crea la capa y le asigna estilos
	this.layer=document.createElement("div");
	this.layer.className="suggestions";
	this.layer.style.visibility = "hidden";
	this.layer.style.width=this.textbox.offsetWidth;
	document.body.appendChild(this.layer);

	//Cuando el usuario pulsa en una sugerencia, obtiene el texto (innerHTML)
	//y lo coloca en la caja de texto
	var oThis=this;
	this.layer.onmousedown=
	this.layer.onmouseup=
	this.layer.onmouseover=function (oEvent){
		oEvent=oEvent || window.event;
		oTarget=oEvent.target||oEvent.srcElement;

		if (oEvent.type=="mousedown"){
			oThis.textbox.value=oTarget.firstChild.nodeValue;
			oThis.hideSuggestions();
		}else if(oEvent type=="mouseover"){
			oThis.highlightSuggestion(oTarget);
		}else{
			oThis.textbox.focus();
		}
	};

};


/**
	* Obtiene la coordenada izquierda de la caja de texto.
	* @alcanceprivado
	* @devuelve la coordenada izquierda de la caja de texto en píxeles.
*/
AutoSuggestControl.prototype.getLeft=function()/*:int*/{
	var oNode = this.textbox;
	var iLeft=0;
	
	while(oNode.tagName != "BODY"){
		iLeft+=oNode.offsetLeft;
		oNode=oNode.offsetParent;
	}
	return iLeft;
};

/**
	* Obtiene la coordenada top de la caja de texto.
	* @alcance privado
	* @devuelve la coordenada top de la caja de texto en píxeles.
*/
AutoSuggestControl.prototype.getTop=function()/*:int*/{
	var oNode = this.textbox;
	var iTop=0;
	
	while(oNode.tagName != "BODY"){
		iTop+=oNode.offsetTop;
		oNode=oNode.offsetParent;
	}
	return iTop;
};


/**
	* Oculta la lista desplegable de sugerencias
	* @alcance privado
*/

AutoSuggestControl.prototype.hideSuggestions=function(){
	this.layer.style.visibility = "hidden";
};

/**
	* Remarca el nodo dado en la lista desplegable de sugerencias
	* @scope private
	* @param  oSuggestionNode El nodo representando una sugerencia en la lista desplegable
*/
AutoSuggestControl.prototype.highlightSuggestion=function(oSuggestionNode){
	for(var i=0;i<this.layer.childNodes.length;i++){
		var oNode=this.layer.childNodes[i];
		if(oNode==oSuggestionNode){
			oNode.className="current" // Me parece que falta un ";"
		}else if(oNode.className=="current"){
			oNode.className="";
		}
	}
};

AutoSuggestControl.prototype.selectRange=function(iStart /*:int*/,iEnd /*:int*/){
	//Usar rangos de texto para Internet Explorer
	if(this.textbox.createTextRange)
	{	var oRange=textbox.createTextRange();
		oRange.moveStart("character",iStart);
		oRange.moveEnd("character",iEnd-textbox.value.length);
		oRange.select();		
	}
	
	//Usar setSelectionRange() por Firefox
	else if(this.textbox.setSelectionRange)
	{	
		this.textbox.setSelectionRange(0,3);
	}

	//Configurar focus de vuelta a la caja de texto
	this.textbox.focus();
}

AutoSuggestControl.prototype.typeAhead=function(sSuggestion /*:String*/){
	//Comprueba soporte para la funcionalidad typeahead
	if(this.textbox.createTextRange || this.textbox.setSelectionRange)
	{	var iLen=this.textbox.value.length;
		this.textbox.value=sSuggestion;
		this.selectRange(iLen,sSuggestion.length);
	}
}

/**
	*Maneja eventos soltar tecla
	* @alcanceprivado
	* @param oEvent el objeto evento para el evento keyup
 */
AutoSuggestControl.prototype.handleKeyUp = function(oEvent /*:Event*/){
	var iKeyCode = oEvent.keyCode;
	var oThis = this;

	//Obtiene el texto actualmente escrito
	this.userText = this.textbox.value;

	clearTimeout(this.timeoutId);

	//Para  retroceso (8) y borrar (46), muestra sugerencias sin typeahead
	if(iKeyCode == 8 || iKeyCode == 46){

		this.timeoutId=setTimeout(function(){
			oThis.provider.requestSuggestions(oThis,false);
		},250);

	//Se asegura que no interfiere con teclas no-carácter
	} else if(iKeyCode<32 || (iKeyCode>=33 && iKeyCode <46) || (iKeyCode>=112 && iKeyCode <=123)){
		//ignora
	} else{
		//pide sugerencias al proveedor de sugerencias con typeahead
		this.timeoutId=setTimeout(function(){
			oThis.provider.requestSuggestions(oThis,true);
		},250);
		
	}
};

/**
	*Maneja 3 eventos de pulsación de teclado.
	* @alcance privado
	* @param oEvent el objeto evento para el evento pulsar tecla teclado
 */
AutoSuggestControl.prototype.handleKeyDown = function(oEvent /*:Event*/){
	switch (oEvent.keyCode) {
		case 38://flecha arriba
			this.goToSuggestion(-1);
			break;
		case 40://flecha abajo
			this.goToSuggestion(1);
			break;
		case 27://escape
			this.textbox.value=this.userText;
			this.selectRange(this.userText.length,0);
			/* a través de */
		case 13://enter
			this.hideSuggestions;
			oEvent.returnValue=false;
			if(oEvent.preventDefault){
				oEvent.preventDefault();
			}
			break;
	}
};

/**
	* Remarca la sugerencia siguiente o previa en la lista desplegable y
	* coloca la sugerencia en la caja de texto
	* @param iDiff bien un número positivo o negativo indicando si
	* selecciona la sugerencia siguiente o previa, respectivamente
 */

 AutoSuggestControl.prototype.goToSuggestion = function(iDiff /*:int*/){
 	var cSuggestionNodes=this.layer.childNodes;

 	if (cSuggestionNodes.length>0){
 		var oNode=null;

 		if(iDiff>0){
 			if(this.cur<cSuggestionNodes.length-1){
 				oNode=cSuggestionNodes[++this.cur];
 			}
 		}else{
 			if(this.cur>0){
 				oNode=cSuggestionNodes[--this.cur];
 			}
 		}

 		if (oNode){
 			this.highlightSuggestion(oNode);
 			this.textbox.value=oNode.firstChild.nodeValue;
 		}
 	}
 };



/**
	* Inicializa la caja de texto con gestores de evento para
	* la funcionalidad auto sugerencia
	* @alcanceprivado
 */

 AutoSuggestControl.prototype.init = function(){
 	//salva una referencia a este objeto
 	var oThis=this;

 	//asigna el gestor de evento onkeyup
 	this.textbox.onkeyup=function (oEvent){
 		//comprueba la localización apropiada del objeto evento
 		if(!oEvent){
 			oEvent=window.event;
 		}

 		//Llama al método handleKeyUp() con el objeto evento
 		oThis.handleKeyUp(oEvent);
 	};

 	//asigna gestor de evento onkeydown
 	this.textbox.onkeydown = function(oEvent){
 		//comprueba la localización apropiada del objeto evento
 		if(!oEvent){
 			oEvent=window.event;
 		}

 		//Llama al método handKeyDown() con el objeto evento
 		oThis.handleKeyDown(oEvent);
 	};

 	//asigna el gestor de evento onblur (oculta sugerencias)
 	this.textbox.onblur=function(){
 		oThis.hideSuggestions();
 	};

 	//crea la lista desplegable de sugerencias
 	this.createDropDown();
 };

 /**
	* Provee sugerencias para nombres de Provincias.
	* @clase
	* @alcance público
 */

function SuggestionProvider(){
	this.http=zXmlHttp.createRequest();
};
 	
SuggestionProvider.prototype.requestSuggestions = function(oAutoSuggestControl /*:AutoSuggestControl*/,
															byTypeAhead /*:boolean*/){
	var oHttp=this.http;

	//cancela cualquier petición activa
	if(oHttp.readyState != 0){
		oHttp.abort();
	}

	//define los datos
	var oData={
		requesting: "Provincias",
		text: oAutoSuggestControl.userText,
		limit: 5
	};

	//abre la conexión al servidor
	oHttp.open("post","suggestions.php",true);
	oHttp.onreadystatechange = function(){
		if (oHttp.readyState==4){
			//evalúa el texto JavaScript devuelto (un array)
			var aSuggestions=JSON.parse(oHttp.responseText);

			//provee sugerencias al control
			oAutoSuggestControl.autosuggest(aSuggestions, bTypeAhead);
		}
	};

	//envía la petición
	oHttp.send(JSON.stringify(oData));
	
};