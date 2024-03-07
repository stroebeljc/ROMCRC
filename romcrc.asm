;
;       ZX81 CRC-CCITT
;       -----------------
;
; By stroebeljc (2024)
;
;

;defs
#include "zx81defs.asm"
;ZX81 char codes/how to survive without ASCII
#include "charcodes.asm"
;system variables
#include "zx81sys.asm"


;Line 0
;the standard REM statement that will contain our 'hex' code
Line0:          DEFB $00,0                      ; Line 0
                DEFW Line0End-Line0Text         ; Line length
Line0Text:      DEFB $EA                        ; REM


START
       LD BC, $FFFF                             ; Initial CRC value $FFFF
       EXX                                      ; Store CRC in HL'
       PUSH HL                                  ; Save HL' register used by FP calculator
       LD HL, $0000                             ; ROM starts at address $0000
       ;LD HL, $40D0                             ; Test string starts at address $40D0
       LD BC, $2000                             ; ROM size is 8k ($0000 = 64k bytes)
       ;LD BC, $0009                             ; Test string size is 9 bytes
       LD DE, UNUSED1                           ; Scratch byte

LOOP

       LDI                                      ; Copy a byte from ROM to unused area
       DEC DE                                   ; Point back to the start of the current word
       
       LD A,(DE)                                ; Load the byte into the accumulator
       
       EXX                                      ; Get the CRC
       
       XOR B                                    ; A = crc >> 8 ^ A
       LD B,A
       SRL B
       SRL B
       SRL B
       SRL B
       XOR B                                    ; A ^= A >> 4
       
       LD B,C                                   ; Now calculate the following:
       LD C,A                                   ; crc = (crc << 8) ^ (x << 12) ^ (x <<5) ^ x
       SLA A
       SLA A
       SLA A
       SLA A
       XOR B
       LD B,A
       LD A,C
       SRL A
       SRL A
       SRL A
       XOR B
       LD B,A                                   ; Upper byte of CRC is done

       LD A,C
       SLA A
       SLA A
       SLA A
       SLA A
       SLA A
       XOR C
       LD C,A                                   ; Lower byte of CRC is done
       
       EXX                                      ; Store CRC in HL' and return regs for loop
       LD A,B
       OR C
       
       JR NZ,LOOP                               ; done when both B and C are zero

       POP HL                                   ; Restore HL' register
       EXX

       RET                                      ; CRC value returned to BASIC in BC

;this is the end of line 0 - the first REM
                DEFB _NL                        ; Newline
Line0End

;append the BASIC code that runs the program
#include "line10.asm"

; ===========================================================
; code ends
; ===========================================================
;display file defintion
#include "screen.asm"

;close out the basic program
#include "endbasic.asm"
