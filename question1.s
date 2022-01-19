.text
.global _start
.extern printf
_start:

ADR X0, msg

ADR X12, g
LDUR X11, [X12, #0]

ADR X14, i
LDUR X13, [X14, #0]

SUB X13, X13, #4
CBNZ X13, Else

ADD X2, X11, #1
BL q1_func_end

Else: SUB X2, X11, #2

//exits program
q1_func_end:
LDR X0, =msg
MOV X1, X2
BL printf
MOV X0, #0
MOV W8, #93
SVC #0

.data
i: .quad 4
g: .quad 3
msg: .ascii "f = %d\n\0"
.end
