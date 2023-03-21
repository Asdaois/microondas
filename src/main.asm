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

#define REINICIO_PENDIENTE 0

#define RESET_COMANDO 0x10
; Inicio del programa
 	ORG	0x00
	GOTO	INICIO
	ORG	0x04			; Vector de interrupci¢n
	BANKSEL INTCON			
	BTFSC	INTCON, TMR0IF		; Interrupci¢n por cambio de nivel?
	CALL	BARRIDO_LED

	BANKSEL IOCAF		
	BTFSC	BANDERAS, REINICIO_PENDIENTE
	CALL	RESTART
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

	MOVF   NUMTECLA,W       ; Pone en W el valor de numTecla
	CALL   CONV_TECLA       ; Llama a la rutina de conversi¢n A ASCII
	MOVWF  TEMP
	
	xorlw  RESET_COMANDO
	btfsc STATUS, Z
	goto CONFIGURAR_RESET
		
	MOVF   Num3,W
        MOVWF  Num4
	MOVF   Num2,W
        MOVWF  Num3
	MOVF   Num1,W
        MOVWF  Num2
	MOVF   TEMP,W
        MOVWF  Num1
	RETURN

CONFIGURAR_RESET
	bsf BANDERAS, REINICIO_PENDIENTE
	RETURN	
;Rutina de conversi¢n que retorna el valor  ASCII de
;numTecla en W
CONV_TECLA
        ADDWF PCL,1
        NOP				; Linea 0 (no se utiliza)
        RETLW	0x06			; Uno
	RETLW	0x5B			; Dos
	RETLW	0x4F			; Tres
	RETLW	0x66			; Cuatro
	RETLW	0x6D			; Cinco
	RETLW	0x7D			; Seis
	RETLW	0x07			; Siete
	RETLW	0x7F			; Ocho
	RETLW	0x6F     		; Nueve
	RETLW	0x04			; *
	RETLW	0x3F			; Cero
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
	MOVWF PORTC
	RETURN
SIGUIENTE
	MOVLW 0x1D              ; N£mero total de teclas + 1
	XORWF PORTD,W           ; Realiza d'13' XOR numTecla
	BTFSS STATUS,Z          ; Verifica el estado de Z
	GOTO  N2
	MOVF  Num2,W
	MOVWF PORTC
	RETURN
N2	MOVLW 0x3B              ; N£mero total de teclas + 1
	XORWF PORTD,W           ; Realiza d'13' XOR numTecla
	BTFSS STATUS,Z          ; Verifica el estado de Z
	GOTO  N3
	MOVF  Num3,W
	MOVWF PORTC
	RETURN
N3	MOVLW 0x77              ; N£mero total de teclas + 1
	XORWF PORTD,W           ; Realiza d'13' XOR numTecla
	BTFSS STATUS,Z          ; Verifica el estado de Z
	RETURN
	MOVF  Num4,W
	MOVWF PORTC
	RETURN
	
RESTART
	MOVLW	0x40
	MOVWF	Num1
	MOVLW	0x40
	MOVWF	Num2
	MOVLW	0x40
	MOVWF	Num3
	MOVLW	0x40
	MOVWF	Num4
	BCF	BANDERAS, REINICIO_PENDIENTE
	RETURN

INICIO	
	BANKSEL	OSCCON
	MOVLW	0x6F
	MOVWF	OSCCON	   ; Reloj interno a 4 mhz sin PLL
	BANKSEL ANSELD
	CLRF	ANSELD     ; puertos D y E como digitales
	CLRF	ANSELA
	
	BANKSEL TRISD
	CLRF	TRISD      ; Puertos D y E como salidas
	CLRF	TRISC
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
	MOVLW	0x40
	MOVWF	Num1
	MOVLW	0x40
	MOVWF	Num2
	MOVLW	0x40
	MOVWF	Num3
	MOVLW	0x40
	MOVWF	Num4
	BANKSEL PORTC
	MOVLW	0x40
	MOVWF	PORTC
	BANKSEL PORTD
	MOVLW	0x0E
	MOVWF	PORTD
	CALL	TECLA
	GOTO $-1
	END