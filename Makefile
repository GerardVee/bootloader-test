base = 0x7C00
objects = src/boot.o src/core.o src/set_mem.o
extra = a.out
boot: $(objects)
	@ld -T linker-scripts/link.ld
	@rm -f $(extra) $(objects)
src/boot.o: src/boot.S
	@as src/boot.S -c -o src/boot.o
src/core.o: src/core.S
	@as src/core.S -c -o src/core.o
src/set_mem.o: src/set_mem.S
	@as src/set_mem.S -c -o src/set_mem.o
clean:
	@rm -f $(extra) boot $(objects)
test: boot
	qemu-system-x86_64 -monitor stdio boot -m 2G
repeat: boot
	make clean
	make test
