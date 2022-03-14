/*Después de etiqueta title*/
<script language="JavaScript" type="text/javascript">
	function habilitarForm()
	{
		Form.enable("miform");
	}
	function deshabilitarForm()
	{
		Form.disable("miform");
	}
</script>

/*En etiqueta BODY, los botones de habilitar y deshabilitar deben estar fuera, caso contrario no se los podría usar*/
		
<form id="miform" method="post">
	<input type="text" id="textfieldnombres" name="textfield" value="me">
	<br>
</form>
		
<input type="button" onclick="habilitarForm()" value="Habilitar Form">
<input type="button" onclick="deshabilitarForm()" value="Deshabilitar Form">