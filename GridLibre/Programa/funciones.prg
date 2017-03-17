*------------------------------------Funciones-----------------------
FUNCTION RECONECCION
     
	*---------------comando para mejorar la coneccion a sql ----------------------------------
		=SQLSETPROP(0,"ConnectTimeOut",5) &&Tiempo de Espera para la coneccion
		=SQLSETPROP(0,"DispLogin",3) &&no aparece la ventana de Inicio de Secion de SQLServer	
		=SQLSETPROP(0,"PacketSize",1000) &&	Tamaño de paquete utilizado en la red
	*-----------------Conexion SQL Server 2005
		*CN=SQLSTRINGCONNECT("DRIVER=SQL Server;SERVER="+ISERVER+";Network Library=DBMSSOCN;UID="+IUSER+";PWD="+IPASS+";WSID="+ISERVER+";DATABASE=MalkasoftADPI;MultipleActiveResultSets=true;")
		*--------Conexion a MySQL
		CN=SQLSTRINGCONNECT("DRIVER={MySQL ODBC 3.51 Driver};OPTION=0;SERVER=localhost;UID=root;PWD=123456;DATABASE=MalkasoftADPI;PORT=3306;")
	RETURN CN
ENDFUNC 

*---------------------Funcion Encriptar--------------
PROCEDURE ENCRIPTAR
	PARAMETER CCADENA, CSEMILLA
	LOCAL X, L, CCHAR, E_XOR, XY, CASCII
	L = LEN(CSEMILLA)
	nLenC = LEN(CCADENA)
	IF L>0
		IF nLenC>0
			FOR X = 1 TO nLenC
				XY = MOD(X,L)
				Z = (XY) - L * ( IIF((XY) = 0 ,1 , 0 ) )
				CChar  = ASC( SUBS(CSEMILLA, Z, 1) )
				CASCII = ASC( SUBS(CCADENA, X, 1))
				E_XOR = BITXOR(CASCII, CCHAR)
				CCADENA = STUFF( CCADENA , X , 1 , CHR(E_XOR) )
			NEXT
		ENDIF 
	ENDIF 
RETURN CCADENA

*-------------Funcion que Permite ver si el menu se muestra en sistema principal
FUNCTION  ValidaMenu(tcLevelName, tcItemNum)
LOCAL llRet
	tcLevelName = UPPER(ALLTRIM(tcLevelName))
	tnItemNum	= VAL(tcItemNum)
	llRet		= .F.
	RETURN !llRet
ENDFUNC 



*--------------------Verificar si el EXE de nuestro sistema esta ejecutandoce en el -----------------------------------
Procedure GetProcessesActive(cNombreExe)
  #Define TH32CS_SNAPPROCESS  2
  #Define TH32CS_SNAPTHREAD   4
  #Define TH32CS_SNAPMODULE   8
  #Define MAX_PATH          260
  #Define PE32_SIZE  296

  Declare Integer CloseHandle In kernel32 Integer hObject
  Declare Integer CreateToolhelp32Snapshot In kernel32;
    INTEGER dwFlags, Integer th32ProcessID
  Declare Integer Process32First In kernel32;
    INTEGER hSnapshot, String @ lppe
  Declare Integer Process32Next In kernel32;
    INTEGER hSnapshot, String @ lppe
  Declare RtlMoveMemory In WIN32API ;
    INTEGER @DestNumeric, ;
    STRING @pVoidSource, ;
    INTEGER nLength

*!*	  Create Cursor ProcList ;
*!*	    (ProcessID i,;
*!*	    cntThreads i,;
*!*	    ParentPID i,;
*!*	    szexefile c(60))

  Local hSnapshot, lcBuffer, lSuccess

  hSnapshot = CreateToolhelp32Snapshot (TH32CS_SNAPPROCESS, 0)
  lcBuffer = Int2Str(PE32_SIZE) + Replicate(Chr(0), PE32_SIZE-4)

  lSuccess = ( Process32First(hSnapshot, @lcBuffer) # 0 )
  nExeCant = 0
  Do While m.lSuccess
    lName = PROCESSENTRY32_ToCursor(m.lcBuffer)
    lSuccess = ( Process32Next(hSnapshot, @lcBuffer) # 0 )
    IF UPPER(lName) = UPPER(cNombreExe)
    	nExeCant = nExeCant + 1
    	IF nExeCant = 2 
    		CloseHandle(hSnapshot)
    		RETURN LEN(lName)
    	ENDIF 
    ENDIF 
  Enddo
  CloseHandle(hSnapshot)
RETURN 0

FUNCTION PROCESSENTRY32_ToCursor
  Lparameters tcBuffer
  Local szexefile
  m.szexefile = Substr(m.tcBuffer,37)
  m.szexefile = Substr(m.szexefile, 1, AT(Chr(0),m.szexefile)-1)
   
	RETURN ALLTRIM(m.szexefile)
ENDFUNC 

FUNCTION Substr2Num
  Lparameters tcStr, tnStart, tnSize
  Return Str2Num(Substr(m.tcStr, m.tnStart, m.tnSize), m.tnSize)
ENDFUNC 

FUNCTION Str2Num
  Lparameters tcStr,tnSize
  Local m.lnValue
  m.lnValue=0
  RtlMoveMemory(@lnValue, m.tcStr, m.tnSize)
  RETURN m.lnValue
ENDFUNC 

FUNCTION Int2Str
  Lparameters tnValue, tnSize
  Local ix, lcReturn
  m.tnSize = Iif(Empty(m.tnSize),4,m.tnSize)
  lcReturn = ''
  For ix=1 To m.tnSize
    m.lcReturn = m.lcReturn + ;
      Chr(Bitand(Bitrshift(m.tnValue, (m.ix-1)*8),0xFF))
  ENDFOR 
  RETURN m.lcReturn
ENDFUNC 
*-----------------------------------------------------Fin--------------------------------------------------------------

