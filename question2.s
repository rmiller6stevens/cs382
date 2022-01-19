.text
.global _start
.extern printf
_start:

ADR X0, msg

ADR X12, a
LDUR X11, [X12, #0]

ADR X14, b
LDUR X13, [X14, #0]

ADD X9, X11, X13
SUB X9, X9, #14
CBNZ X9, Else
ADD X11, XZR, XZR
ADD X11, X11, #3
B Exit


Else: ADD X11, XZR, XZR
SUB X11, X11, #2

Exit:
q1_func_end:
LDR X0, =msg
MOV X1, X11
BL printf
MOV X0, #0
MOV W8, #93
SVC #0


.data
a: .quad 3
b: .quad 7
msg: .ascii "c = %d\n\0"
.end
