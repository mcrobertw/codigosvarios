<?php
	<script language="JavaScript" type="text/javascript">
			
			function respuestaAjax(){//respuestaAjax
				if(miPeticion.readyState == 4)
				{
					if(miPeticion.status == 200)
					{
						alert("El server dijo: "+ miPeticion.responseText);
					}
					else
					{
						alert("Ha ocurrido un error: " + miPeticion.statusText);
					}
				}
			}


	</script>

	echo "Pedido Ajax recibido y procesado correctamente";
?>
