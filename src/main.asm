#include "p16f1787.inc"
#include "mimacro.INC"
; CONFIG1
; __config 0xFFE4
	__CONFIG _CONFIG1, _FOSC_INTOSC & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_ON & _CLKOUTEN_OFF & _IESO_ON & _FCMEN_ON
; CONFIG2
; __config 0xFFFF
	__CONFIG _CONFIG2, _WRT_OFF & _VCAPEN_OFF & _PLLEN_ON & _STVREN_ON & _BORV_LO & _LPBOR_OFF & _LVP_ON

CBLOCK 0x70 ;Ran comun
	tecla_presionada
	tekl4pul5        ;Registro donde se almacenar� el valor de la tecla pulsada
	c0mpparadD0r ;Registro que ser� el comparador para el escaner de teclado
	Sit3cl4pus     ;Registro de bucle para pausar o leer de corrido
	Hhayrt3cla     ;Registro que permite saber si hay una tecla pulsada
ENDC	


	org 0x0
		goto Principal
	org 04
		goto Interrupcion

Mostrar7Segmentos
	banksel PORTD
	movwf PORTD
	movlw 0xF0
	movwf PORTC
	return

Control7Segmentos
	return
		
ConfigurarPuertos
	; Puertos como E/S digital
	banksel ANSELA	
	clrf 	ANSELA
	clrf 	ANSELB
	clrf 	ANSELD
	; Configurar purtos 
	banksel TRISD
	CLRF 	TRISD	; Salida
	CLRF	TRISC	; Salida
	banksel TRISB
	movlw	0xF0	;
	movwf	TRISB	; 0-3 Salida 4-7 Entrada
	
	;banksel WPUB	; Weak pull-up - evitar resistencias
;	movwf 	WPUB

	banksel	PORTD
	CLRF 	PORTD
	clrf	PORTC

	return

Convertir7Segmentos; Tabla 7 segmentos catodo comun
	brw;			xgfe dcba
	retlw 	0x40; 0-> 0100 0000
	retlw 	0x79; 1-> 0111 1001
	retlw 	0x24; 2-> 0010 0100
	retlw 	0x30; 3-> 0011 0000
	retlw 	0x19; 4-> 0001 1001
	retlw 	0x12; 5-> 0001 0010
	retlw 	0x03; 6-> 0000 0011
	retlw 	0x78; 7-> 0111 1000
	retlw 	0x00; 8-> 0000 0000
	retlw 	0x18; 9-> 0001 1000
	retlw   0x02; 
	retlw   0x03; 
	retlw   0x04; 
	retlw   0x05; 
	retlw   0x06; 14 // Asterisco
	retlw   0x07; 15 // Numeral
	retlw   0x08; 16 //
	retlw 	0x7F; apagar todos los displays
	

; ....................www.rodrigocarita.com................................
; Librer�a para teclado matricial 4x4
;Versi�n : 1.0
;..:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;Atencion: Esta librer�a funciona con la macro en Versi�n 1.2 y superiores.
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;   | 1 | 2 | 3 | A |   --->PORTB,0
;   | 4 | 5 | 6 | B |   ---> PORTB,1
;   | 7 | 8 | 9 | C |    --->PORTB,2
;   | * | 0 | # | D |   ---> PORTB,3
;      |    |    |    |
;    RB4 RB5 RB6 RB7
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;Modo de conexi�n es sencilla, con el teclado mir�ndonos, los pines se conectan de modo
;                                    RB0,RB1,RB2,RB3,...,RB7,
;-----------------------------------------------------------------------------------------------------------------------------	

IN1ci0t3cla4do  		; Subrutina de configuraci�n de Teclado. Activa las resistencias PULL-UP
	banksel TRISB           			;Vamos al banco 1
	MOVLW b'11110000' 	; Configuramos las columnas como salida y las filas como entrada
	MOVWF TRISB
	banksel OPTION_REG			;del puerto B.
	BCF OPTION_REG,7		;Activa las resistencias tipo PULL-UP del pic
	BANKSEL PORTB           			;Regresamos al Banco 0
	CLRF tekl4pul5		;Limpiamos memorias de teclapulsada
	CLRF Sit3cl4pus		;Limpiamos permisos para bucles
	RETURN				;Salimos de la subrutina de configuraci�n

