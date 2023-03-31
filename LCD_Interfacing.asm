; P1.0 - P1.7 are connected to LCD data pins D0 - D7
; P2.0 is connected to RS pin of LCD
; P2.1 is connected to R/W pin of LCD
; P2.2 is connected to E pin of LCD
        ORG 0000H
        MOV A, #38H     ; init. LCD 2 lines, 5x7 matrix
        ACALL COMNWRT   ; call command subroutine
        ACALL DELAY     ; give LCD some time
        MOV A, #0EH     ; display on, cursor on
        ACALL COMNWRT   ; call command subroutine
        ACALL DELAY     ; give LCD some time
        MOV A, #01      ; clear LCD
        ACALL COMNWRT   ; call command subroutine
        ACALL DELAY     ; give LCD some time
        MOV A, #06H     ; shift cursor right
        ACALL COMNWRT   ; call command subroutine
        ACALL DELAY     ; give LCD some time
        MOV A, #86H     ; cursor at line 1, position 6
        ACALL COMNWRT   ; call command subroutine
        ACALL DELAY     ; give LCD some time
        MOV A, #'N'     ; display letter E
        ACALL DATAWRT   ; call display subroutine
        ACALL DELAY     ; give LCD some time
        MOV A, #'O'     ; display letter S
        ACALL DATAWRT   ; call display subroutine
AGAIN:  SJMP AGAIN      ; stay here
COMNWRT:                ; send command to LCD
        MOV P1, A       ; copy reg A to port 1
        CLR P2.0        ; RS=0 for command
        CLR P2.1        ; R/W=0 for write
        SETB P2.2       ; E=1 for high pulse
        ACALL DELAY     ; give LCD some time
        CLR P2.2        ; E=0 for H-to-L pulse       
        RET
DATAWRT:
        MOV P1, A       ; copy reg A to port 1
        SETB P2.0       ; RS=1 for data
        CLR P2.1        ; R/W=0 for write
        SETB P2.2       ; E=1 for high pulse
        ACALL DELAY     ; give LCD some time
        CLR P2.2        ; E=0 for H-to-L pulse       
        RET 
DELAY:  MOV R3, #50     ; 50 or higher for fast CPUs
HERE2:  MOV R4, #255    ; R4=255
HERE:   DJNZ R4, HERE   ; stay until R4 becomes 0
        DJNZ R3, HERE2
        RET
        END
