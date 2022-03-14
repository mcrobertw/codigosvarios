/*Después de etiqueta "title" de html*/
<script language="JavaScript" type="text/javascript">
	function utilizarFuncionGlobal_F(){
	alert($F('checkfield'));
}
</script>

/*Etiquetas html de las cuales se extrae valor*/
<input type="checkbox" id="checkfield" name="checkfield" value="1" checked/>

<form>
	<input type="button" onclick="utilizarFuncionGlobal_F()" value="Usando Prototype.js">
</form>