; PIC16F1787 Configuration Bit Settings

; Assembly source line config statements

#include "p16f1787.inc"

; CONFIG1
; __config 0xFFE4
 __CONFIG _CONFIG1, _FOSC_INTOSC & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_ON & _CLKOUTEN_OFF & _IESO_ON & _FCMEN_ON
; CONFIG2
; __config 0xFFFF
 __CONFIG _CONFIG2, _WRT_OFF & _VCAPEN_OFF & _PLLEN_ON & _STVREN_ON & _BORV_LO & _LPBOR_OFF & _LVP_ON

; Variables
Num1		EQU 0x70
Num2		EQU 0x71
Num3		EQU 0x72
Num4		EQU 0x73
NUMTECLA	EQU 0x74 ;             variable usada para guardar el numero asignado a cada tecla
TEMP		EQU 0x75
BANDERAS	EQU 0x76
CONTADOR_TIEMPO	EQU 0x78
HELPER		EQU 0x79
CONTADOR_ALARMA EQU 0X7A

#define REINICIO_PENDIENTE 0
#define PAUSADO 1
#define ALARMA_PENDIENTE 2
#define ALARMA_MOSTRAR 3

#define RESET_COMANDO 0x10
#define START_PAUSA_COMANDO 0x20
; Inicio del programa
 	ORG	0x00
	GOTO	INICIO
	ORG	0x04			; Vector de interrupci¢n
	BANKSEL INTCON			
	BTFSC	INTCON, TMR0IF	; Interrupci¢n por timer0?
	CALL	BARRIDO_LED
	
	
	BTFSC	INTCON, TMR0IF		; Interrupci¢n por cambio de nivel?
	CALL	CONTROL_TEMPORIZADOR
	
	banksel INTCON
	BTFSC	INTCON, TMR0IF		; Interrupci¢n por cambio de nivel?
	CALL	CONTROL_ALARMA
	
	BANKSEL IOCAF		
	BTFSC	BANDERAS, REINICIO_PENDIENTE
	CALL	RESTART
	
	BTFSS   BANDERAS, PAUSADO
	CALL	ENCENDER_MOTOR
	
	BTFSC	BANDERAS, PAUSADO
	CALL	APAGAR_MOTOR
	
	banksel PORTE
	BTFSC   BANDERAS, ALARMA_MOSTRAR
	bsf  	PORTE, RE1
	
	BTFSS	BANDERAS, ALARMA_MOSTRAR
	bcf	PORTE, RE1
	
SALIR	NOP
	BANKSEL IOCAF		
	CLRF	IOCAF
	BANKSEL INTCON
	BCF	INTCON,IOCIF		; Se desactiva la bandera de interrupci¢n
	BCF	INTCON,TMR0IF
        RETFIE

TECLA	NOP
NEW_SCAN    
	CLRF  NUMTECLA	   ; Borra el contenido de numTecla
	INCF  NUMTECLA,F   ; Inicializa numTecla
	BANKSEL PORTA
	MOVLW 0xFE    	   ; Pone a 0 la primera Fila ( RA0 )
	MOVWF PORTA
	NOP                ; Espera estabilizar la se¤al
	   
			   ;Rutina que verifica el estado de las columnas
CHK_COL
			          ;Verifica si se ha presionado alguna tecla
	BTFSS PORTA,4       ; Columna 1=0?
	GOTO  TECLA_ON     ; Sale si se ha pulsado una tecla
	INCF  NUMTECLA,F   ; Incrementa n£mero de tecla

	BTFSS PORTA,5           ; Columna 2=0?
	GOTO  TECLA_ON          ; Sale si se ha pulsado una tecla
	INCF  NUMTECLA,F        ; Incrementa n£mero de tecla

	BTFSS PORTA,6           ; Columna 3=0?
	GOTO  TECLA_ON          ; Sale si se ha pulsado una tecla
	INCF  NUMTECLA,F        ; Incrementa n£mero de tecla
	    
				;Verifica si se ha recorrido todo el teclado
	MOVLW 0x0D              ; N£mero total de teclas + 1
	XORWF NUMTECLA,W        ; Realiza d'13' XOR numTecla
	BTFSC STATUS,Z          ; Verifica el estado de Z
	GOTO  NEW_SCAN          ; Z=1?, Son iguales (full Scan) , Z=0?	
				;, Son diferentes,
	    
