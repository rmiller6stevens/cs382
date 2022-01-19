.text
.global _start
.extern printf
_start:

ADR X0, msg
MOV X12, #1
MOV X13, #1
MOv x15, #0
Loop: SUB X14, X13, #10
CMP X14, #0
BEQ Exit
ADD X13, X13, #1
ADD X15, X13, #0
ADD X12, X12, X15
BL Loop

//exits
Exit:
q1_func_end:
LDR X0, =msg
MOV X1, X12
BL printf
MOV X0, #0
MOV W8, #93
SVC #0


.data
msg: .ascii "Sum = %d\n\0"
.end
