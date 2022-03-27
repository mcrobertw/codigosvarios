<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Creación de aplicación basada en rico</title>
	<script language="JavaScript" type="text/javascript" src="prototype.js "></script>
	<script language="JavaScript" type="text/javascript" src="rico.js "></script>
	<script type="text/javascript">
		Rico.loadModule('Accordion');

		Rico.onLoad( function() {
		  new Rico.Accordion( $$('div.panelheader'), $$('div.panelContent'),
		                      {panelHeight:200, hoverClass: 'mdHover', selectedClass: 'mdSelected'});
		});
	</script>
</head>
<body>
	 
		<div class="panelheader">¿Quién es Homero?</div>
			<div class="panelContent">
				<ul>
					<li>
						<div align="left"><b>Ocupaci&oacute;n </b>Protagonista de un programa de televisi&oacute;n y jefe de hogar de una familia que se mantiene unida.</div>
					</li>
					<li>
						<div align="left"><b>Virtudes: </b>*Tiene una buena mujer *Tiene buenos amigos *Trabaja sin horario </div>
					</li>
				</ul>
			</div>
		<div class="panelheader">¿La Evolución Humana?</div>
			<div class="panelContent">
				<img src="homer.png" width="200" height="200"/>
			</div>
</body>
</html>