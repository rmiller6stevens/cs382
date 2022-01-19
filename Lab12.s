//Robert Miller
//I pledge my honor that I have abided by the Stevens Honor System

.text
.global _start

_start:
//\n is 10
	adr x21, buf
    MOV x1, x21

    rLoop:
	MOV X2, 1 //num
	MOV x0, 0
	MOV x8, 63
	SVC 0

	LDRB w19, [x1] //loads
    //MOV w5, 10 for print purpose
	CMP w19, 10
	BEQ stored
   // MUL w20, w20, w5
    //SUB w19, w19, 48 //ascii value is 48 off
    //ADD w20, w20, w19
    ADD X1, x1, 1
	B rLoop
	
//63 is the read instruction, so it should take it in there

//another
    stored:
    ADR x21, buf
    MOV w20, 0 
    MOV w5, 10
    
    mLoop:
    LDRB w19, [x21]
    CMP w19, 10
    BEQ getDigits
    MUL w20, w20, w5
    SUB w19, w19, 48
    ADD w20, w20, w19
    //reference:
    //STURB w19, [x0]
    ADD X21, X21, 1
    //ADD X0, x0, 1
	B mLoop
    
    //64 is print
    getDigits:
    //square it here now
    MUL w20, w20, w20
    MOV x10, 10
    ADR x1, data
    MOV x16, 0 //number of digits
    MOV x15, x20
    CMP x20, XZR
    BEQ zero
    getDigitsL:
    CMP x15, 0
    BEQ intToString
    UDIV x15, x15, x10
    ADD x16, X16, 1
    b getDigitsL

    zero: //here for when 0 is inputted
    MOV x16, 1 //just so theres at least 1 digit, skips getDigits
    b intToString

    intToString:
    MOV x23, x20
    MOV w11, 10
    ADR x1, data
    ADD X17, X1, X16
    ADD X17, x17, 1
    STURB w11, [x17] //makes last element into 10 so the string will end
    intLoop:
    CMP x16, XZR
    BEQ print
    UDIV x22, X23, x10 //divide total by 10
    MSUB x24, x22, x10, x23 //X24 is the remainder
    UDIV X23, X23, x10 //x23 is now the quotient
    ADD w24, w24, 48 //convert to ascii
    ADD x17, x1, x16 //point in memory
    STURB w24, [x17]
    SUB X16, X16, 1
    b intLoop

    print:
    //square it here
    //MUL w20, w20, w20 //x^2
    //STURB w20, [x0, 0]
    //LDURB w19, [x20]
    //MOV x1, x20
    adr x21, data
    ADD X21, X21, 1
    //pLoop:
    LDRB w9, [x21]
    CMP w9, 10
    BEQ stop
    MOV x1, x21
    MOV X2, 8
    MOV X0, 1
    MOV X8, 64
    SVC 0
    ADD x21, x21, 1
    //b pLoop

    stop:
	MOV X0, 0
	MOV X8, 93
	SVC 0

    
.data
buf: .skip 100
data: .skip 100
.end
