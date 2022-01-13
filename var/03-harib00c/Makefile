.PHONY: run
run: helloos.img
	qemu-system-i386 -drive file=helloos.img,format=raw,if=floppy -boot a
ipl.bin: ipl.nas
	nasm ipl.nas -o ipl.bin -l ipl.list
helloos.img: ipl.bin
	mformat -f 1440 -C -B ipl.bin -i helloos.img
.PHONY: clean
clean:
	rm ipl.bin
	rm ipl.list
.PHONY: src_only
src_only: clean
	rm helloos.img
