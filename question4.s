.text
.global _start
.extern printf
_start:

ADR X2, cwid
MOV X4, #0 //iterator
MOV X5, #0 //total

Loop: LDR x3, [X2, X4] //loads at a new value every loop
ADD X4, X4, #8 //moves to the next value
ADD X5, X5, X3 //totals the sum
SUB X6, x4, #64
CMP X6, #0 //checks to end
BEQ Exit
BL Loop



//exits
Exit:
q1_func_end:
LDR X0, =msg
MOV X1, X5
BL printf
MOV X0, #0
MOV W8, #93
SVC #0


.data
cwid: .quad 1,0,4,5,8,4,2,3
msg: .ascii "Sum = %d\n\0"
.end
