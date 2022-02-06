.PHONY: clean
clean:
	find ./ -type d -mindepth 1 | xargs -I{} sh -c "make clean -C {} 2>/dev/null || exit 0"
