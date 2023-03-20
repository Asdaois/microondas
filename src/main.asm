#include "p16f1787.inc"

; CONFIG1
; __config 0xFFE4
	__CONFIG _CONFIG1, _FOSC_INTOSC & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_ON & _CLKOUTEN_OFF & _IESO_ON & _FCMEN_ON
; CONFIG2
; __config 0xFFFF
	__CONFIG _CONFIG2, _WRT_OFF & _VCAPEN_OFF & _PLLEN_ON & _STVREN_ON & _BORV_LO & _LPBOR_OFF & _LVP_ON

CBLOCK 0x70 ;Ran comun

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
	movlw	0xFF
	movwf	TRISB	; Entrada
	banksel	PORTD
	CLRF 	PORTD
	clrf	PORTC
	return

Convertir7Segmentos; Tabla 7 segmentos catodo comun
	brw
	retlw 	0xC0; 0
	retlw 	0xF9; 1
	retlw 	0xA4; 2
	retlw 	0xB0; 3
	retlw 	0x99; 4
	retlw 	0x92; 5
	retlw 	0x83; 6
	retlw 	0xE8; 7
	retlw 	0x80; 8
	retlw 	0x98; 9


Principal
	call ConfigurarPuertos
	goto Loop

Interrupcion
	retfie ; Returnar de interrupcion
	
Loop
	movlw 	1
	call 	Convertir7Segmentos
	call	Control7Segmentos
	call 	Mostrar7Segmentos
	goto 	Loop
	end	
	END