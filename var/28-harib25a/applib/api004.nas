;[FORMAT "WCOFF"]
;[INSTRSET "i486p"]
[BITS 32]
;[FILE "api004.nas"]

		GLOBAL	api_end

[SECTION .text]

api_end:	; void api_end(void);
		MOV		EDX,4
		INT		0x40
