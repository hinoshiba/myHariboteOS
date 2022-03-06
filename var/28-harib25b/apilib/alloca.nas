;[FORMAT "WCOFF"]
;[INSTRSET "i486p"]
[BITS 32]
;[FILE "alloca.nas"]

		GLOBAL	_alloca

[SECTION .text]

_alloca:
		ADD		EAX,-4
		SUB		ESP,EAX
		JMP		DWORD [ESP+EAX]		; RETの代わり
