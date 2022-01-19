
.text
.global _start
.extern printf
//Robert Miller
//I pledge my honor that I have abided by the Stevens Honor System.

_start:
LDR X0, len
ADR X19, arr
BL findMax
LDR X0, =msg
BL printf
BL Exit

findMax:
SUB SP, SP, 16
STUR X30, [SP, 8]
STUR X0, [SP, 0]
CMP X0, 1
B.GT Cont
//base case
LDUR X1, [x19, 0]

ADD SP, SP, 16
BR X30

Cont:
SUB X0, X0, 1
BL findMax
LDR x0, [SP, 0]
LDR X30, [SP, 8]
ADD SP, SP, 16
SUB X0, X0, 1
LSL X4, X0, 3
LDR x2, [x19, X4]
CMP x2, x1
//swap if bigger
B.GT newMax
BR X30

newMax:
MOV X1, X2
BR X30


//ends here
Exit:
	MOV X0, 0
	MOV X8, 93
	SVC 0
.data
len: .quad 6
arr: .dword 23,3,5,50,9,100
msg: .ascii "Max is %ld\n\0"

