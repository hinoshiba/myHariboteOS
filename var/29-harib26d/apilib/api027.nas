;[FORMAT "WCOFF"]
;[INSTRSET "i486p"]
[BITS 32]
;[FILE "api027.nas"]

		GLOBAL	api_getlang

[SECTION .text]

api_getlang:		; int api_getlang(void);
		MOV		EDX,27
		INT		0x40
		RET
