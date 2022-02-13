SRC=bootpack.c graphic.c dsctbl.c hankaku.c int.c mysprint.c fifo.c keyboard.c mouse.c memory.c sheet.c timer.c mtask.c mystrcmp.c window.c console.c file.c

.PHONY: run
run: haribote.img
	qemu-system-x86_64 -m 32M -fda haribote.img
ipl.bin: ipl10.nas
	nasm ipl10.nas -o ipl.bin -l ipl10.list
asmhead.bin: asmhead.nas
	nasm asmhead.nas -l asmhead.list -o asmhead.bin
naskfunc.o: naskfunc.nas
	nasm -g -f elf naskfunc.nas -o naskfunc.o -l naskfunc.list
hankaku.c: hankaku.txt convHankakuTxt.c
	gcc convHankakuTxt.c -o convHankakuTxt.bin
	./convHankakuTxt.bin
bootpack.bim: $(SRC) naskfunc.o
	i386-elf-gcc -march=i486 -m32 -T hrb.ld -g $(SRC) naskfunc.o -o bootpack.bim -nostdlib -Xlinker -Map=bootpack.map
haribote.sys: asmhead.bin bootpack.bim
	cat asmhead.bin bootpack.bim > haribote.sys
hlt.hrb: hlt.nas
	nasm hlt.nas -l hlt.list -o hlt.hrb
haribote.img: ipl.bin haribote.sys hlt.hrb
	mformat -f 1440 -C -B ipl.bin -i haribote.img ::
	mcopy -i haribote.img haribote.sys ::
	mcopy -i haribote.img Makefile ::
	mcopy -i haribote.img ipl10.nas ::
	mcopy -i haribote.img hlt.hrb ::
.PHONY: clean
clean:
	rm *.bin || exit 0
	rm *.bim || exit 0
	rm *.hrb || exit 0
	rm *.sys || exit 0
	rm *.list || exit 0
	rm *.o || exit 0
	rm hankaku.c
.PHONY: src_only
src_only: clean
	rm haribote.img || exit 0
