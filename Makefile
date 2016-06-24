base = 0x7C00
objects = boot.o core.o set_mem.o
extra = a.out
boot: $(objects)
	@ld -T link.ld
	@rm -f $(extra) $(objects)
boot.o: boot.S
	@as boot.S -c -o boot.o
core.o: core.S
	@as core.S -c -o core.o
set_mem.o: set_mem.S
	@as set_mem.S -c -o set_mem.o
clean:
	@rm -f $(extra) boot $(objects)
test: boot
	qemu-system-x86_64 -monitor stdio boot -m 2G
