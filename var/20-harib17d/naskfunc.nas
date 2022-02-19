; naskfunc
; TAB=4

;[FORMAT "WCOFF"]				; オブジェクトファイルを作るモード	
;[INSTRSET "i486p"]				; 486の命令まで使いたいという記述
[BITS 32]						; 32ビットモード用の機械語を作らせる
;[FILE "naskfunc.nas"]			; ソースファイル名情報

		;GLOBAL	_io_hlt, _io_cli, _io_sti, _io_stihlt
		GLOBAL	io_hlt, io_cli, io_sti, io_stihlt
		;GLOBAL	_io_in8,  _io_in16,  _io_in32
		GLOBAL	io_in8,  io_in16,  io_in32
		;GLOBAL	_io_out8,  _io_out16,  _io_out32
		GLOBAL	io_out8,  io_out16,  io_out32
		;GLOBAL	_io_load_eflags, _io_store_eflags
		GLOBAL	io_load_eflags, io_store_eflags
		;GLOBAL	_load_gdtr, _load_idtr
		GLOBAL	load_gdtr, load_idtr
		;GLOBAL	_load_cr0, _store_cr0
		GLOBAL	load_cr0, store_cr0
		;GLOBAL	_load_tr
		GLOBAL	load_tr
		;GLOBAL	_asm_inthandler20, _asm_inthandler21, _asm_inthandler27, _asm_inthandler2c
		GLOBAL	asm_inthandler20, asm_inthandler21, asm_inthandler27, asm_inthandler2c
		;GLOBAL	_memtest_sub
		GLOBAL	memtest_sub
		;GLOBAL	_farjmp, _farcall
		GLOBAL	farjmp, farcall
		;GLOBAL	_asm_cons_putchar
		GLOBAL	asm_cons_putchar
		;EXTERN	_inthandler20, _inthandler21, _inthandler27, _inthandler2c
		EXTERN	inthandler20, inthandler21, inthandler27, inthandler2c
		;EXTERN	_cons_putchar
		EXTERN	cons_putchar

[SECTION .text]

;_io_hlt:	; void io_hlt(void);
io_hlt:	; void io_hlt(void);
		HLT
		RET

;_io_cli:	; void io_cli(void);
io_cli:	; void io_cli(void);
		CLI
		RET

;_io_sti:	; void io_sti(void);
io_sti:	; void io_sti(void);
		STI
		RET

;_io_stihlt:	; void io_stihlt(void);
io_stihlt:	; void io_stihlt(void);
		STI
		HLT
		RET

;_io_in8:	; int io_in8(int port);
io_in8:	; int io_in8(int port);
		MOV		EDX,[ESP+4]		; port
		MOV		EAX,0
		IN		AL,DX
		RET

;_io_in16:	; int io_in16(int port);
io_in16:	; int io_in16(int port);
		MOV		EDX,[ESP+4]		; port
		MOV		EAX,0
		IN		AX,DX
		RET

;_io_in32:	; int io_in32(int port);
io_in32:	; int io_in32(int port);
		MOV		EDX,[ESP+4]		; port
		IN		EAX,DX
		RET

;_io_out8:	; void io_out8(int port, int data);
io_out8:	; void io_out8(int port, int data);
		MOV		EDX,[ESP+4]		; port
		MOV		AL,[ESP+8]		; data
		OUT		DX,AL
		RET

;_io_out16:	; void io_out16(int port, int data);
io_out16:	; void io_out16(int port, int data);
		MOV		EDX,[ESP+4]		; port
		MOV		EAX,[ESP+8]		; data
		OUT		DX,AX
		RET

;_io_out32:	; void io_out32(int port, int data);
io_out32:	; void io_out32(int port, int data);
		MOV		EDX,[ESP+4]		; port
		MOV		EAX,[ESP+8]		; data
		OUT		DX,EAX
		RET

;_io_load_eflags:	; int io_load_eflags(void);
io_load_eflags:	; int io_load_eflags(void);
		PUSHFD		; PUSH EFLAGS という意味
		POP		EAX
		RET

;_io_store_eflags:	; void io_store_eflags(int eflags);
io_store_eflags:	; void io_store_eflags(int eflags);
		MOV		EAX,[ESP+4]
		PUSH	EAX
		POPFD		; POP EFLAGS という意味
		RET

;_load_gdtr:		; void load_gdtr(int limit, int addr);
load_gdtr:		; void load_gdtr(int limit, int addr);
		MOV		AX,[ESP+4]		; limit
		MOV		[ESP+6],AX
		LGDT	[ESP+6]
		RET

