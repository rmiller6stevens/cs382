
.text
.global _start
.extern printf
.extern scanf


_start:
ADR X21, arr
ADR x22, size
LDUR x1, [x22, 0] //size of the array
MOV x2, 0 //iterator
//select works, so no changes need to be made besides removing print loop
BL sSort
SUB SP, SP, 8
ADR x0, query
MOV X1, SP
BL scanf
LDR X1, [SP]
ADD SP, SP, 8
ADR x24, query
STUR x1, [x24, 0]//put the query in query
//x1 is now the query
MOV x4, x1
//now after it has been sorted, I can repurpose the registers from before
BL bSearch


//coding starts here

bSearch: //for me, x3 is the iterator, x4 is the query
LDR x10, [x22] //x1 is the size again
SUB x10, x10, 1
MOV x6,  0//low
MOV x3, x10 //high
sLoop:
CMP X6, X3
BGT endSearch
ADD x5, x3, x6 //mid
LSR x5, x5, 1
LSL x8, x5, 3
LDR x7, [x21, x8]
CMP x4, x7
BEQ found
BLT less
B more
less:
SUB x3, x5, 1
B sLoop
more:
ADD x6, x5, 1
b sLoop

endSearch:
ADR x0, strNotFound
BL printf
B endPr
found:
ADR x0, strFound
MOV x1, x5
BL printf
endPr:
MOV X0, 0
MOV X8, 93
SVC 0



sSort:
SUB SP, SP, 8
STUR X30, [SP, 0]
LSL X6, x1, 3 //final element in array
sortLoop: 
CMP x2, x1
BEQ exit
LSL X3, X2, 3
LDR X4, [X21, X3] //value that will be swapped with the min
ADD x7, x21, x3 //address of element being tested
BL min //will make x7 the address of the min
LSL X3, X2, 3 //resets x3 after min is called #spaghetti code lol
BL swap
ADD x2, X2, 1
B sortLoop
exit:
LDUR X30, [SP, 0]
ADD SP, SP, 8
BR X30


swap: //x7 has new address of min
LDUR x8, [x7,0] //new min
LDR x9, [x21, x3]
STUR x9, [x7, 0]
STR x8, [x21, x3]
BR x30

min:
CMP X3, X6
BEQ exitMin
LDR x4, [x7, 0]
ADD x3, x3, 8
LDR x5, [x21, x3] //value of i + 1 in iterator
CMP X5, X4
BLT newMin
B min
newMin:
ADD x7, x21, x3
B min
exitMin:
BR x30

.data
query: .string "%ld"
str: .ascii "%ld\n\0"
arr: .dword 6,4,2,3,1,5
strFound: .ascii "Found query at index of %ld\n\0"
strNotFound: .ascii "Did not find query \n\0"
size: .dword 6
.end

