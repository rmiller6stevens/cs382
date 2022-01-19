
.text
.global _start
.extern printf

_start:
ADR x1, tolerance 
LDR d25, [x1] //tao
ADR x1, coeff
ADR x2, a
LDR d1, [x2] //a
ADR x2, b
LDR d2, [x2] //b
ADR x20, n
LDR x3, [x20] //n
FMOV d4, d1 
bl solveY //solves for A
FMOV d5, d15 //ay
ldr x3, [x20] //resets n, in case of 0.0
FMOV d4, d2 
bl solveY
FMOV d6, d15 //by
//FMOV d0, d15
//ADR X0, msg tests the soleY
//bl printf

bl mainSolve


solveY: 
SUB SP, SP, 8
STUR X30, [SP, 0]

FMOV d15, XZR //total
FMOV d16, XZR //reference to 0
MOV x2, 0 // i for outer loop
MOV x7, 0 // J

loop1:
CMP x2, x3 //compare i to n
BGT endL1
FMOV d14, 1.0 //temp
LSL x4, x2, 3
ADD x5, x1, x4
LDR d3, [x5]
FCMP d3, d16
BEQ isZero

loop2:
CMP x7, x2
BGE exitLoop2
FMUL d14, d14, d4
ADD X7, X7, 1 //increments J
b loop2

exitLoop2:
FMUL d3, d3, d14 //arr[i] * temp
FADD d15, d15, d3
MOV x7, 0 //reset J
ADD X2, X2, 1 //increment I
FMOV d14, 1.0 //resets temp
b loop1

isZero:
ADD X2, X2, 1 //increment i
ADD X3, X3, 1 //increment n
MOV X7, 0 //reset J
b loop1

endL1: 
LDUR X30, [SP, 0]
ADD SP, SP, 8
//necessary since I get an error when branching from loop1
BR x30

//for myself, a = d1, ay = d5, b = d2, by = d6
mainSolve:
FMOV d14, 2
FADD d8, d1, d2 // c = a + b
FDIV d8, d8, d14 //c = A + b / 2
LDR x3, [x20] //n
FMOV d4, d8 //moves c to solveY
bl solveY
FMOV d9, d15 //d9 is cy
FMUL d12, d9, d9 //square d9 to get abs value
FCMP d12, d16
BEQ exit
FMUL d26, d25, d25 //square Tao 
FCMP d12, d26 //if the y value is less than the tolerance we end
BLE exit
FMUL d10, d5, d9 //if a is bigger, do this
FCMP d10, d16
BGE bBigger
FMOV d2, d8 //b = c
FMOV d6, d9 //by = cy
//b exit
b mainSolve
bBigger:
FMOV d1, d8 //a = c
FMOV d5, d9 //ay = cy
//b exit
b mainSolve


exit: 
FMOV d0, d8
FMOV d1, d9
ADR X0, msg
bl printf
MOV X0, 0
MOV X8, 93
SVC 0


.data
coeff: .double 0.2, 3.1, -0.3, 1.9, 0.2
n: .dword 5
a: .double -1
b: .double 1
zero: .double 0.0
tolerance: .double 0.00001
msg: .ascii "Root is %lf, at y of %lf\n\0"
.end
