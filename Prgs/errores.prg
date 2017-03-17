ON ERROR DO errhand WITH ERROR( )
OPEN DATABASE DATOS\Datos1 NOUPDATE VALIDATE
ON ERROR
RETURN

*** Controlador de errores ***
PROCEDURE errhand
PARAMETER errnum,message
_Screen. BackColor = RGB(0,0,0)
	=messagebox("Ocurrió un error " + "en la línea Nº " + alltrim(str(errnum)) + " y podría tener problemas más adelante" + chr(13)+;
	chr(13) +	" Por favor, consulte a su programador",0+64,"¡ATENCIÓN!") 
			close database
			quit
***Si no hay error pasará la función a este método, indicando que todo está en orden***
