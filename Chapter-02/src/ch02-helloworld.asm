; hello world ASM


global _start

section .text

_start:


	; write(int fd, const void *buf, size_t count)
	xor    eax,eax
	xor    ebx,ebx
	xor    ecx,ecx
	xor    edx,edx
	mov    al,0x4
	inc    bl
	push   0x000a2164
	push   0x6c726f57
	push   0x202c6f6c
	push   0x6c6548
	mov    ecx,esp
	mov    dl,0xf
	int    0x80

	; exit(int status)
	xor    eax,eax
	xor    ebx,ebx
	mov    al,0x1
	int    0x80