;_load_idtr:		; void load_idtr(int limit, int addr);
load_idtr:		; void load_idtr(int limit, int addr);
		MOV		AX,[ESP+4]		; limit
		MOV		[ESP+6],AX
		LIDT	[ESP+6]
		RET

;_load_cr0:		; int load_cr0(void);
load_cr0:		; int load_cr0(void);
		MOV		EAX,CR0
		RET

;_store_cr0:		; void store_cr0(int cr0);
store_cr0:		; void store_cr0(int cr0);
		MOV		EAX,[ESP+4]
		MOV		CR0,EAX
		RET

;_load_tr:		; void load_tr(int tr);
load_tr:		; void load_tr(int tr);
		LTR		[ESP+4]			; tr
		RET

;_asm_inthandler20:
asm_inthandler20:
		PUSH	ES
		PUSH	DS
		PUSHAD
		MOV		EAX,ESP
		PUSH	EAX
		MOV		AX,SS
		MOV		DS,AX
		MOV		ES,AX
		;CALL	_inthandler20
		CALL	inthandler20
		POP		EAX
		POPAD
		POP		DS
		POP		ES
		IRETD

;_asm_inthandler21:
asm_inthandler21:
		PUSH	ES
		PUSH	DS
		PUSHAD
		MOV		EAX,ESP
		PUSH	EAX
		MOV		AX,SS
		MOV		DS,AX
		MOV		ES,AX
		;CALL	_inthandler21
		CALL	inthandler21
		POP		EAX
		POPAD
		POP		DS
		POP		ES
		IRETD

;_asm_inthandler27:
asm_inthandler27:
		PUSH	ES
		PUSH	DS
		PUSHAD
		MOV		EAX,ESP
		PUSH	EAX
		MOV		AX,SS
		MOV		DS,AX
		MOV		ES,AX
		;CALL	_inthandler27
		CALL	inthandler27
		POP		EAX
		POPAD
		POP		DS
		POP		ES
		IRETD

;_asm_inthandler2c:
asm_inthandler2c:
		PUSH	ES
		PUSH	DS
		PUSHAD
		MOV		EAX,ESP
		PUSH	EAX
		MOV		AX,SS
		MOV		DS,AX
		MOV		ES,AX
		;CALL	_inthandler2c
		CALL	inthandler2c
		POP		EAX
		POPAD
		POP		DS
		POP		ES
		IRETD

;_memtest_sub:	; unsigned int memtest_sub(unsigned int start, unsigned int end)
memtest_sub:	; unsigned int memtest_sub(unsigned int start, unsigned int end)
		PUSH	EDI						; （EBX, ESI, EDI も使いたいので）
		PUSH	ESI
		PUSH	EBX
		MOV		ESI,0xaa55aa55			; pat0 = 0xaa55aa55;
		MOV		EDI,0x55aa55aa			; pat1 = 0x55aa55aa;
		MOV		EAX,[ESP+12+4]			; i = start;
mts_loop:
		MOV		EBX,EAX
		ADD		EBX,0xffc				; p = i + 0xffc;
		MOV		EDX,[EBX]				; old = *p;
		MOV		[EBX],ESI				; *p = pat0;
		XOR		DWORD [EBX],0xffffffff	; *p ^= 0xffffffff;
		CMP		EDI,[EBX]				; if (*p != pat1) goto fin;
		JNE		mts_fin
		XOR		DWORD [EBX],0xffffffff	; *p ^= 0xffffffff;
		CMP		ESI,[EBX]				; if (*p != pat0) goto fin;
		JNE		mts_fin
		MOV		[EBX],EDX				; *p = old;
		ADD		EAX,0x1000				; i += 0x1000;
		CMP		EAX,[ESP+12+8]			; if (i <= end) goto mts_loop;
		JBE		mts_loop
		POP		EBX
		POP		ESI
		POP		EDI
		RET
mts_fin:
		MOV		[EBX],EDX				; *p = old;
		POP		EBX
		POP		ESI
		POP		EDI
		RET

;_farjmp:		; void farjmp(int eip, int cs);
farjmp:		; void farjmp(int eip, int cs);
		JMP		FAR	[ESP+4]				; eip, cs
		RET

;_farcall:		; void farcall(int eip, int cs);
farcall:		; void farcall(int eip, int cs);
		CALL	FAR	[ESP+4]				; eip, cs
		RET

;_asm_cons_putchar:
asm_cons_putchar:
		PUSH	1
		AND		EAX,0xff	; AHやEAXの上位を0にして、EAXに文字コードが入った状態にする。
		PUSH	EAX
		PUSH	DWORD [0x0fec]	; メモリの内容を読み込んでその値をPUSHする
		;CALL	_cons_putchar
		CALL	cons_putchar
		ADD		ESP,12		; スタックに積んだデータを捨てる
		RETF
