.code16
.intel_syntax noprefix
.text
.globl _start
.extern core
_start:
	jmp start	
string:
	.ascii "Good Boot"
start:
	lea di, string
	lea cx, start
	mov ah, 0x0E
	mov bh, 0x00
	mov bl, 0x07
loop:
	mov dx, [di]
	mov al, dl
	int 0x10
	add di, 1
	cmp di, cx
	jne loop
	jmp core
.data
	.short 0xAA55 
