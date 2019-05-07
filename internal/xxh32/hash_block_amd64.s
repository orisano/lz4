// +build amd64

#include "textflag.h"

DATA prime1<>+0x00(SB)/4,$2654435761
DATA prime1<>+0x04(SB)/4,$2654435761
DATA prime1<>+0x08(SB)/4,$2654435761
DATA prime1<>+0x0C(SB)/4,$2654435761
GLOBL prime1<>(SB), (RODATA | NOPTR), $16

DATA prime2<>+0x00(SB)/4,$2246822519
DATA prime2<>+0x04(SB)/4,$2246822519
DATA prime2<>+0x08(SB)/4,$2246822519
DATA prime2<>+0x0C(SB)/4,$2246822519
GLOBL prime2<>(SB), (RODATA | NOPTR), $16

// func hashBlocks(input []byte, p, n int64, v1, v2, v3, v4 uint32) (int, uint32, uint32, uint32, uint32)
TEXT ·hashBlocks(SB), NOSPLIT, $0-80
    MOVQ input+0(FP), BX
    MOVQ p+24(FP), AX
    MOVQ n+32(FP), CX
    VMOVDQU v+40(FP), X1
    VMOVDQU prime1<>(SB), X2
    VMOVDQU prime2<>(SB), X3
    JMP noinc
loop:
    VMOVDQU (BX), X4
    VPMULLD X4, X3, X4
    VPADDD X1, X4, X1

    // rot13
    VPSRLD $19, X1, X4
    VPSLLD $13, X1, X1
    VPOR X1, X4, X1

    VPMULLD X1, X2, X1

    ADDQ $16, BX
    ADDQ $16, AX
noinc:
    CMPQ AX, CX
    JLE loop
    MOVQ AX, p+56(FP)
    VMOVDQU X1, r+64(FP)
    RET
