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


CFALS
       LD BC, $FFFF                             ; Initial CRC value for CRC-16/CCITT-FALSE is $FFFF
       JR START

CXMOD
       LD BC, $0000                             ; Initial CRC value for CRC-16/XMODEM is $0000

START
       LD HL, $0000                             ; ROM starts at address $0000
       ;LD HL, $40C6                             ; Test string starts at address $40C6
       LD DE, $2000                             ; ROM size is 8k ($0000 = 64k bytes)
       ;LD DE, $0009                             ; Test string size is 9 bytes

LOOP

       LD A,(HL)                                ; Load the byte into the accumulator

       XOR B                                    ; Step 1) A = crc >> 8 ^ A

       LD B,A                                   ; Step 2) A ^= A >> 4
       SRL B
       SRL B
       SRL B
       SRL B
       XOR B

                                                ; Step 3) crc = (crc << 8) ^ (A << 12) ^ (A <<5) ^ A
       LD B,C                                   ;  3a) crc_upper = crc_lower
       LD C,A                                   ;  Since C is no longer needed, use it to store A for later
       SLA A
       SLA A
       SLA A
       SLA A
       XOR B
       LD B,A                                   ;  3b) crc_upper ^= A << (12 - 8)
       LD A,C
       SRL A
       SRL A
       SRL A
       XOR B
       LD B,A                                   ;  3c) crc_upper ^= A << (5 - 8) => A >> 3
                                                ; Upper byte of CRC is done
       LD A,C
       SLA A
       SLA A
       SLA A
       SLA A
       SLA A
       XOR C
       LD C,A                                   ;  3d) crc_lower = A ^ (A << 5)
                                                ; Lower byte of CRC is done

       INC HL                                   ; Point to next address
       DEC DE                                   ; Decrease loop counter
       LD A,D
       OR E
       JR NZ,LOOP                               ; done when both D and E are zero

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
