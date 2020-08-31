---
layout: default
title: "Midterm exam review questions — solutions"
---

*Update 3/8*: a correction has been made to the answer for [performance optimization](#performance-optimization) part (b)

*Update 3/9*: corrected explanations of the answers to [performance optimization](#performance-optimization) parts (a) and (b)

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

*Answers:*

Value | Binary representation
----- | ---------------------
a     | 00111101
b     | 10000001
c     | 11111101
x     | 00101010
y     | 11111111
z     | 10000010

**(b)** What is the output of the following C code? Justify your answers briefly.

```c
uint8_t a = 129, b = 137;
int8_t x = 123, y = 7;

uint8_t c = a + b;
int8_t z = x + y;
printf("%u\n", c);
printf("%d\n", z);
```

*Answers:*

```c
printf("%u\n", c);  // prints 10 because (129+137) mod 256 is 10
printf("%d\n", z);  // prints -126 (repeatedly adding 1 to 123 would yield
                    // 124, 125, 126, 127, -128 (overflow), -127, -126)
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

*Answer:*

```c
uint8_t negate_u(uint8_t x) {
  return ~x + 1;    // two's complement negation can be accomplished by
                    // inverting all bits, then adding 1
}
```

**(d)** Complete the following C function so that it returns 1 if the addition of `a` and `b` would overflow, and 0 otherwise.

```c
int overflow32(uint32_t a, uint32_t b) {
```

*Answer:*

```c
int overflow32(uint32_t a, uint32_t b) {
  return (a + b) < a;
}
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

*Answer:*

```
	.globl strLen
strLen:
	subq $8, %rsp                 /* align stack */
	movq $0, %rax                 /* use %rax to count characters */

.LstrlenLoopTop:
	cmpb $0, (%rdi)               /* reached NUL terminator? */
	je .LstrlenLoopDone           /* if so, we're done */
	incq %rax                     /* add to count */
	incq %rdi                     /* advance pointer */
	jmp .LstrlenLoopTop           /* continue loop */

.LstrlenLoopDone:
	addq $8, %rsp                 /* restore stack */
	ret                           /* return value is in %rax */
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

*Answer:*

```
	.globl makePositive
makePositive:
	pushq %r12                    /* preserve value of %r12 */
	movq $0, %r12                 /* use %r12 as index variable */

.LmakePosLoopTop:
	cmpq %rsi, %r12               /* see if %r12 is less than n */
	jge .LmakePosLoopDone         /* if not, done */

	movq (%rdi,%r12,8), %r11      /* load current element into %r11 */
	cmpq $0, %r11                 /* is current element less than 0? */
	jge .LmakePosIncrIndex        /* if not, incr. index and continue */
	movq $0, %r10                 /* put 0 in %r10 */
	subq %r11, %r10               /* subtract element value from 0 */
	movq %r10, (%rdi,%r12,8)      /* store negated value in array */

.LmakePosIncrIndex:
	incq %r12                     /* increment index */
	jmp .LmakePosLoopTop          /* continue loop */

.LmakePosLoopDone:
	popq %r12                     /* restore value of %r12 */
	ret
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

*Answer:*

There are two issues:

* The function modifies `%r12`, but doesn't use pushq and popq to save and restore its value, which is required because it is a callee-saved register
* The function does not align the stack pointer to be a multiple of 16 before calling `printf`

Fixed version:

```
	.globl printSum
printSum:
	pushq %r12                    /* preserve %r12 and align stack */
	movq %rdi, %r12               /* copy first parameter to %r12 */
	addq %rsi, %r12               /* add in value of second parameter */
	movq $sResultMsg, %rdi        /* pass format string to printf */
	movq %r12, %rsi               /* pass sum as second parameter */
	call printf                   /* print the sum */
	popq %r12                     /* restore %r12 and restore stack */
	ret                           /* return from the function */
```

## Performance optimization

Assume that a superscalar x86-64 CPU has three integer multipliers with a latency of 3 cycles.  You may assume that the integer multipliers are fully pipelined.

**(a)** When the code below is executed, how many cycles are required for the result in the `%r12` to be computed? Explain briefly.

```
imulq %rdi, %rsi
imulq %rsi, %r10
imulq %r10, %r11
imulq %r11, %r12
```

*Answer:*

Let's label each instruction A–D:

```
imulq %rdi, %rsi    /* A */
imulq %rsi, %r10    /* B */
imulq %r10, %r11    /* C */
imulq %r11, %r12    /* D */
```

There are data dependences in this sequence which require the instructions to be executed sequentially.  For example, instruction B requires the result of instruction A as a source operand.  So, even though there are three integer multipliers which could be used independently, no parallelism is possible.  (We're assuming that data dependences cannot be satisfied early via forwarding.)

```
Time:      0  1  2  3  4  5  6  7  8  9  10 11 12
         +----------------------------------------
Stage 1  | A        B        C        D
Stage 2  |    A        B        C        D
Stage 3  |       A        B        C        D
```

A total of 12 cycles is required.

**(b)** Show a series of operations that computes the final product in `%r12` more quickly. You may use additional registers if needed.  Justify your answer briefly, indicating how many cycles are required.

*Answer:*

We can exploit the fact that integer multiplication is commutative to utilize the available functional units somewhat more fully.  For example:

<div class="highlighter-rouge"><pre>
imulq %rdi, %rsi    /* A */
imulq %r10, %r11    /* B */
imulq %rsi, %r12    /* C */
imulq %r11, %r12    /* D */
</pre></div>

Timing analysis:

```
Time:      0  1  2  3  4  5  6  7  8  9  10 11 12
         +----------------------------------------
Stage 1  | AB       C        D
Stage 2  |    AB       C        D
Stage 3  |       AB       C        D
```

The revised sequence executes in 9 cycles.  Note that instructions A and B can execute in parallel (utilizing two multipliers in parallel), but because of the data dependence of instruction C on instruction A, C can't start executing until A finishes.

## Memory hierarchy

See Question 2 from the [Fall 2016 final exam](https://www.cs.jhu.edu/~phi/csf/final2016.pdf).

*Answer:*

See the [Fall 2016 final exam solutions](https://www.cs.jhu.edu/~phi/csf/final2016-solutions.pdf).
