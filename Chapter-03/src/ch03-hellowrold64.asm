; ch03_helloworld64.asm
; by Michael Born
; Date - 2019


global _start


section .text


_start:

	; __NR_write 1
	; ssize_t write(int fd, const void *buf, size_t count);

	xor    rax,rax
	xor    rdi,rdi
	xor    rsi,rsi
	xor    rdx,rdx
	xor    r14,r14
	xor    r15,r15
	inc    rax
	inc    rdi
	mov    r14,0x00000a21646c726f
	mov    r15,0x57202c6f6c6c6548
	push   r14
	push   r15
	mov    rsi,rsp
	mov    dl,0xf
	syscall


	; __NR_exit 60
	; void _exit(int status);

	xor    rax,rax
	xor    rdi,rdi
	mov    al,0x3c
	syscall
