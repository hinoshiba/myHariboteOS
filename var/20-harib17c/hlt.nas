[BITS 32]
		MOV		AL,'A'
		CALL    2*8:0x47f4
fin:
		HLT
		JMP		fin
