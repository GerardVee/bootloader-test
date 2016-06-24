.code16
.intel_syntax noprefix
.text
.globl set_mem
error_string:
	.byte 0xA
	.ascii "\rBad memory map -- ending boot"
good_string:
	.byte 0xA
	.ascii "\rGood memory map -- proceeding boot"
bad:
        lea di, error_string
        lea cx, good_string
starting:
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
	lea di, end_mem
        jmp ag

set_mem:
	mov es, [zero]
	lea di, error
	mov bl, es:[di]
	jz good
	jmp bad
good:
	lea di, good_string
	lea cx, bad
	jmp starting 
ag:
	jmp ag	