Tttest3aTecld0o							;t�tulo de subrutina para escaner de teclado	
	cargarvalor .0,Hhayrt3cla				;Limpiamos el valor de comprobaci�n si hubo una tecla pulsada
	cargarvalor b'11111110',PORTB			;Cargamos el primer valor para escanear la primera fila
	nop										;Tiempo paran�ico
	copiarregistro PORTB,c0mpparadD0r		;Leemos el puerto B para ver si hay un bot�n pulsado
	csi c0mpparadD0r,b'11101110',BoTt0Nn1	;Iniciamos el Escaneo, Se puls� la primera column�?	
	csi c0mpparadD0r,b'11011110',BoTt0Nn2	;Se puls� la segunda columna?	
	csi c0mpparadD0r,b'10111110',BoTt0Nn3	;Se puls� la tercera columna?
	csi c0mpparadD0r,b'01111110',BoTt0NnA	;Se puls� la cuarta columna?

	cargarvalor b'11111101',PORTB			;Cargamos el segundo valor para escanear la segunda fila
	nop										;Tiempo paran�ico
	copiarregistro PORTB,c0mpparadD0r		 ;Leemos el puerto B para ver si hay un bot�n pulsado
	csi c0mpparadD0r,b'11101101',BoTt0Nn4         ;Iniciamos el Escaneo, Se puls� la primera column�?	
	csi c0mpparadD0r,b'11011101',BoTt0Nn5         ;Se puls� la segunda columna?	
	csi c0mpparadD0r,b'10111101',BoTt0Nn6         ;Se puls� la tercera columna?
	csi c0mpparadD0r,b'01111101',BoTt0NnB         ;Se puls� la cuarta columna?

	cargarvalor b'11111011',PORTB			;Cargamos el tercer valor para escanear la tercera fila	
	nop                                                                                    ;Tiempo paran�ico 
	copiarregistro PORTB,c0mpparadD0r                  ;Leemos el puerto B para ver si hay un bot�n pulsado
	csi c0mpparadD0r,b'11101011',BoTt0Nn7         ;Iniciamos el Escaneo, Se puls� la primera column�?	
	csi c0mpparadD0r,b'11011011',BoTt0Nn8         ;Se puls� la segunda columna?	
	csi c0mpparadD0r,b'10111011',BoTt0Nn9         ;Se puls� la tercera columna?
	csi c0mpparadD0r,b'01111011',BoTt0NnC         ;Se puls� la cuarta columna?
	cargarvalor b'11110111',PORTB			;Cargamos el cuarto valor para escanear la cuarta fila	
	nop                                                                                    ;Tiempo paran�ico 
	copiarregistro PORTB,c0mpparadD0r                  ;Leemos el puerto B para ver si hay un bot�n 	pulsado
	csi c0mpparadD0r,b'11100111',BoTt0NnAST     ;Iniciamos el Escaneo, Se puls� la primera column�?	
	csi c0mpparadD0r,b'11010111',BoTt0Nn0         ;Se puls� la segunda columna?	
	csi c0mpparadD0r,b'10110111',BoTt0NnMICH   ;Se puls� la tercera columna? 
	csi c0mpparadD0r,b'01110111',BoTt0NnD         ;Se puls� la cuarta columna?
	csi c0mpparadD0r,b'11110111',SinTecl4	 ; NO SE PULS� NADA??	

SinTecl4					;Subrutina para cuando no haya alguna tecla pulsada.		
	cargarvalor .1,Hhayrt3cla	; Carga el valor de 1 en el registro Hhayrt3cla 
	BTFSS Sit3cl4pus,0 			;Esta en el modo de pausa?
	RETURN						;Caso falso: Sale de la subrutina continuando con el programa principal
	GOTO Tttest3aTecld0o			;Caso verdadero: Continua testeando el teclado hasta que una tecla se pulse

BoTt0Nn0					;Subrutina para cuando se presione el bot�n 0
	cargarvalor 0x0,tekl4pul5		;Carga el valor de "0" en el registro de respuesta tekl4pul5 
	RETURN						;Sale de la subrutina de teclado

BoTt0Nn1					;Subrutina para cuando se presione el bot�n 1
	cargarvalor 0x1,tekl4pul5           ;Carga el valor de "1" en el registro de respuesta tekl4pul5 
	RETURN                                                  ;Sale de la subrutina de teclado

