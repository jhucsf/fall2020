---
layout: default
title: "Exam 1 Practice Questions"
category: "resources"
---

# Exam 1 Practice Questions

These questions are designed to aid your review of the material covered by the first exam. They is not representative of the difficulty, type, or length of the questions on the exam.

## Q1. Number Representation
<ol type="a">
  <li>

  Write the representation of the number 43 in base 16, base 10, base 8, base 6, and base 2.

  </li>
  <li>

  On an 8-bit computer, what is the sum of unsigned `208 + 53`, and what is the difference of signed `103 - 24`?

  </li>
  <li>

  Write what `-5` would be on a 4-bit and an 8-bit system.

  </li>
  <li>

  Show how to calculate `1.250 + 3.375` and `1.250 * 3.375`.

  </li>
  <li>

  How are 32 bits broken down in IEEE-754?

  </li>
</ol>

## Q2. Bitwise Operators
<ol type="a">
  <li>

  Write the arithmetic and logical implementations of `-113 >> 1`.

  </li>
  <li>

  What is the fastest way to compute `16 * 13`?

  </li>
  <li>

  Determine `43 | 13`, `43 & 13`, `43 ^ 13`, and `~43` (base 8).

  </li>
</ol>

## Q3. Basic Assembly Questions
<ol type="a">
  <li>

  What are the steps that happen after you run gcc on a .c program? What does the output after each step look like, and what are their file extensions?

  </li>

  <li>

  How, why, and when do you align the stack pointer?

  </li>
  <li>

  What are caller and callee saved registers?

  </li>
  <li>

  Write a local loop and the line which calls it in `main` that sums all the values from 0-9, given
  
  `#define N 9`

  </li>
  <li>

  In AT&T syntax, what is the order of arguments for these functions, and where are the results stored?
  * `addq %r9, %r10`
  * `movl $FFFF0000, %esi`
  * `cmpl %eax, %eax`

  </li>
</ol>

## Q4. x86-64 Assembly Programming

Write an x86-64 assembly language function called `swapInts` which swaps the values of two `int` variables. The C function declaration for this function would be

`void swapInts(int *a, int *b);`

Hints:
* Think about which registers the parameters will be passed in
* Think about what register(s) would be appropriate to use for temporary value(s)
* Consider that `int` variables are 4 bytes (32 bits), and use an appropriate operand size suffix.

**Important:** Your function should follow proper x86-64 Linux register use conventions. Be sure to include the label defining the name of the function.
