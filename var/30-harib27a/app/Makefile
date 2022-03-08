.PHONY: all
all:
	find ./ -type d -mindepth 1 | xargs -I{} sh -c "make -C {}"
.PHONY: src_only
src_only:
	find ./ -type d -mindepth 1 | xargs -I{} sh -c "make src_only -C {} 2>/dev/null || exit 0"
.PHONY: clean
clean: src_only
