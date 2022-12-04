.MODEL SMALL	; Memory configuration
.STACK 100H		; Stack size in bytes
.data			; Data section

str1 DB "1. Array Sorting: $"
str2 DB "2. Word Counter: $"
str3 DB "2. Exit: $"

str4 DB "Enter your choice: $"
dim DB "Enter the dimenSIon of array: $"
str5 DB "Enter elements of Array: $"
array DB 100 DUP(0) 
str6 DB "Array after sorting: $"

str7 DB "Enter a string: $"
str8 DB "Enter a Word: $"
str9 DB 0DH,0AH,"Occurance = $"
arr DB 100 DUP(0)
arr2 DB 100 DUP(0)
cntr DB 0
ten DB 10
choice DB 0

.code			; Code section
;-------------------------------------------------------
Read1 PROC
LEA DX,str5		;------------------
MOV AH,09H		; PrINT prompt message
INT 21H			;------------------

MOV CX,dim		; Set loop counter to dim
MOV SI,0H		; First element has 0 index
L11: MOV AH,01H	; Read number from user
INT 21H			; -----------------

SUB AL,30H		; if input 5 ----> 35 -----> 5
MOV array[SI],AL 

LOOP L11

RET
Read1 ENDP
;-------------------------------------------------------
Sortingg PROC
MOV BX, OFFSET array
    MOV CX, dim
    MOV DX, CX
    LO1:      
       MOV SI, 0
       MOV AX, SI
       INC AX
       MOV DI, AX
       MOV DX, CX
    LO2:
       MOV AL, [BX][SI]
       CMP AL, [BX][DI]
       JG LO4
    LO3:
       INC SI
       INC DI
       DEC DX
       CMP DX, 00
       JE LO1
       JG LO2
    LO4:
       MOV AL, [BX][SI]
       MOV AH, [BX][DI]
       MOV [BX][SI], AH
       MOV [BX][DI], AL
       INC SI
       INC DI       
       DEC DX
       CMP DX, 00
       JE LO1
       JG LO2

RET
Sortingg ENDP
;-------------------------------------------------------

Display1 PROC
LEA DX,str5		;------------------
MOV AH,09H		; PrINT prompt message
INT 21H			;------------------

MOV CX,dim		; Set loop counter to dim
MOV SI,0H		; First element has 0 index
L22: MOV AH,01H	; Read number from user
INT 21H			; -----------------

SUB AL,30H		; if input 5 ----> 35 -----> 5
MOV array[SI],AL 

LOOP L22

RET
Display1 ENDP
;-------------------------------------------------------

Read2 PROC
LEA DX,str6		;------------------
MOV AH,09H      ; Print prompt message
INT 21H         ;------------------

MOV SI,0H		;--------------
L1: MOV AH,01H	;
INT 21H			; Read string from 
MOV arr[SI],AL	;  user ended by 
INC SI			;      Enter 
CMP AL,0DH		;
JNZ L1			;---------------

LEA DX,str8		;------------------
MOV AH,09H      ; Print prompt message
INT 21H         ;------------------

MOV SI,0H		;--------------
L2: MOV AH,01H	;
INT 21H			; Read Word from 
MOV arr2[SI],AL	;  user ended by 
INC SI			;      Enter 
CMP AL,0DH		;
JNZ L2			;---------------
RET
Read2 ENDP

;-------------------------------------------------------
Count PROC
MOV BH,0h			;-------------
MOV SI,0H			;	
L3: MOV AL,arr[SI]	; Check number of
CMP AL,lttr			;  times word 
JNE invld			; occured in string
INC BH				;
invld: INC SI		;
CMP AL,0DH			;
JNZ L3				;-------------

MOV cntr,BH
RET
Count ENDP

;-------------------------------------------------------
Display2 PROC
LEA DX,str9		;------------------
MOV AH,09H      ; Print prompt message
INT 21H         ;------------------


RET
Display2 ENDP
;-------------------------------------------------------

Sorting PROC
CALL Read1
Call Sortingg
CALL Display1
RET
Sorting ENDP
;-------------------------------------------------------

Counter PROC
CALL Read2
CALL Count
CALL Display2
RET
Counter ENDP
;-------------------------------------------------------

MAIN PROC
;Initialize DS
MOV AX,@DATA	; Set address of data segment
MOV DS,AX

LEA DX,str1		
MOV AH,09H      
INT 21H         

LEA DX,str2		
MOV AH,09H      
INT 21H    

LEA DX,str3		
MOV AH,09H      
INT 21H    

LEA DX,str4		
MOV AH,09H      
INT 21H    


MOV AH,01h
INT 21h
MOV choice, AL

CMP choice, 1
JE ch1

CMP choice, 2
JE ch2
JMP ch3

ch1: Call Sorting
ch2: Call Counter



ch3: MOV AH,4CH; End of program    
INT 21H

MAIN ENDP
END MAIN