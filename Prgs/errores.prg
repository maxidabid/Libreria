ON ERROR DO errhand WITH ERROR( )
OPEN DATABASE DATOS\Datos1 NOUPDATE VALIDATE
ON ERROR
RETURN

*** Controlador de errores ***
PROCEDURE errhand
PARAMETER errnum,message
_Screen. BackColor = RGB(0,0,0)
	=messagebox("Ocurri� un error " + "en la l�nea N� " + alltrim(str(errnum)) + " y podr�a tener problemas m�s adelante" + chr(13)+;
	chr(13) +	" Por favor, consulte a su programador",0+64,"�ATENCI�N!") 
			close database
			quit
***Si no hay error pasar� la funci�n a este m�todo, indicando que todo est� en orden***
