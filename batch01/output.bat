@ECHO OFF
REM esto es un comentario
REM Este programa recibe dos parámetros, un comando y un nombre de archivo 
if EXIST %2 goto EXISTE
REM Si existe el nombre del archivo, entonces manda un mensaje de salida del programa
REM al archivo indicado en el segundo parámetro

%1 > %2
goto SALIDA

:EXISTE
ECHO El archivo %2 ya existe, fin del programa.

:SALIDA
