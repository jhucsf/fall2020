---
layout: default
title: "Exam 3 practice questions"
---

# A. Linking, shared libraries

A1) Here is the disassembly of a possible implementation of the `hex_write_string` function from Assignment 2, as observed in a non-position-independent executable (`asm_hextests`):

```
0000000000400904 <hex_write_string>:
  400904:       41 54                   push   %r12
  400906:       49 89 fc                mov    %rdi,%r12
  400909:       e8 b9 ff ff ff          callq  4008c7 <str_len>
  40090e:       48 89 c2                mov    %rax,%rdx
  400911:       bf 01 00 00 00          mov    $0x1,%edi
  400916:       4c 89 e6                mov    %r12,%rsi
  400919:       b8 01 00 00 00          mov    $0x1,%eax
  40091e:       0f 05                   syscall 
  400920:       41 5c                   pop    %r12
  400922:       c3                      retq   
```

Note that in the encoding of the `callq` instruction, the address of the function being called is specified by a signed 32 bit offset, which is relative to the address of the instruction following the `callq` instruction.  Observe that the bytes B9 FF FF FF, when interpreted as a little endian signed two's complement integer, encode the value -71, and subtracting 71 from the address of the successor of the `callq` instruction, 0x40090E, yields 0x4008C7, the exact address of the called function.

What are some advantages of encoding the address of a called function as a relative displacement rather than an absolute address?  What are some disadvantages?

A2) Let's say that you have a Linux executable that you don't have the source code for, and you want to change its behavior so that whenever it tries to open a file, it will be forced to look in a particular directory.  For example, if the process wants to open the file `foobar.txt`, it will actually open `/tmp/look_here/foobar.txt`.  What would be an easy way to accomplish this that doesn't require any modifications to the executable or any system libraries?  You may assume that all files will be opened via calls to the `open` function in the shared C library, which is a wrapper for the `open` system call.

# B. Exceptions and processes

B1) Consider the following function:

```c
uint64_t sum_array(uint32_t arr[], unsigned len) {
  uint64_t sum = 0;
  for (unsigned i = 0; i < len; i++) {
    sum += arr[i];
  }
  return sum;
}
```

Assume that this function is called to find the sum of the elements in a very large (hundreds of millions of elements.)  State some possible reasons why the process executing this function might be suspended and resumed during the execution of the function.

B2) Most operating systems use a periodic timer interrupt to ensure that the OS kernel is able to make scheduling decisions on a regular basis.  I.e., the timer interrupt handler can ensure that no process is able to have exclusive use of a CPU core for an indefinite period of time.

Assume a uniprocessor (single core) system in which the timer interrupt occurs at fixed intervals.  State some advantages and disadvantages of making the timer interval longer rather than shorter.

# C. Signals

TODO

# D. Virtual memory

D1) Consider the following function:

```c
uint32_t sum_up_to(unsigned n) {
  uint32_t sum = 0;
  for (unsigned i = 1; i <= n; i++) {
    sum += i;
  }
  return sum;
}
```

Assume that all of the variables in this function (`n`, `sum`, and `i`) are allocated by the compiler as CPU registers, so that there are no memory references in the assembly code generated for this function.  Is it possible for any page faults to occur as a result of executing this function? Briefly explain why or why not.
