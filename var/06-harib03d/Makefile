.PHONY: run
run: haribote.img
	qemu-system-x86_64 -fda haribote.img
ipl.bin: ipl10.nas
	nasm ipl10.nas -o ipl.bin -l ipl10.list
asmhead.bin: asmhead.nas
	nasm asmhead.nas -l asmhead.list -o asmhead.bin
naskfunc.o: naskfunc.nas
	nasm -g -f elf naskfunc.nas -o naskfunc.o -l naskfunc.list
hankaku.c: hankaku.txt convHankakuTxt.c
	gcc convHankakuTxt.c -o convHankakuTxt.bin
	./convHankakuTxt.bin
bootpack.bim: bootpack.c naskfunc.o hankaku.c mysprint.c graphic.c dsctbl.c int.c
	i386-elf-gcc -march=i486 -m32 -T hrb.ld -g bootpack.c graphic.c dsctbl.c hankaku.c int.c mysprint.c naskfunc.o -o bootpack.bim -nostdlib
haribote.sys: asmhead.bin bootpack.bim
	cat asmhead.bin bootpack.bim > haribote.sys
haribote.img: ipl.bin haribote.sys
	mformat -f 1440 -C -B ipl.bin -i haribote.img ::
	mcopy -i haribote.img haribote.sys ::
.PHONY: clean
clean:
	rm *.bin || exit 0
	rm *.hrb || exit 0
	rm *.sys || exit 0
	rm *.list || exit 0
	rm *.o || exit 0
	rm hankaku.c
.PHONY: src_only
src_only: clean
	rm haribote.img || exit 0