NEXT_COL    
	BSF  STATUS,C		; Enciende el carry para poner en "1" la FILA recorrida
	RLF  PORTA,F		;realiza corrimiento a la izquierda
				;, pone a cero la siguiente FILA
	GOTO CHK_COL    	; Escanea la sig. COLUMNA
 
;Rutina que procesa la tecla capturada
TECLA_ON    
				;Rutinas que esperan a que se deje de presionar la tecla
				;Esto para evitar ECO
ESPERA1	BTFSS   PORTA,4         ;Si no se suelta la tecla de la COL 1
	GOTO    ESPERA1                    ; vuelve a esperar.
ESPERA2	BTFSS   PORTA,5         ;Si no se suelta la tecla de la COL 2
	GOTO    ESPERA2                    ;vuelve a esperar.
ESPERA3	BTFSS   PORTA,6         ;Si no se suelta la tecla de la COL 3
	GOTO    ESPERA3                    ;vuelve a esperar.
			                          ;Una vez que dej¢ de presionar la tecla

	MOVF   	NUMTECLA,W       ; Pone en W el valor de numTecla
	CALL   	CONV_TECLA_NUMERO       ; Llama a la rutina de conversi¢n A ASCII
	MOVWF  	TEMP
	
	xorlw  	RESET_COMANDO
	btfsc 	STATUS, Z
	goto 	CONFIGURAR_RESET
	
	MOVF	TEMP, W ; W cambia asi que usar de nuevo
	xorlw  	START_PAUSA_COMANDO
	btfsc 	STATUS, Z
	goto 	ALTERNAR_PAUSA_START
	
	btfss	BANDERAS, PAUSADO ; Si esta pausado no modificar mas nada
	return 
	
	bcf	BANDERAS, ALARMA_MOSTRAR
	bcf	BANDERAS, ALARMA_PENDIENTE
		
	MOVF   	Num3,W
        MOVWF  	Num4
	MOVF   	Num2,W
        MOVWF  	Num3
	MOVF   	Num1,W
        MOVWF  	Num2
	MOVF   	TEMP,W
        MOVWF  	Num1
	RETURN

CONFIGURAR_RESET
	bsf 	BANDERAS, REINICIO_PENDIENTE
	RETURN	

ALTERNAR_PAUSA_START
	bsf 	HELPER, PAUSADO	; Setear el bit a modificar
	movf	HELPER, W	; pasarlo a w
	xorwf 	BANDERAS, F	; xor operacion
	return
;Rutina de conversi¢n que retorna el valor  ASCII de
;numTecla en W
CONV_7SEG
        ADDWF PCL,1
        RETLW	0x3F				; Linea 0 (no se utiliza)
        RETLW	0x06			; Uno
	RETLW	0x5B			; Dos
	RETLW	0x4F			; Tres
	RETLW	0x66			; Cuatro
	RETLW	0x6D			; Cinco
	RETLW	0x7D			; Seis
	RETLW	0x07			; Siete
	RETLW	0x7F			; Ocho
	RETLW	0x6F     		; Nueve
	RETLW	0x20			; *
	RETLW	0x3F			; Cero
	RETLW	0x10			; #
	RETURN

CONV_TECLA_NUMERO
        ADDWF PCL,1
        RETLW	0x00				; Linea 0 (no se utiliza)
        RETLW	0x01			; Uno
	RETLW	0x02			; Dos
	RETLW	0x03			; Tres
	RETLW	0x04			; Cuatro
	RETLW	0x05			; Cinco
	RETLW	0x06			; Seis
	RETLW	0x07			; Siete
	RETLW	0x08			; Ocho
	RETLW	0x09     		; Nueve
	RETLW	0x20			; *
	RETLW	0x00			; Cero
	RETLW	0x10			; #
	RETURN
		
