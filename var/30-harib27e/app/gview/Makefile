APP      = gview
STACK    = 0x4480000

APPLIBPATH=../../apilib/
LD=../app.ld

LOCAL_LIB=../../haribote/myfunc.c

$(APP).hrb:

gview.hrb: gview.c jpeg.c bmp.o
	i386-elf-gcc -march=i486 -m32 -T $(LD) gview.c jpeg.c bmp.o $(APPLIBPATH)/apilib.lib -Wl,'--defsym=__stack=$(STACK)' $(LOCAL_LIB) -o gview.hrb -nostdlib
bmp.o: bmp.nasm
	nasm -g -f elf bmp.nasm -o bmp.o -l bmp.list

.PHONY: clean
clean:
	rm *.hrb || exit 0
	rm *.sys || exit 0
	rm *.list || exit 0
	rm *.o || exit 0
	rm *.obj || exit 0
	rm *.lib || exit 0
.PHONY: src_only
src_only: clean
