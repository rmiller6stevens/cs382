//Robert Miller
//I pledge my honor that I have abided by the Stevens Honor System
.text
.global _start
.extern printf

_start:
    adr x20, N
    ldr x21, [x20, 0] //x21 is the length of the array
	mov x8,  -1  //iterator for x
	mov	x9,  0	 //iterator for j
	adr	x0, max
	ldur d10, [x0]
	fmov d9, d10  	//loads 0 into d9
	adr x0, x
	adr	x2, y
	mov	x3, 0
	mov	x4, 1
    mov x22, 0
    mov x23, 1
    //must set a min before it starts
    lsl x20, x9, 3
    ldr d1, [x0, x20]
    ldr d2, [x2, x20]
    add x20, x20, 8
    ldr d3, [x0, x20]
    ldr d4, [x2, x20]
    fsub d1, d1, d3
    fMUL d1, d1, d1
    fsub d2, d2, d4
    fMUL d2, d2, d2
    fADD d1, d1, d2
    fMOV d20, d1 //makes min the sum of the first x and y value ^2
	b outer

outer:
add x8, x8, 1 //first go around makes it 0 first, no worries
MOV x9, 0 //resets 9
cmp x8, x21
beq exit
b inner

inner:
//This is for i
	lsl	x10, x8, 3 //multiplies iterator by 8
	ldr	d10, [x0, x10] //xi
	ldr	d11, [x2, x10] //yi
	
//This is for J
	lsl	x10, x9, 3
	ldr	d12, [x0, x10] //xj
	ldr	d13, [x2, x10] //yj
	cmp	x9, x21
	bge	outer
	b 	distance

innerindex:
	add	x9, x9, #1
	b 	inner


distance:
	fsub	d10, d10, d12 //xi - xj
	fmul	d10, d10, d10
	fsub	d11, d11, d13
	fmul	d11, d11, d11
	fadd 	d11, d10, d11
	fcmp	d11, d9
	bge	updatemax
    fcmp d11, d20
    ble updatemin
	b	innerindex

updatemin:
    cmp x9, x8
    beq innerindex
    fmov d20, d11
    mov x22, x8 //index of i at min
    mov x23, x9 //index of j at min
    b innerindex

updatemax:
	fmov d9, d11
	mov	x3, x8 //index of i at max
	mov	x4, x9 //index of j at max
	b	innerindex

	
exit:
	ldr x0, =printarr
	mov	x1, x3 //moving max x to x1
	mov	x2, x4 //moving max y to x2
	bl printf

    ldr x0, =printarrMin
    mov x1, x22
    mov x2, x23
    bl printf

	mov x0, 0
	mov x8, 93
	svc 0
	
.data
N:
.dword 7
max: 
	.double 0.0
x:
	.double 0.0, 0.4140, 1.4949, 5.0014, 6.5163, 3.9303, 8.4813, 2.6505
y:
	.double 0.0, 3.9862, 6.1488, 1.047, 4.6102, 1.4057, 5.0371, 4.1196
printarr:
	.ascii "Largest distance is from x index : %ld and %ld\n\0"
printarrMin:
	.ascii "Shortest distance is from x index : %ld and %ld\n\0"

.end
