.PHONY: run
run: haribote.img
	qemu-system-x86_64 -fda haribote.img
ipl.bin: ipl10.nas
	nasm ipl10.nas -o ipl.bin -l ipl10.list
asmhead.bin: asmhead.nas
	nasm asmhead.nas -l asmhead.list -o asmhead.bin
naskfunc.o:
	nasm -g -f elf naskfunc.nas -o naskfunc.o -l naskfunc.list
bootpack.hrb: bootpack.c naskfunc.o
	i386-elf-gcc -march=i486 -m32 -T hrb.ld -g bootpack.c naskfunc.o -o bootpack.hrb -nostdlib
haribote.sys: asmhead.bin bootpack.hrb
	cat asmhead.bin bootpack.hrb > haribote.sys
haribote.img: ipl.bin haribote.sys
	mformat -f 1440 -C -B ipl.bin -i haribote.img ::
	mcopy -i haribote.img haribote.sys ::
.PHONY: clean
clean:
	rm *.bin
	rm *.hrb
	rm *.sys
	rm *.list
	rm *.o
.PHONY: src_only
src_only: clean
	rm haribote.img
