.PHONY: run
run: helloos.img
	qemu-system-i386 -drive file=helloos.img,format=raw,if=floppy -boot a
helloos.img: helloos.nas
	nasm helloos.nas -o helloos.img
clean:
	rm helloos.img
