.code16
.intel_syntax noprefix
.text 
.globl core
.globl error
.globl base_mem
.globl end_mem
.globl zero
.extern set_mem
.set SMAP, 0x0534D4150
.set MAGIC, 0xe820
.set END_CHECK, 0xC5E7503
.set BEST_AREA, 0x500 #usually unused until 0x7BFF
zero:
	.short 0
error:
	.byte 0 #SMAP failed byte
base_mem:
	.short 0x500
end_mem:
	.short 0
smap_failed: 
	mov es, [zero]
	lea di, error
	mov es:[di], byte ptr 1
	jmp end
core:
	xor ebx, ebx
	mov edx, SMAP
	xor bp, bp
	mov eax, MAGIC
	mov es, [zero]
	mov di, BEST_AREA
	mov bp, di
	mov ecx, 20 # 24 # ask for 24 bytes #we only want the necessary 20 bytes rn
	int 0x15
	xor eax, eax
	mov al, cl
	jmp repeat
	jc smap_failed
repeat:
	add di, 20 
	mov es, [zero]
	mov eax, MAGIC
	mov ecx, 20 
	int 0x15
	jc smap_failed
	cmp ebx, 0
	je end
	jmp repeat
end:
	mov es:[di], dword ptr END_CHECK #our checksum
	mov ax, di
	lea di, end_mem
	mov es:[di], ax
	jmp set_mem
/*table: #error was we needed MORE room for table. it was overwriting @set_mem
	.fill 180, 1, 0
*/

