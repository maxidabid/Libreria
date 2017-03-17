SELECT Depto.desdpto, Articulos.desartic, Articulos.unimedid,;
  Articulos.p_lista, Articulos.preciomay, Articulos.exisal;
 FROM  datos1!depto INNER JOIN datos1!articulos ;
   ON  Depto.numdpto = Articulos.numdpto;
 ORDER BY Depto.desdpto, Articulos.desartic;
 INTO TABLE Depto_y_Articulos
