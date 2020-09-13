---
layout: default
title: "Assignment 2: Hex dump"
---

*Preliminary assignment description, not official!*

**Due:** Tuesday, September 28, 2020 @ 11pm

# Overview

In this assignment you will implement a hex dump program using both C and assembly language. The submission of this assignment will be broken up to two parts as listed below. 

**Acknowledgment:** The idea for this assignment comes from the [Fall 2018 HW5](https://www.cs.jhu.edu/~phf/2018/fall/cs229/simple-x86_64.html) developed by Peter Froehlich.

### Submission Part 1
**Due date 1:** Wednesday, September 23, 2020 @ 11pm

For this submission, all C language function implementations must be working with unit tests written. In addition, _at least_ the Assembly language functions of `hex_to_printable` and `hex_format_byte_as_hex` must be working with unit tests written.

### Submission Part 2
**Due date 2:** Tuesday, September 28, 2020 @ 11pm

Rest of the Assembly language functions must be written with thorough unit tests. Uploads for this submission should include the C implementation and unit tests submitted for part 1 as well.


### Grading breakdown
**Part 1** (30 points)

C implementation - 10% 

Assembly implementation - 20%

**Part 2** (70 points)

Assembly implementation - 35% 

Unit tests - 20%

Packing, style, and design - 15% 


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

Calling C library functions is *not* allowed. The only exception is that `c_hexfuncs.c` may `#include <unistd.h>` and call the `read` and `write` functions (which are wrappers for the `read` and `write` system calls). Outside of this singular exception, any call to C library functions will result in an **automatic zero** on the entire assignment. Please don't do it\!

All assembly language code must be 100% written by hand and extensively commented. No credit will be given otherwise. Any undocumented assembly code **will** cause you to lose points. You don’t have to comment **every** line, but at least every “coherent chunk” of assembly should have a comment or two. In particular you **must** describe where you get what data from, especially when it comes to functions and their parameters/results. **You have been warned\!**

# Hints and tips

TODO: add useful info about how to complete the assignment

TODO: recommend an order of how to do things

TODO: emphasize that the assembly language functions must fully conform to the x86-64 calling conventions, otherwise the interoperability with C code won't work

TODO: emphasize that writing the assembly language `main` is the *last* thing to work on

# Submitting

Submit a zipfile containing your complete project.  The recommended
way to do this is to run the command `make solution.zip`.  This
will create a file called `solution.zip` with all of the required
files.  **Important**: all of the files in the zipfile must be
at the top level, not a subdirectory.  For example, if your
zipfile is called `solution.zip` and you run the command `unzip -l solution.zip`
to list its contents, you should see something like the following output:

```
Archive:  solution.zip
  Length      Date    Time    Name
---------  ---------- -----   ----
     1140  09-13-2020 18:42   Makefile
     1053  09-13-2020 18:42   hexfuncs.h
     3959  09-13-2020 18:42   tctest.h
      884  09-13-2020 18:42   c_hexfuncs.c
      877  09-13-2020 18:42   c_hexmain.c
     1458  09-13-2020 18:42   hextests.c
     3948  09-13-2020 18:42   tctest.c
---------                     -------
    13319                     7 files
```

Upload this zipfile to Gradescope for both parts 1 and 2 of Assignment 2.
Make sure to include your name and email address in *every* file you turn in (well, in every file for which it makes sense to do so anyway!)

# Grading

For reference, here is a short explanation of the grading criteria; some
of the criteria don’t apply to all problems, and not all of the criteria
are used on all assignments.

**Packaging** refers to the proper organization of the stuff you hand
in, following both the guidelines for Deliverables above as well as the
general submission instructions for assignments on
[Piazza](http://piazza.com/jhu/fall2020/601229).

**Style** refers to C/C++/assembly programming style, including things
like consistent indentation, appropriate identifier names, useful
comments, suitable documentation, etc. Simple, clean, readable code is
what you should be aiming for. Make sure you follow the style guide
posted on [Piazza](http://piazza.com/jhu/fall2020/601229)\!

**Design** refers to proper modularization (functions, modules, classes,
etc.) and an appropriate choice of algorithms and data structures.

**Performance** refers to how fast/with how little memory your programs
can produce the required results compared to other submissions.

**Functionality** refers to your programs being able to do what they
should according to the specification given above; if the specification
is ambiguous, ask for clarification\! (It also refers to you simply
doing the required work, which may not be programming alone.)

**If your programs cannot be built you will get no points whatsoever. If
your programs cannot be built without warnings using the required
compiler options given on
[Piazza](http://piazza.com/jhu/fall2020/601229) we will take off 10%
(except if you document a *very* good reason). If your programs cannot
be built using `make` we will take off 10%. If `valgrind` detects memory
errors in your programs, we will take off 10%. If your programs fail
miserably even once, i.e. terminate with an exception of any kind or
dump core, we will take off 10% (for each such case).**

