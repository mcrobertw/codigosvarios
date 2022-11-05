<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Creación de sistema de autosugerencias</title>
	
	<script type="text/javascript" src="json.js"></script>
	<script type="text/javascript" src="zxml.js"></script>
	<script type="text/javascript" src="autosuggest.js"></script>
	<link rel="stylesheet" type="text/css" href="autosuggest.css">
	<script type="text/javascript">
		window.onload=function(){
			var oTextbo=new AutoSuggestControl(document.getElementById("txtState"),new SuggestionProvider());
		}
	</script>
</head>
<body>

	<form method="post" onSubmit="alert('Submitted!')">
		<table border="0">
			<tr>
				<td>Nombre:</td>
				<td><input type="text" name="txtName" id="txtName" /></td>
			</tr>
			<tr>
				<td>Direcci&oacute;n 1:</td>
				<td><input type="text" name="txtAddress1" id="txtAddress1"/></td>
			</tr>
			<tr>
				<td>Direcci&oacute;n 2:</td>
				<td><input type="text" name="txtAddress2" id="txtAddress2"/></td>
			</tr>
			<tr>
				<td>Ciudad:</td>
				<td><input type="text" name="txtCity" id="txtCity"/></td>
			</tr>
			<tr>
				<td>Provincia:</td>
				<td><input type="text" name="txtState" id="txtState" autocomplete="off" /></td>
			</tr>
			<tr>
				<td>C.P.:</td>
				<td><input type="text" name="txtZip" id="txtZip"/></td>
			</tr>
			<tr>
				<td>Pa&iacute;s:</td>
				<td><input type="text" name="txtCountry" id="txtCountry"/></td>
			</tr>
		</table>
		<input type="submit" value="Salvar informaci&oacute;n">
	</form>
</body>
</html>

