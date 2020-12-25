

RB0     EQU     000H    ; Select Register Bank 0
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;		PORT DECLERATION
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
CLK	EQU	P0.4
START	EQU	P0.0
EOC	EQU	P0.1

DATA1	EQU	P2.4
DATA2	EQU	P2.5
DATA3	EQU	P2.6
DATA4	EQU	P2.7
DATA5	EQU	P0.2
DATA6	EQU	P0.6
DATA7	EQU	P0.5
DATA8	EQU	P0.7

ALE	EQU	P2.3

ADD_A	EQU	P2.0
ADD_B	EQU	P2.1
ADD_C	EQU	P2.2

OUT_EN	EQU	P0.3

FRONT		EQU	P3.3
LEFT		EQU	P3.5
RIGHT		EQU	P3.4

BLOWER	EQU	P3.0

MOTOR		EQU	P1

COIL1		EQU	P1.0
COIL2		EQU	P1.1
COIL3		EQU	P1.2
COIL4		EQU	P1.3

COIL5		EQU	P1.4
COIL6		EQU	P1.5
COIL7		EQU	P1.6
COIL8		EQU	P1.7


DSEG            ; This is internal data memory
ORG     20H     ; Bit adressable memory
VALUE:	DS	1

STACK:	DS	1
CSEG            ; Code begins here
         
;---------==========----------==========---------=========---------
;  Main routine. Program execution starts here.
;---------==========----------==========---------=========---------
		ORG     00H    ; Reset
		AJMP MAIN
		       
		ORG 000BH
		CPL CLK
		RETI
;---------==========----------==========---------=========---------		
MAIN:		
         MOV    PSW,#RB0    		  ; Select register bank 0
        	MOV    SP,#60H
        	MOV TMOD,#02H
        	MOV TH0,#0A4H
        	MOV IE,#82H
        	SETB TR0
        	CLR BLOWER
        	CALL READ_ADC
        	
        	
        	
        	
        	
        	
        	
        	
        	
;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
;		INITIALIZE ADC CHIP
;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&        	
READ_ADC:
        	CLR START
        	CLR ALE
        	CLR OUT_EN
        	SETB ADD_A
        	SETB ADD_B
        	CLR ADD_C
        	SETB ALE
        	NOP
        	NOP
        	NOP
        	NOP
        	CLR ALE
        	SETB START
        	NOP
        	NOP
        	NOP
        	NOP
        	CLR START
        	CALL DELAY
        	SETB EOC
        	JNB EOC,$
        	SETB OUT_EN
        	NOP
        	NOP
        	NOP
        	NOP
        	CLR OUT_EN
        	CALL READ_TEMP
        	RET  	
;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
;			READ TEMPERATURE
;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&	   	
READ_TEMP:
			SETB DATA1
			SETB DATA2
			SETB DATA3
			SETB DATA4
			SETB DATA5
			SETB DATA6
			SETB DATA7
			SETB DATA8
			MOV VALUE,#00H
			JNB DATA1,DF1
			SETB VALUE.7
DF1:		JNB DATA2,DF2
			SETB VALUE.6
DF2:		JNB DATA3,DF3
			SETB VALUE.5
DF3:		JNB DATA4,DF4
			SETB VALUE.4
DF4:		JNB DATA5,DF5
			SETB VALUE.3
DF5:		JNB DATA6,DF6
			SETB VALUE.2
DF6:		JNB DATA7,DF7
			SETB VALUE.1
DF7:		JNB DATA8,DF8
			SETB VALUE.0
DF8:		RET
;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&			
DELAY:
			MOV R0,#35H
RP2:		MOV R1,#0FFH
RP1:		NOP
			DJNZ R1,RP1
			DJNZ R0,RP2
			RET
			
DELAYS1:
			MOV R0,#0FFH
RP2X:		MOV R1,#0FFH
RP1X:		NOP
			DJNZ R1,RP1X
			DJNZ R0,RP2X
			RET


DELAYF:
			MOV R0,#0FFH
RRP2:		MOV R1,#0FFH
RRP1:		NOP
			DJNZ R1,RRP1
			DJNZ R0,RRP2
			RET

; **********************************************************
END

