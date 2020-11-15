#include<p18F4550.inc>

loop_cnt1	set	0x00
loop_cnt2	set 0x01
		
			org	0x00
			goto	start
			org 0x08
			retfie
			org 0x18
			retfie

dup_nop		macro	kk
			variable	i
i=0
			while i	<	kk
			nop
i+=1
			endw
			endm


;**********************************************************
			;Subroutine For 7 Segment Display
;**********************************************************


SHOW6		SETF	PORTD,A
			BCF		PORTD,1,A
			RETURN

SHOW5		SETF	PORTD,A
			BCF		PORTD,1,A
			BCF		PORTD,4,A
			RETURN

SHOW1		CLRF	PORTD,A
			BSF		PORTD,1,A
			BSF		PORTD,2,A
			RETURN


;********************************************************
						;Main Program
;*******************************************************

start		CLRF	TRISD, A
loop		CALL	SHOW6
			CALL	Delay11ms	
			CALL	SHOW5
			CALL	Delay11ms
			CALL	SHOW1
			CALL	Delay11ms

			BRA	loop



;********************************************************
	;Subroutine 11 MilliSecond Delay & 20MHz Crystal Frequency
;****************************************************************		


Delay11ms		MOVLW	D'250'
				MOVWF	loop_cnt2,A
AGAIN1			MOVLW	D'20'
				MOVWF	loop_cnt1,A
AGAIN			dup_nop	D'5'
				DECFSZ	loop_cnt1,F,A
				BRA	AGAIN
				DECFSZ	loop_cnt2,F,A
				BRA AGAIN1
				RETURN

				END