BoTt0Nn2					;Subrutina para cuando se presione el bot�n 2
	cargarvalor 0x2,tekl4pul5           ;Carga el valor de "2" en el registro de respuesta tekl4pul5 
	RETURN                                                  ;Sale de la subrutina de teclado

BoTt0Nn3					;Subrutina para cuando se presione el bot�n 3
	cargarvalor 0x3,tekl4pul5           ;Carga el valor de "3" en el registro de respuesta tekl4pul5 
	RETURN                                                  ;Sale de la subrutina de teclado

BoTt0Nn4					;Subrutina para cuando se presione el bot�n 4
	cargarvalor 0x4,tekl4pul5           ;Carga el valor de "4" en el registro de respuesta tekl4pul5 
	RETURN                                                  ;Sale de la subrutina de teclado

BoTt0Nn5					;Subrutina para cuando se presione el bot�n 5
	cargarvalor 0x5,tekl4pul5           ;Carga el valor de "5" en el registro de respuesta tekl4pul5 
	RETURN                  	                                ;Sale de la subrutina de teclado

BoTt0Nn6					;Subrutina para cuando se presione el bot�n 6
	cargarvalor 0x6,tekl4pul5           ;Carga el valor de "6" en el registro de respuesta tekl4pul5 
	RETURN                                                  ;Sale de la subrutina de teclado

BoTt0Nn7					;Subrutina para cuando se presione el bot�n 7
	cargarvalor 0x7,tekl4pul5           ;Carga el valor de "7" en el registro de respuesta tekl4pul5 
	RETURN                                                  ;Sale de la subrutina de teclado

BoTt0Nn8					;Subrutina para cuando se presione el bot�n 8
	cargarvalor 0x8,tekl4pul5           ;Carga el valor de "8" en el registro de respuesta tekl4pul5 
	RETURN                                                  ;Sale de la subrutina de teclado

BoTt0Nn9					;Subrutina para cuando se presione el bot�n 9	
	cargarvalor 0x9,tekl4pul5           ;Carga el valor de "9" en el registro de respuesta tekl4pul5 
	RETURN                                                  ;Sale de la subrutina de teclado

BoTt0NnA					;Subrutina para cuando se presione el bot�n A
	cargarvalor 0xA,tekl4pul5        ;Carga el valor de "10" en el registro de respuesta tekl4pul5
	RETURN                                                  ;Sale de la subrutina de teclado

BoTt0NnB					;Subrutina para cuando se presione el bot�n B
	cargarvalor 0xB,tekl4pul5        ;Carga el valor de "11" en el registro de respuesta tekl4pul5
	RETURN                                                  ;Sale de la subrutina de teclado

BoTt0NnC					;Subrutina para cuando se presione el bot�n C
	cargarvalor 0xC,tekl4pul5        ;Carga el valor de "12" en el registro de respuesta tekl4pul5
	RETURN                                                  ;Sale de la subrutina de teclado

BoTt0NnD					;Subrutina para cuando se presione el bot�n D
	cargarvalor 0xD,tekl4pul5        ;Carga el valor de "13" en el registro de respuesta tekl4pul5
	RETURN                                                  ;Sale de la subrutina de teclado

BoTt0NnAST					;Subrutina para cuando se presione el bot�n *	
	cargarvalor 0xE,tekl4pul5        ;Carga el valor de "14" en el registro de respuesta tekl4pul5
	RETURN                                                  ;Sale de la subrutina de teclado

BoTt0NnMICH					;Subrutina para cuando se presione el bot�n #
	cargarvalor 0xF,tekl4pul5        ;Carga el valor de "15" en el registro de respuesta tekl4pul5
	RETURN                                                  ;Sale de la subrutina de teclado

; Revisa las �ltimas actualizaciones de la librer�a en:
;......................................................................... rodrigocarita.com ..................................................................................................

Principal
	BANKSEL OSCCON
	MOVLW 0x6F
	MOVWF OSCCON ; Reloj interno a 4 Mhz sin PLL
	movlw 0x04
	movwf OPTION_REG ; Preescalador 1:32
	call ConfigurarPuertos
	call IN1ci0t3cla4do
	goto Loop

Interrupcion
	retfie ; Returnar de interrupcion
	
Loop
	leertecla               ;Pausamos programa hasta que se pulse una tecla
	movwf tecla_presionada     
	call 	Convertir7Segmentos
	call	Control7Segmentos
	call 	Mostrar7Segmentos
	goto 	Loop

	END