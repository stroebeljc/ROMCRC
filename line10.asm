; Line 5 stores information that can be used to test the CRC16-CCITT routine.
Line5           DEFB $00,5                      ; Line 5
                DEFW Line5End-Line5Text         ; Line length
Line5Text       DEFB $EA                        ; REM
                DEFB _L,_M,_N,_O,_P,_Q,_R,_S,_T ; ASCII "123456789"
                DEFB _NL                        ; Newline
Line5End 

Line10          DEFB $00,10                     ; Line 10
                DEFW Line10End-Line10Text       ; Line length
Line10Text      DEFB $F1                        ; LET
                DEFB _C,_R,_C                   ; CRC
                DEFB _EQ,$D4                    ; = USR
                DEFB _1,_6,_5,_1,_4,$7E,$8F,$01,$04,$00,$00 ; 16514
                DEFB _NL                        ; Newline
Line10End 

Line20          DEFB $00,20                     ; Line 20
                DEFW Line20End-Line20Text       ; Line length
Line20Text      DEFB $F5                        ; PRINT
                DEFB _QT,_C,_R,_C,_1,_6,_SL,_C,_C,_I,_T,_T,_MI,_F,_A,_L,_S,_E,_EQ,_QT,_SC ; "CRC16/CCITT-FALSE=";
                DEFB _C,_R,_C                   ; CRC
                DEFB _NL                        ; Newline
Line20End 

Line25          DEFB $00,25                     ; Line 25
                DEFW Line25End-Line25Text       ; Line length
Line25Text      DEFB $F5                        ; PRINT
                DEFB _QT,_C,_R,_C,_1,_6,_SL,_X,_M,_O,_D,_E,_M,_EQ,_QT,_SC ; "CRC16/XMODEM=";
                DEFB $D4                        ; USR
                DEFB _1,_6,_5,_1,_9,$7E,$8F,$01,$0E,$00,$00 ; 16519
                DEFB _NL                        ; Newline
Line25End 

Line30          DEFB $00,30                     ; Line 30
                DEFW Line30End-Line30Text       ; Line length
Line30Text      DEFB $FA                        ; IF
                DEFB _C,_R,_C,_EQ,_1,_5,_1,_8,_1,$7E,$8E,$6D,$34,$00,$00 ; CRC=15181
                DEFB $DE,$F5                    ; THEN PRINT
                DEFB _QT,_Z,_X,_8,_1,__,_E,_D,_I,_T,_I,_O,_N,__,_1,__,_OP,_5,_5,_0,_CP,_QT ; "ZX81 EDITION 1 (550)";
                DEFB _NL                        ; Newline
Line30End 

Line40          DEFB $00,40                     ; Line 40
                DEFW Line40End-Line40Text       ; Line length
Line40Text      DEFB $FA                        ; IF
                DEFB _C,_R,_C,_EQ,_2,_7,_6,_6,_9,$7E,$8F,$58,$2A,$00,$00 ; CRC=27669
                DEFB $DE,$F5                    ; THEN PRINT
                DEFB _QT,_Z,_X,_8,_1,__,_E,_D,_I,_T,_I,_O,_N,__,_2,__,_OP,_6,_2,_2,_CP,_QT ; "ZX81 EDITION 2 (622)";
                DEFB _NL                        ; Newline
Line40End 

Line50          DEFB $00,50                     ; Line 50
                DEFW Line50End-Line50Text       ; Line length
Line50Text      DEFB $FA                        ; IF
                DEFB _C,_R,_C,_EQ,_5,_6,_7,_7,_6,$7E,$90,$5D,$C8,$00,$00 ; CRC=56776
                DEFB $DE,$F5                    ; THEN PRINT
                DEFB _QT,_Z,_X,_8,_1,__,_E,_D,_I,_T,_I,_O,_N,__,_3,__,_OP,_6,_4,_9,_CP,_QT ; "ZX81 EDITION 3 (649)";
                DEFB _NL                        ; Newline
Line50End 
