---
layout: default
title: "Midterm exam review questions"
---

*Update 3/2* — Added [performance optimization](#performance-optimization) and [memory hierarchy](#memory-hierarchy) questions.

# Midterm review questions

This document has review questions for the midterm exam.  We will be adding additional review questions (so keep an eye on this page.)

We will have a review session in class on Friday, March 6th for Section 01, and Wednesday, March 4th for Section 02.  During the review session we will present solutions to these review questions.  We'll also post solutions here on the course website.

These questions cover topics that will be emphasized on the midterm exam, but may be more challenging than the actual midterm questions.

Solutions are here: [Solutions](midterm_review_soln.html), [Solution code](midterm_review_soln_code.zip).  **Don't look at the solutions until you attempt the questions on your own!**

## Binary data representation, integer arithmetic

Assume that:

* `uint8_t` is an unsigned, 8 bit integer data type.
* `int8_t` is a signed, 8 bit, two's complement integer data type
* `uint32_t` is an unsigned, 32 bit integer data type

**(a)** Consider the following C code:

```c
uint8_t a = 61,
        b = 129,
        c = 253;
int8_t  x = 42,
        y = -1,
        z = -126;
```

Write the binary representations of `a`, `b`, `c`, `x`, `y`, and `z`.

**(b)** What is the output of the following C code? Justify your answers briefly.

```c
uint8_t a = 129, b = 137;
int8_t x = 123, y = 7;

uint8_t c = a + b;
int8_t z = x + y;
printf("%u\n", c);
printf("%d\n", z);
```

**(c)** Consider the following C function:

```c
int8_t negate(int8_t x) {
  return -x;
}
```

Complete the following C function so that it behaves identically to the `negate` function, in the sense that when it is given an 8 bit binary value, it will return an 8 bit value with the same bit pattern as what would be returned from the `negate` function shown above.  You may not use type casts, but you may use bitwise operations and arithmetic for `uint8_t` values.  Hint: `~` is the bitwise complement operator (which will invert the bits of the value to which it is applied).

```c
uint8_t negate_u(uint8_t x) {
  // add your code here
```

**(d)** Complete the following C function so that it returns 1 if the addition of `a` and `b` would overflow, and 0 otherwise.

```c
int overflow32(uint32_t a, uint32_t b) {
```

## x86-64

Things to know about x86-64 code:

* Arguments are passed in `%rdi`, `%rsi`, `%rdx`, `%rcx`, `%r8`, `%r9`
* The return value is returned in `%rax`
* `%r10` and `%r11` are caller-saved registers, which may change as a result of a function call (the argument registers are also effectively caller-saved)
* `%rbx`, `%rbp`, and `%r12`–`%r15` are callee-saved: functions modifying them must save and restore their values using `pushq` and `popq`, and may be assumed *not* to change as a result of a function call 
* Code should go in the `.text` section
* Global variables should go in the `.bss` or `.data` sections (`.data` allows data to be initialized)
* Read-only data such as string constants should go in the `.rodata` section
* Operand size suffixes are `b` (8 bit byte), `w` (16 bit word), `l` (32 bit long word), and `q` (64 bit quad word)
* Instructions may have at most one memory operand
* Indexed/scaled addressing is (RegA,RegB,Scale), and accesses address RegA + RegB×Scale, where Scale is 1, 2, 4, or 8

Selected registers and 8 bit sub-registers:

Register | 8 bit sub-register
-------- | -----------------------------------------------
`%rax`   | `%al` (same pattern for `%rbx`, `%rcx`, `%rdx`)
`%rdi`   | `%dil`
`%rsi`   | `%sil`
`%r8`    | `%r8b` (same pattern for `%r9`–`%r15`)

Note that assigning to the 8 bit sub-register does *not* clear the other bits of the larger register.

**(a)** Complete the following x86-64 assembly language function called `strLen`, which returns the length of the NUL-terminated string constant passed as its parameter (excluding the NUL terminator character).  In C, this function would have the following declaration:

```c
long strLen(const char *s);
```

Here are example assertions specifying its behavior:

```c
ASSERT(0L == strLen(""));
ASSERT(5L == strLen("hello"));
ASSERT(12L == strLen("hello, world"));
```

Fill in your code here:

```
	.section .text

	.globl strLen
strLen:
	/* your code here... */
```

**(b)** Complete the following x86-64 assembly language function called `makePositive`, which takes two parameters: `a`, which is a pointer to the first element of an array of 64 bit signed integers, and `n`, which indicates how many elements the array has.  The function should modify all of the negative elements of the array so that they become positive. (You can ignore the situation where an array element might have the value -2<sup>63</sup>, which can't be negated.)

In C, this function would have the following declaration:

```c
void makePositive(long *a, long n);
```

Here are example assertions specifying its behavior:

```c
long myArr[] = { 4, -9, 9, 7, -1 };

makePositive(myArr, 5);

ASSERT(4L == myArr[0]);
ASSERT(9L == myArr[1]);
ASSERT(9L == myArr[2]);
ASSERT(7L == myArr[3]);
ASSERT(1L == myArr[4]);
```

Fill in your code here:

```
	.section .text

	.globl makePositive
makePositive:
	/* your code here... */
```

**(c)** The following code is intended to compute the sum of its two parameters and then print the sum.  Briefly explain the errors that exist in this code, and how to fix them.  (Note that there could be multiple errors!)

```
	.section .rodata
sResultMsg: .string "Sum is %ld\n"

	.section .text

	.globl printSum
printSum:
	movq %rdi, %r12               /* copy first parameter to %r12 */
	addq %rsi, %r12               /* add in value of second parameter */
	movq $sResultMsg, %rdi        /* pass format string to printf */
	movq %r12, %rsi               /* pass sum as second parameter */
	call printf                   /* print the sum */
	ret                           /* return from the function */
```

## Performance optimization

Assume that a superscalar x86-64 CPU has three integer multipliers with a latency of 3 cycles, and that the multipliers are fully pipelined.

**(a)** When the code below is executed, how many cycles are required for the result in the `%r12` to be computed? Explain briefly.

```
imulq %rdi, %rsi
imulq %rsi, %r10
imulq %r10, %r11
imulq %r11, %r12
```

**(b)** Show a series of operations that computes the final product in `%r12` more quickly. You may use additional registers if needed.  Justify your answer briefly, indicating how many cycles are required.

## Memory hierarchy

See Question 2 from the [Fall 2016 final exam](https://www.cs.jhu.edu/~phi/csf/final2016.pdf).
