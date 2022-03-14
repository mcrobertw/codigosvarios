/*Después de etiqueta title*/
<script language="JavaScript" type="text/javascript">
	function utilizarFuncionGlobal_Form(){
		campos=Form.getElements("miform");
		for(i=0;i<campos.length;i++)
		{
			alert($F(campos[i]));
		}
	}
</script>

/*Después de etiqueta BODY*/
<form id="miform">
	<input type="text" id="textfield" name="textfield" value="me">
	<br>
	
	<textarea name="areafield" id="areafield" cols="5" rows="5">gusta</textarea>
	<br>
	
	<select name="selectfield" id="selectfield">
		<option value="1" selected>Programar</option>
		<option value="2">Cantar</option>
	</select>
	<br>
	
	<input type="checkbox" id="checkfield" name="checkfield" value="1" checked/>
</form>
		
<input type="button" onclick="utilizarFuncionGlobal_Form()" value="Usando Prototype.js">