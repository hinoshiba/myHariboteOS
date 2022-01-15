.PHONY: run
run: haribote.img
	qemu-system-x86_64 -fda haribote.img
ipl.bin: ipl10.nas
	nasm ipl10.nas -o ipl.bin -l ipl10.list
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
