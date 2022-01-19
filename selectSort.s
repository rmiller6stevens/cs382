
.text
.global _start
.extern printf


_start:
ADR X21, arr
ADR x22, size
LDUR x1, [x22, 0] //size of the array
MOV x2, 0 //iterator

BL sSort
BL printLoop
MOV X0, 0
MOV X8, 93
SVC 0
	


//FOR MYSELF: x1 is the size of array, x21 has base address of the array
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

printLoop://called after array is sorted
//put back the size reference
MOV x22, x1
MOV x20, 0
pLoop:
LSL x10, x20, 3
LDR x1, [x21, x10]
ADR x0, str
BL printf
ADD X20, X20, 1
CMP x20, x22
BEQ exitpLoop //haha ploop
B pLoop
exitpLoop:
MOV X0, 0
MOV X8, 93
SVC 0
//since I coded this last only now do I realize I could have made all of my loops like this and avoided the annoying way I *did* do them

	
.data
arr: .dword 3,5,7,4,2,1
str: .ascii "%ld \n\0"
size: .dword 6
.end
