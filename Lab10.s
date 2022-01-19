//Robert Miller
//I pledge my honor that I have abided by the Stevens Honor System
.text
.global _start
.extern printf


_start:
ADR x1, a //starting iterator
LDUR d1, [x1, 0]
ADR x1, b //ending number 
LDUR d2, [x1, 0]
ADR x1, n
LDUR d3, [x1, 0]
ADR x1, delta
LDUR d6, [x1, 0]
FMOV d5, XZR
intLoop:
FCMP d1, d2
BGE over
//I will be using d5 to get the number to add to the total
FMOV d18, 2.5
FMOV d19, 15.5
FMOV d20, 20.0
FMOV d21, 15.0
FMUL d18, d18, d1
FMUL d18, d18, d1
FMUL d18, d18, d1 //2.5x^3

FMUL d19, d19, d1
FMUL d19, d19, d1 //15.5x^2

FMUL d20, d20, d1 //20x

FADD d4, d21, d20
FADD d4, d18, d4
FSUB d4, d4, d19

FADD d5, d4, d5
FADD d1, d1, d6
b intLoop

over:
//ends program
FMUL d5, d5, d6
FMOV d24, d5
ADR x0, value
FMOV d0, d5
BL printf

ADR x0, diff
ADR x1, actual
LDUR d20, [x1, 0]
FSUB d0, d24, d20
BL printf
MOV X0, 0
MOV X8, 93
SVC 0

.data
a: .double -0.5
b: .double 5.0
delta: .double 0.0001 //delta is equal to the total width over the number of boxes, in this case 5.5 /5500 =.001 It is this so that it is within .001 of the regular value
n: .double 55000 //completely irrelevant
actual: .double 74.107
value: .ascii "Approx Sum: %lf\nActual Sum is 74.107\n\0"
diff: .ascii "Difference: %lf\n\0"
bss: .double 
result: .skip 8
.end
