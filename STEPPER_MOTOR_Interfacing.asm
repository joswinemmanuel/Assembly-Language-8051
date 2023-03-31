        ORG 0000H
        MOV A, #66H
LOOP:   MOV P2, A
        ACALL DELAY
        RR A
        SJMP LOOP
DELAY:  MOV R5, #0AH
AGAIN:  MOV R3, #0FFH
BACK:   DJNZ R3, BACK
        DJNZ R5, AGAIN
        RET
        END
