.PHONY: run
run: helloos.img
	qemu-system-i386 -drive file=helloos.img,format=raw,if=floppy -boot a
helloos.img: ipl.nas
	nasm ipl.nas -o helloos.img -l ipl.list
clean:
	rm helloos.img
