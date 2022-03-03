int strcmp (char *s1, char *s2) {
	int cnt;

	for (cnt = 0; *(s1 + cnt) == *(s2 + cnt); cnt++) {
		if (*(s1 + cnt) == '\0') {
			return 0;
		}
	}

	return 1;
}

int strncmp (char *s1, char *s2, int max) {
	int cnt;

	for (cnt = 0; *(s1 + cnt) == *(s2 + cnt); cnt++) {
		if (cnt + 1 >= max) {
			return 0;
		}
		if (*(s1 + cnt) == '\0') {
			return 0;
		}
	}

	return 1;
}
