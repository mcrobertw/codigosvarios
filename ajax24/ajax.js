Event.observe(window,'load',init,false);
function init(){
	$('saludo-enviar').style.display = 'none';
	Event.observe('saludo-nombre','keyup',saludo,false);
}

function saludo(){
	var url='saludo.php';
	var pars='saludo-nombre='+escape($F('saludo-nombre'));
	var target='muestraSaludo';
	var miAjax=new Ajax.Updater(target,url,{method:'get',parameters: pars});
}