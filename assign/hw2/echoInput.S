/*
 * Assembly language program to read a small amount of input
 * from stdin (up to 128 bytes) and then echo it to stdout.
 * Uses read system call to read input, and write system
 * call to write output.
 *
 * To assemble and link:
 *   gcc -c -no-pie echoInput.S -o echoInput.o
 *   gcc -o echoInput -no-pie echoInput.o
 */

	.section .text

	.globl main
main:
	/* reserve some space on the stack */
	subq $136, %rsp

	/* read up to 128 bytes of input */
	movq $0, %rdi                 /* 1st arg to read is file desc */
	movq %rsp, %rsi               /* 2nd arg to read is buf ptr */
	movq $128, %rdx               /* 3rd arg to read is num bytes */
	movq $0, %rax                 /* read is system call number 0 */
	syscall                       /* execute the system call */

	cmpq $0, %rax                 /* see if read failed */
	jl .LreadError                /* handle read failure */

	/* number of bytes read is now in %rax */

	/* write the output to stdout */
	movq $1, %rdi                 /* 1st arg to write is file desc */
	movq %rsp, %rsi               /* 2nd arg to write is buf ptr */
	movq %rax, %rdx               /* 3rd arg to write is num bytes */
	movq $1, %rax                 /* write is system call number 1 */
	syscall

	/* restore stack pointer */
	movq $0, %rax                 /* exit with 0 exit code (success) */
	jmp .Ldone

.LreadError:
	movq $1, %rax

.Ldone:
	addq $136, %rsp               /* restore stack pointer */
	ret

/* vim:ft=gas:
 */
