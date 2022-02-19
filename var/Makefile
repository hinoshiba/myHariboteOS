.PHONY: clean
clean:
	find ./ -type d -mindepth 1 | xargs -I{} sh -c "make src_only -C {} 2>/dev/null || exit 0"
