=ESPACIOS(EXTRAE(A1;ENCONTRAR(":";A1)+1;LARGO(A1)))

'Ejemplo: 	'Si en la celda A1, se encuentra la cadena "1. Aboard: A bordo de."
			'La función recorta los caracteres a la derecha después de la posición +1 del primer dos puntos":" que se encuentre.
			
=EXTRAE(A1;ENCONTRAR(".";A1)+2;ENCONTRAR(":";A1)-4)
'Ejemplo: 	'Si en la celda A1, se encuentra la cadena "1. Aboard: A bordo de."
			'La función devuelve "Aboard"