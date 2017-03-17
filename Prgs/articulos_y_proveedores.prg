iF not USED('articulos')
	USE Datos\articulos
ENDIF 

iF not USED('depto')
	USE Datos\depto
ENDIF 

iF not USED('proveedor')
	USE Datos\proveedor
ENDIF 

SELECT A.numprov, A.desprov, A.numdpto,A.desdpto, A.codart,;
  A.desartic, A.unimedid, A.p_lista,;
  A.exisal;	
 FROM  articulos A; 
 INTO TABLE Articulos_y_Proveedore