BARRIDO_LED
	BSF  STATUS,C
	RLF  PORTD,F
	MOVLW 0xEF              ; N£mero total de teclas + 1
	XORWF PORTD,W           ; Realiza d'13' XOR numTecla
	BTFSS STATUS,Z          ; Verifica el estado de Z
	GOTO  SIGUIENTE
	MOVLW 0x0E              ; N£mero total de teclas + 1
	MOVWF PORTD
	MOVF  Num1,W
	CALL  CONV_7SEG
	MOVWF PORTC
	RETURN
SIGUIENTE
	MOVLW 0x1D              ; N£mero total de teclas + 1
	XORWF PORTD,W           ; Realiza d'13' XOR numTecla
	BTFSS STATUS,Z          ; Verifica el estado de Z
	GOTO  N2
	MOVF  Num2,W
	CALL  CONV_7SEG
	MOVWF PORTC
	RETURN
N2	MOVLW 0x3B              ; N£mero total de teclas + 1
	XORWF PORTD,W           ; Realiza d'13' XOR numTecla
	BTFSS STATUS,Z          ; Verifica el estado de Z
	GOTO  N3
	MOVF  Num3,W
	CALL  CONV_7SEG
	MOVWF PORTC
	RETURN
N3	MOVLW 0x77              ; N£mero total de teclas + 1
	XORWF PORTD,W           ; Realiza d'13' XOR numTecla
	BTFSS STATUS,Z          ; Verifica el estado de Z
	RETURN
	MOVF  Num4,W
	CALL  CONV_7SEG
	MOVWF PORTC
	RETURN
	
RESTART
	MOVLW	0x00
	MOVWF	Num1
	MOVLW	0x00
	MOVWF	Num2
	MOVLW	0x00
	MOVWF	Num3
	MOVLW	0x00
	MOVWF	Num4
	CLRF 	HELPER
	BCF	BANDERAS, REINICIO_PENDIENTE
	BSF	BANDERAS, PAUSADO
	bcf	BANDERAS, ALARMA_MOSTRAR
	bcf	BANDERAS, ALARMA_PENDIENTE
	RETURN

INICIO	
	BANKSEL	OSCCON
	MOVLW	0x6F
	MOVWF	OSCCON	   ; Reloj interno a 4 mhz sin PLL
	BANKSEL ANSELD
	CLRF	ANSELD     ; puertos D y E como digitales
	CLRF	ANSELA
	CLRF	ANSELE
	
	BANKSEL TRISD
	CLRF	TRISD      ; Puertos D y E como salidas
	CLRF	TRISC
	CLRF	TRISE
	MOVLW  	0xF0
	MOVWF   TRISA	   ;RB0-RB3 como SALIDA, RB4-RB7 como ENTRADA
	
	BANKSEL INTCON
	MOVLW 0XE8
	MOVWF INTCON
	BANKSEL OPTION_REG
	MOVLW 0X03
	MOVWF OPTION_REG
	
	BANKSEL	TMR0		
	MOVLW 	0x00
	MOVWF	TMR0
	
	BANKSEL WPUA
	MOVLW   0xF0
	MOVWF   WPUA
	
	BANKSEL IOCAP	    
	MOVLW	0x80
	MOVWF	IOCAP	; Activo las interrupciones por flanco de subida para RA7
	CALL	RESTART
	BANKSEL PORTC
	MOVLW	0x40
	MOVWF	PORTC
	BANKSEL PORTD
	MOVLW	0x0E
	MOVWF	PORTD
	CLRF	PORTE
	CALL	TECLA
	GOTO $-1

Temporizador
	; Temporizador
	; Funciona pidiendo prestado numeros a las unidades mas altas
	; basicamente es una resta manual de todos los numeros
	; decimas pide prestado a segundos
	; segundos pide prestado a minutos
	; Si todas las unidades son cero entonces cambia a modo de alarma
	goto TemporizadorNum1		
