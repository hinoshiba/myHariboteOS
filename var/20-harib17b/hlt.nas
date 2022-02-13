[BITS 32]
		MOV		AL,'A'
		CALL    0x47f4
fin:
		HLT
		JMP		fin
