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

int errno = 0;
#define ERANGE 34

#include <stdbool.h>
#include <limits.h>
bool ISSPACE(int c) {
  return (c == ' ') || (c == '\n') || (c == '\t') ||
         (c == '\f') || (c == '\r') || (c == '\v');
}
bool ISDIGIT(int c) {
  return (c >= '0') && (c <= '9');
}
bool ISALPHA(int c) {
	return (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z');
}
bool ISUPPER(int c) {
	return (c >= 'A' && c <= 'Z');
}

//https://code.woboq.org/gcc/libiberty/strtol.c.html
long strtol(const char *nptr, char **endptr, register int base) {
	register const char *s = nptr;
	register unsigned long acc;
	register int c;
	register unsigned long cutoff;
	register int neg = 0, any, cutlim;
	/*
	 * Skip white space and pick up leading +/- sign if any.
	 * If base is 0, allow 0x for hex and 0 for octal, else
	 * assume decimal; if base is already 16, allow 0x.
	 */
	do {
		c = *s++;
	} while (ISSPACE(c));
	if (c == '-') {
		neg = 1;
		c = *s++;
	} else if (c == '+')
		c = *s++;
	if ((base == 0 || base == 16) && c == '0' && (*s == 'x' || *s == 'X')) {
		c = s[1];
		s += 2;
		base = 16;
	}
	if (base == 0) base = c == '0' ? 8 : 10;
	/*
	 * Compute the cutoff value between legal numbers and illegal
	 * numbers.  That is the largest legal value, divided by the
	 * base.  An input number that is greater than this value, if
	 * followed by a legal input character, is too big.  One that
	 * is equal to this value may be valid or not; the limit
	 * between valid and invalid numbers is then based on the last
	 * digit.  For instance, if the range for longs is
	 * [-2147483648..2147483647] and the input base is 10,
	 * cutoff will be set to 214748364 and cutlim to either
	 * 7 (neg==0) or 8 (neg==1), meaning that if we have accumulated
	 * a value > 214748364, or equal but the next digit is > 7 (or 8),
	 * the number is too big, and we will return a range error.
	 *
	 * Set any if any `digits' consumed; make it negative to indicate
	 * overflow.
	 */
	cutoff = neg ? -(unsigned long)LONG_MIN : LONG_MAX;
	cutlim = cutoff % (unsigned long)base;
	cutoff /= (unsigned long)base;
	for (acc = 0, any = 0;; c = *s++) {
		if (ISDIGIT(c))
			c -= '0';
		else if (ISALPHA(c))
			c -= ISUPPER(c) ? 'A' - 10 : 'a' - 10;
		else
			break;
		if (c >= base)
			break;
		if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim))
			any = -1;
		else {
			any = 1;
			acc *= base;
			acc += c;
		}
	}
	if (any < 0) {
		acc = neg ? LONG_MIN : LONG_MAX;
		errno = ERANGE;
	} else if (neg)
		acc = -acc;
	if (endptr != 0)
		*endptr = (char *) (any ? s - 1 : nptr);
	return (acc);
}
