TARGET=$(shell find ./ -type f -mindepth 2)

.PHONY: run
run: haribote.img
	qemu-system-x86_64 -m 32M -fda haribote.img
haribote.img: $(TARGET)
	make -C haribote
	make -C apilib
	make -C app
	ln -s -f haribote/haribote.img ./
	mcopy -i haribote.img `find ./ -type f -name "*.hrb"` ::
	mcopy -i haribote.img nihongo/nihongo.fnt ::
	mcopy -i haribote.img euc.txt ::
	mcopy -i haribote.img `find ./mmldata -type f -name "*.mml"` ::
.PHONY: clean
clean:
	find ./ -type f -name "Makefile" -mindepth 2 | xargs -I{} sh -c 'make -C `dirname {}` clean'
.PHONY: src_only
src_only:
	rm haribote.img || exit 0
	find ./ -type f -name "Makefile" -mindepth 2 | xargs -I{} sh -c 'make -C `dirname {}` src_only'
