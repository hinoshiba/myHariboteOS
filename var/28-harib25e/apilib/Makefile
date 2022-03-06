OBJS_API=api001.obj api002.obj api003.obj api004.obj api005.obj api006.obj api007.obj api008.obj api009.obj api010.obj api011.obj api012.obj api013.obj api014.obj api015.obj api016.obj api017.obj api018.obj api019.obj api020.obj api021.obj api022.obj api023.obj api024.obj api025.obj alloca.obj api026.obj

.PHONY: all
all: apilib.lib
apilib.lib: $(OBJS_API)
	i386-elf-ar rcs $@ $^
$(OBJS_API): %.obj: %.nas
	nasm -g -f elf $< -o $@
.PHONY: clean
clean:
	rm *.obj || exit 0
	rm *.lib || exit 0
.PHONY: src_only
src_only: clean