TemporizadorFin
	return
	
TemporizadorNum1
	movf	Num1, W
	xorlw	0x0
	btfsc 	STATUS, Z 	; si son iguales cambia el numero
	goto TemporizadorNum2
	decf Num1, F 
	goto TemporizadorFin

TemporizadorNum2
	movf	Num2, W
	xorlw	0x0
	btfsc 	STATUS, Z 	; si son iguales cambia el numero
	goto 	TemporizadorNum3
	call 	CargarSegundosUnidad
	decf 	Num2, F 
	goto 	TemporizadorFin
	
TemporizadorNum3	
	movf	Num3, W
	xorlw	0x0
	btfsc 	STATUS, Z 	; si son iguales cambia el numero
	goto 	TemporizadorNum4
	call 	CargarSegundosDecima
	decf 	Num3, F 
	goto 	TemporizadorFin

TemporizadorNum4
	movf	Num4, W
	xorlw	0x00
	btfsc 	STATUS, Z 	; si son iguales cambia el numero
	goto 	CambiarAModoAlarma
	call 	CargarMinutosUnidad
	decf 	Num4, F 
	goto 	TemporizadorFin

; Manejar Numeros prestado
CargarMinutosUnidad
	MOVLW	0X09
	MOVWF	Num3
CargarSegundosDecima
	MOVLW	0x05
	MOVWF	Num2
CargarSegundosUnidad
	MOVLW 	0x09
	MOVWF	Num1	
	return

CambiarAModoAlarma	
	clrf CONTADOR_ALARMA
	clrf CONTADOR_TIEMPO
	bsf BANDERAS, PAUSADO
	bsf BANDERAS, ALARMA_PENDIENTE
	bsf BANDERAS, ALARMA_MOSTRAR
	return
 
ALTERNAR_MOSTRAR_ALARMA
	clrf	HELPER
	bsf 	HELPER, ALARMA_MOSTRAR	; Setear el bit a modificar
	movf	HELPER, W	; pasarlo a w
	xorwf 	BANDERAS, F	; xor operacion
	return
	
CONTROL_TEMPORIZADOR
	btfsc BANDERAS, ALARMA_PENDIENTE
	return 
        btfsc BANDERAS, PAUSADO
        return; No esta funcionando el temporizador
	; Contando que cada interrupcion ocurre cada 0.004 segundos
	; entonces cada 250 interrupciones sera 1 segundo
	INCF CONTADOR_TIEMPO, F ; incrementa en 1
	MOVF CONTADOR_TIEMPO, W 
	xorlw 0xFA ; compara si es 250
	btfss STATUS, Z
	return ; no lo es
	
	CLRF CONTADOR_TIEMPO ;Si lo es
	call Temporizador
	return

ENCENDER_MOTOR
	banksel PORTE
	bsf PORTE, RE0
	return

APAGAR_MOTOR
	banksel PORTE
	bcf PORTE, RE0
	return

	
CONTROL_ALARMA
        btfss BANDERAS, ALARMA_PENDIENTE
        return; No esta funcionando el temporizador
	; Contando que cada interrupcion ocurre cada 0.004 segundos
	; entonces cada 125 interrupciones sera 0.5 segundo
	INCF CONTADOR_TIEMPO, F ; incrementa en 1
	MOVF CONTADOR_TIEMPO, W 
	xorlw 0x7D ; compara si es 125
	btfss STATUS, Z
	return ; no lo es
	CLRF CONTADOR_TIEMPO ;Si lo es
	
	call ALTERNAR_MOSTRAR_ALARMA
	
	INCF CONTADOR_ALARMA, F
	MOVF CONTADOR_ALARMA, W
	xorlw 0x05; si esto llega a 5 significa que la alarma sono 3 veces
	btfss STATUS, Z
	return 
	
	CLRF CONTADOR_ALARMA
	call RESTART
	return
	END