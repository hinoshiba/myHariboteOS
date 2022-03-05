SRC=bootpack.c graphic.c dsctbl.c hankaku.c int.c mysprint.c fifo.c keyboard.c mouse.c memory.c sheet.c timer.c mtask.c mystrcmp.c window.c console.c file.c
OBJS_API=api001.obj api002.obj api003.obj api004.obj api005.obj api006.obj api007.obj api008.obj api009.obj api010.obj api011.obj api012.obj api013.obj api014.obj api015.obj api016.obj api017.obj api018.obj api019.obj api020.obj
APP_NASM=hello.hrb hello2.hrb hello5.hrb crack7.hrb
APP=hello3.hrb hello4.hrb winhelo.hrb winhelo2.hrb winhelo3.hrb star1.hrb stars.hrb stars2.hrb lines.hrb walk.hrb beepdown.hrb beepup.hrb
APP_BIG=noodle.hrb color.hrb color2.hrb

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
apilib.lib: $(OBJS_API)
	i386-elf-ar rcs $@ $^
$(OBJS_API): %.obj: %.nas
	nasm -g -f elf $< -o $@
$(APP_NASM): %.hrb: %.nas
	nasm $< -o $@
$(APP): %.hrb: %.c apilib.lib
	i386-elf-gcc -march=i486 -m32 -T app.ld $< apilib.lib -o $@ -nostdlib
$(APP_BIG): %.hrb: %.c apilib.lib
	i386-elf-gcc -march=i486 -m32 -T app4.ld $< apilib.lib mysprint.c -o $@ -nostdlib
haribote.img: ipl.bin haribote.sys $(APP_NASM) $(APP) $(APP_BIG)
	mformat -f 1440 -C -B ipl.bin -i haribote.img ::
	mcopy -i haribote.img haribote.sys ::
	mcopy -i haribote.img Makefile ::
	mcopy -i haribote.img $(APP_NASM) ::
	mcopy -i haribote.img $(APP) ::
	mcopy -i haribote.img $(APP_BIG) ::
.PHONY: clean
clean:
	rm *.map || exit 0
	rm *.bin || exit 0
	rm *.bim || exit 0
	rm *.hrb || exit 0
	rm *.sys || exit 0
	rm *.list || exit 0
	rm *.o || exit 0
	rm *.obj || exit 0
	rm *.lib || exit 0
	rm hankaku.c
.PHONY: src_only
src_only: clean
	rm haribote.img || exit 0
