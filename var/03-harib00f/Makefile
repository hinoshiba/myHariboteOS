.PHONY: run
run: haribote.img
	qemu-system-i386 -drive file=haribote.img,format=raw,if=floppy -boot a
ipl.bin: ipl.nas
	nasm ipl.nas -o ipl.bin -l ipl.list
haribote.sys: haribote.nas
	nasm haribote.nas -l haribote.list -o haribote.sys
haribote.img: ipl.bin haribote.sys
	mformat -f 1440 -C -B ipl.bin -i haribote.img ::
	mcopy -i haribote.img haribote.sys ::
.PHONY: clean
clean:
	rm *.bin
	rm *.sys
	rm *.list
.PHONY: src_only
src_only: clean
	rm haribote.img
