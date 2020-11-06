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

TODO

# C. Signals

TODO

# D. Virtual memory

TODO
