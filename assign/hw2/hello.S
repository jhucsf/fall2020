/*
 * Hello, world in x86-64 assembly using write system call
 *
 * To assemble and link:
 *   gcc -c -no-pie hello.S -o hello.o
 *   gcc -o hello -no-pie hello.o
 */

	.section .rodata

sHelloWorld: .string "Hello, world\n"

	.section .text

	.globl main
main:
	subq $8, %rsp                 /* align stack pointer */

	movq $1, %rdi                 /* 1st arg to write is file desc */
	movq $sHelloWorld, %rsi       /* 2nd arg to write is ptr to buf */
	movq $13, %rdx                /* 3rd arg to write is num bytes */
	movq $1, %rax                 /* write is system call 1 */
	syscall                       /* execute the system call! */

	movq $0, %rax                 /* return 0 from main */

	addq $8, %rsp                 /* restore stack pointer */
	ret

/* vim:ft=gas:
 */
