
/*Después de etiqueta "title" de html*/
<script language="JavaScript" type="text/javascript">
	function utilizarFuncionGlobal(){
		var nuevosdatos = $('caja1','caja2','caja3');
		$(nuevosdatos[0]).innerHTML="Estoy";
		$(nuevosdatos[1]).innerHTML="utilizando";
		$(nuevosdatos[2]).innerHTML="prototype.js";
	}
</script>

/* En etiqueta body */

<form>
	<input type="button" onclick="utilizarFuncionGlobal()" value="Usando Prototype.js">
</form>
<div id="caja1" class="displaybox">a</div>
<div id="caja2" class="displaybox">b</div>
<div id="caja3" class="displaybox">c</div>