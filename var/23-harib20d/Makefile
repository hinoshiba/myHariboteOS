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
hello.hrb: hello.nas
	nasm hello.nas -l hello.list -o hello.hrb
hello2.hrb: hello2.nas
	nasm hello2.nas -l hello2.list -o hello2.hrb
a_nask.o: a_nask.nas
	nasm -g -f elf a_nask.nas -o a_nask.o -l a_nask.list
hello3.hrb: hello3.c a_nask.o
	i386-elf-gcc -march=i486 -m32 -T app.ld -g a_nask.o hello3.c -o hello3.hrb -nostdlib
hello4.hrb: hello4.c a_nask.o
	i386-elf-gcc -march=i486 -m32 -T app.ld -g a_nask.o hello4.c -o hello4.hrb -nostdlib
hello5.hrb: hello5.nas
	nasm hello5.nas -l hello5.list -o hello5.hrb
winhelo.hrb: winhelo.c a_nask.o
	i386-elf-gcc -march=i486 -m32 -T app.ld -g a_nask.o winhelo.c -o winhelo.hrb -nostdlib
winhelo2.hrb: winhelo2.c a_nask.o
	i386-elf-gcc -march=i486 -m32 -T app.ld -g a_nask.o winhelo2.c -o winhelo2.hrb -nostdlib
winhelo3.hrb: winhelo3.c a_nask.o
	i386-elf-gcc -march=i486 -m32 -T app.ld -g a_nask.o winhelo3.c -o winhelo3.hrb -nostdlib
star1.hrb: star1.c a_nask.o
	i386-elf-gcc -march=i486 -m32 -T app.ld -g a_nask.o star1.c -o star1.hrb -nostdlib
stars.hrb: stars.c a_nask.o
	i386-elf-gcc -march=i486 -m32 -T app.ld -g a_nask.o stars.c -o stars.hrb -nostdlib
stars2.hrb: stars2.c a_nask.o
	i386-elf-gcc -march=i486 -m32 -T app.ld -g a_nask.o stars2.c -o stars2.hrb -nostdlib
lines.hrb: lines.c a_nask.o
	i386-elf-gcc -march=i486 -m32 -T app.ld -g a_nask.o lines.c -o lines.hrb -nostdlib
haribote.img: ipl.bin haribote.sys hello.hrb hello2.hrb hello3.hrb hello4.hrb hello5.hrb winhelo.hrb winhelo2.hrb winhelo3.hrb star1.hrb stars.hrb stars2.hrb lines.hrb
	mformat -f 1440 -C -B ipl.bin -i haribote.img ::
	mcopy -i haribote.img haribote.sys ::
	mcopy -i haribote.img Makefile ::
	mcopy -i haribote.img ipl10.nas ::
	mcopy -i haribote.img hello.hrb ::
	mcopy -i haribote.img hello2.hrb ::
	mcopy -i haribote.img hello3.hrb ::
	mcopy -i haribote.img hello4.hrb ::
	mcopy -i haribote.img hello5.hrb ::
	mcopy -i haribote.img winhelo.hrb ::
	mcopy -i haribote.img winhelo2.hrb ::
	mcopy -i haribote.img winhelo3.hrb ::
	mcopy -i haribote.img star1.hrb ::
	mcopy -i haribote.img stars.hrb ::
	mcopy -i haribote.img stars2.hrb ::
	mcopy -i haribote.img lines.hrb ::
.PHONY: clean
clean:
	rm *.map || exit 0
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
