SET EXCLUSIVE ON
WAIT "Sumando totales..." WINDOW NOWAIT
USE DATOS\Articulos
	Monto1=P_costo*(Flete/100)
	Monto2=P_Costo*(iva/100)
	Total1=P_Costo+Monto1+Monto2
	***************************
	Monto3=Total1*(Ganancia/100)
	**************************
	vImporte=Total1+Monto3
	***************************
	vP_Lista=vImporte
	****************************
	****************************
	Monto4=P_costo*(Flete/100)
	Monto5=P_Costo*(iva/100)
	Total2=P_Costo+Monto1+Monto2
	*****************************
	Monto6=Total2*(Ganancia2/100)
	****************************
	vImporte2=Total2+Monto6
	*****************************		
	vP_Mayorista=vImporte2
	*****************************
DO WHILE !EOF()
SCAN
		USE DATOS\Articulos
		Repla P_Neto 		With Total1
		Repla	P_Lista		With	vP_Lista
		Repla	Preciomay		With	vP_Mayorista
ENDSCAN
ENDDO