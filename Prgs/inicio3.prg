*:******************************************************************************
*: Documented using Visual FoxPro Formatting wizard version  .06
*:******************************************************************************
SET DATE TO FRENCH
SET SYSMENU OFF
SET SYSMENU TO
SET BELL OFF
SET CONFIRM OFF
SET DECIMALS TO
SET DELETED ON
SET EXCLUSIVE OFF
SET MULTILOCKS ON
SET NOTIFY OFF
SET REPROCESS TO AUTOMATIC
SET SAFETY OFF
SET TALK OFF
SET STATUS OFF
SET OPTIMIZE ON
SET CLOCK ON
SET STATUS BAR ON
SET HOURS TO 24
SET CENTURY ON
*Do Form Presentacion
_SCREEN.VISIBLE = .F.
INKEY(5)
_SCREEN.VISIBLE = .T.
SET HELP TO HELP\CONTROLDESTOCK.HLP
#INCLUDE comun.h
********************************************** **********************************************************
*  FIJATE QUE EL FICHERO DE CONSTANTES comun.h ESTÁ INCLUIDO TAMBIEN EL LOS FORMULARIOS  Y EN LOS MENUS *
*********************************************************************************************************
*MODIFY WINDOWS SCREEN TITLE "Control de Stock de Medicamentos"  NOCLOSE NOFLOAT  NOZOOM fill file "toolbar.bmp"
LOCAL lnCnt, lnHwnd, lcNewDir, lwStartUp
LOCAL ARRAY laVFPBars(13)

SET TALK OFF

SET DEBUG OFF
SET ESCAPE OFF
_Screen. BackColor = RGB (128,0,128)
_Screen. Autocenter=.T.
_Screen. Closable = .F.
_Screen. MaxButton=.F.
_Screen. Movable=.F.
_SCREEN.WindowState = WINDOWSTATE_MAXIMIZED
_SCREEN.Visible     = .T.
********************************************** ***************************************
*  A PARTIR DE AQUI EMPEZAMOS A CONFIGURAR EL ENTORNO, ABRIR LO QUE NECESITAMOS, ETC *
*  MIENTRAS EL FORMULARIO DE ARRANNQUE ESTA VISIBLE                                  *
************************************************ *************************************

laVFPBars( 1) = TB_FORMDESIGNER_LOC
laVFPBars( 2) = TB_STANDARD_LOC
laVFPBars( 3) = TB_LAYOUT_LOC
laVFPBars( 4) = TB_QUERY_LOC
laVFPBars( 5) = TB_VIEWDESIGNER_LOC
laVFPBars( 6) = TB_COLORPALETTE_LOC
laVFPBars( 7) = TB_FORMCONTROLS_LOC
laVFPBars( 8) = TB_DATADESIGNER_LOC
laVFPBars( 9) = TB_REPODESIGNER_LOC
laVFPBars(10) = TB_REPOCONTROLS_LOC
laVFPBars(11) = TB_PRINTPREVIEW_LOC
laVFPBars(12) = WIN_COMMAND_LOC
laVFPBars(13) = WIN_PROYECT_LOC

FOR lnCnt = 1 TO 13
	IF WVISIBLE(laVFPBars(lnCnt))
		HIDE WINDOW (laVFPBars(lnCnt))
	ENDIF
ENDFOR
*SET PATH TO HOME()+"DATOS",HOME()+"\CLASES",;
*HOME()+"\FORMS",HOME()+"\INFORMES", HOME()+"HELP"

*!*	lcNewDir = JUSTPATH(SYS(16, 0))
*!*	CD (lcNewDir)
*!*	SET DEFAULT TO (lcNewDir)
CLOSE TABLES   ALL
CLOSE DATABASES ALL
SET FUNCTION  1 TO && F1 ayuda
SET STATUS BAR ON
SET SYSMENU AUTOMATIC
SET SYSMENU TO
ON SHUTDOWN  CLEAR EVENTS && TIENES QUE HACER TU ESTE TRABAJO .................

DECLARE INTEGER FindWindow IN Win32API STRING lpClassName, STRING lpWindowName
DECLARE INTEGER BringWindowToTop IN Win32API INTEGER hwnd
DECLARE INTEGER SendMessage IN Win32API INTEGER hwnd, INTEGER Msg, INTEGER WParam, INTEGER LParam

********************************************** ******************************************

lnHwnd = FindWindow(0, TITULOAPP_LOC)

IF  lnHwnd > 0

	*!* Si ya se habia arrancado antes la aplicación
	BringWindowToTop(lnHwnd)                           && Mandar la ventana de la aplicación al frente
	SendMessage(lnHwnd, WM_SYSCOMMAND, SC_MAXIMIZE ,0) && Maximizar la ventana de la aplicación
ELSE
	*!* Si no se habia arrancado antes la aplicacion,
	_SCREEN.Caption   = TITULOAPP_LOC && Establecer título de la aplicacion
	*!* Liberar variables locales
	RELEASE lnCnt, lnHwnd, lcNewDir, laVFPBars
	**************************************************************************
	*  A PARTIR DE AQUI TU APLICACIÓN CONTINUA, CARGAS EL OBJETO APLICACION, *                            *
	*  INICIAS EL BUCLE READ EVENTS, TU MENU, EL FORMULARIO DE LOGIN, ETC    *
	**************************************************************************
	Wait Windows "Cargando Menu Principal..." NoWait
	Do Form Fondo
	Do Acceso.mpr
	=Errores()
	SET CLASSLIB TO ControlStock
	oApp=CREATEOBJECT("Inicio")
	oApp.Inicio
	READ EVENTS
	Clear Windows
ENDIF



***********************************************
*  A PARTIR DE AQUI FINALIZAMOS LA APLICACION *
***********************************************

ON ERROR
ON ESCAPE
ON PAGE
ON SHUTDOWN

ON KEY LABEL CTRL+INS
ON KEY LABEL CTRL+DEL
ON KEY LABEL F12

CLOSE TABLES   ALL
CLOSE DATABASES ALL

CLEAR DLLS
CLEAR ALL
CLOSE ALL
RELEASE ALL EXTENDED
RETURN
