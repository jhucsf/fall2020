---
layout: default
title: "Assignment 2: Hex dump"
---

*Preliminary assignment description, not official!*

**Due:** TBD

# Overview

In this assignment you will implement a hex dump program using both C and assembly language.

The grading breakdown is as follows:

TODO: grading breakdown

TODO: say something about milestone? Maybe require all C language function implementations to work, and at least `hex_to_printable` and `hex_format_byte_as_hex` to be working.

Acknowledgment: The idea for this assignment comes from the [Fall 2018 HW5](https://www.cs.jhu.edu/~phf/2018/fall/cs229/simple-x86_64.html) developed by Peter Froehlich.

## Getting started

Download [csf\_assign02.zip](csf_assign02.zip), which contains the skeleton code for the assignment.

You can download this file from a Linux command prompt using the `curl` command:

```bash
curl -O https://jhucsf.github.io/fall2020/assign/csf_assign02.zip
```

Note that in the `-O` option, it is the letter "O", not the numeral "0".

# Hex dump

TODO: Explain the behavior of the program, show examples of executing it

TODO: Also show examples of running the test programs

Note that because the purpose of this assignment is to give you an opportunity to learn how to write x86-64 assembly language code, there are some very important [non-functional requirements](#non-functional-requirements) that you will need to satisfy.  (Please read that section of the assignment description carefully.)

# Functional requirements

## Functions

The header file `hexfuncs.h` declares the following functions:

```c
// Read up to 16 bytes from standard input into data_buf.
// Returns the number of characters read.
long hex_read(char data_buf[]);

// Write given nul-terminated string to standard output.
void hex_write_string(const char s[]);

// Format a long value as an offset string consisting of exactly 8
// hex digits.  The formatted offset is stored in sbuf, which must
// have enough room for a string of length 8.
void hex_format_offset(long offset, char sbuf[]);

// Format a byte value (in the range 0-255) as string consisting
// of two hex digits.  The string is stored in sbuf.
void hex_format_byte_as_hex(long byteval, char sbuf[]);

// Convert a byte value (in the range 0-255) to a printable character
// value.  If byteval is already a printable character, it is returned
// unmodified.  If byteval is not a printable character, then the
// ASCII code for '.' should be returned.
long hex_to_printable(long byteval);
```

In both your C and assembly language implementations, you are required to implement these functions exactly as specified.

## Main functions

In `c_hexmain.c` and `asm_hexmain.S`, you will develop C and assembly-language `main` functions which call the functions shown above in order to implement the functionality of the hexdump program.

Note that your main function (either version) may *only* call these functions.

The `c_hexdump` and `asm_hexdump` Makefile targets build executable programs using these `main` modules.  When reading data from standard input, their output should be identical to the command `xxd -g 1`.

The `casm_hexdump` Makefile target builds an executable program which uses the C version of the `main` function, but the assembly-language version of the hex functions.  This is a handy way to test your assembly language function implementations before you have fully implemented the assembly language version of the `main` function.  Its behavior (reading from standard input) should also be identical to `xxd -g 1`.

## Unit tests

The source file `hextests.c` contains unit tests for the required functions.  The provided version is very minimal, so you should add additional tests so that your implementations of the functions are thoroughly tested.  Part of your grade will be based on the thoroughness of your unit tests.

Note that it will not be straightforward to write unit tests for the `hex_read` and `hex_write_string` functions, since they do I/O.  So, you are not required to write unit tests for them.

# Non-functional requirements

TODO: Explain that calling C library functions is *not* allowed, the only exception is that `c_hexfuncs.c` may `#include <unistd.h>` and call the `read` and `write` functions (which are wrappers for the `read` and `write` system calls)

TODO: Explain that the assembly language code must be 100% written by hand, and be extensively commented, and that no credit will be given for assembly language code that doesn't meet these requirements

# Hints and tips

TODO: add useful info about how to complete the assignment

TODO: recommend an order of how to do things

TODO: emphasize that the assembly language functions must fully conform to the x86-64 calling conventions, otherwise the interoperability with C code won't work

TODO: emphasize that writing the assembly language `main` is the *last* thing to work on

# Submitting

TODO: instructions for submitting (both milestone and final)
