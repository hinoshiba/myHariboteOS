//http://bttb.s1.valueserver.jp/wordpress/blog/2017/12/17/makeos-5-2/
#include <stdarg.h>
#include <stddef.h>
//#include "bootpack.h"

//10進数からASCIIコードに変換
int dec2asc (char *str, int dec) {
    int len = 0, len_buf; //桁数
    int buf[10];
    while (1) { //10で割れた回数（つまり桁数）をlenに、各桁をbufに格納
        buf[len++] = dec % 10;
        if (dec < 10) break;
        dec /= 10;
    }
    len_buf = len;
    while (len) {
        *(str++) = buf[--len] + 0x30;
    }
    return len_buf;
}
 
//16進数からASCIIコードに変換
int hex2asc (char *str, int dec) { //10で割れた回数（つまり桁数）をlenに、各桁をbufに格納
    int len = 0, len_buf; //桁数
    int buf[10];
    while (1) {
        buf[len++] = dec % 16;
        if (dec < 16) break;
        dec /= 16;
    }
    len_buf = len;
    while (len) {
        len --;
        *(str++) = (buf[len]<10)?(buf[len] + 0x30):(buf[len] - 9 + 0x60);
    }
    return len_buf;
}
 
void sprintf (char *str, char *fmt, ...) {
    va_list list;
    int i, len;
    //va_start (list, 2);
    va_start (list, fmt);
 
    while (*fmt) {
        if(*fmt=='%') {
recheck:
            fmt++;
            switch(*fmt){
				case '0': // ignore format e.g. %010d
				case '1':
				case '2':
				case '3':
				case '4':
				case '5':
				case '6':
				case '7':
				case '8':
				case '9':
					goto recheck;
                case 'd':
                    len = dec2asc(str, va_arg (list, int));
                    break;
                case 'X':
                case 'x':
                    len = hex2asc(str, va_arg (list, int));
                    break;
            }
            str += len; fmt++;
        } else {
            *(str++) = *(fmt++);
        }   
    }
    *str = 0x00; //最後にNULLを追加
    va_end (list);
}

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

// HariboteOS_source/omake/tolsrc/go_0023s/golibc/memcmp.c
int memcmp (const void *d, const void *s, size_t sz) {
	const char *dp = (const char*) d;
	const char *sp = (const char*) s;
	while (sz--) {
		if (*dp != *sp)
			return *dp - *sp;
		dp++;
		sp++;
	}
	return 0;
}
// https://opensource.apple.com/source/Libc/Libc-167/gen.subproj/i386.subproj/strlen.c.auto.html
size_t strlen(char *str) {
	char *s;
	for (s = str; *s; ++s);
	return (s - str);
}
