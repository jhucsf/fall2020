---
layout: default
title: "Exam 1 Practice Solutions"
category: "resources"
---

# Exam 1 Practice Solutions

These questions are designed to aid your review of the material covered by the first exam. They are not representative of the difficulty, type, or length of the questions on the exam.

In all questions, assume signed integers use two's complement representation.

## Q1. Number Representation
<ol type="a">
  <li>

    <i>Write the representation of the number 43 in base 16, base 10, base 8, base 6, and base 2.</i>
      <br>
      <br>
    From grouping 4 binary bits into one hexadecimal digit:
      <br>
    <code>43<sub>10</sub> = 2B<sub>16</sub></code>
    <br><br>
    We normally use base 10:
      <br>
    <code>43<sub>10</sub> = 43<sub>10</sub></code>
    <br><br>
    From grouping 3 binary bits into one octal digit:
      <br>
    <code>43<sub>10</sub> = 53<sub>8</sub></code>
      <br><br>
    From <code>1 * 6^2 + 1 * 6^1 + 1 * 6^0</code>:
      <br>
    <code>43<sub>10</sub> = 111<sub>8</sub></code>
      <br><br>
    From <code>1 * 2^5 + 1 * 2^3 + 1 * 2^1 + 1 * 2^0</code>:
      <br>
    <code>43<sub>10</sub> = 101011<sub>2</sub></code>

    <br>
  </li>
  <li>

    <i>On an 8-bit computer, what is the sum of unsigned <code>208 + 53</code>?, and what is the difference of signed <code>103 - 24</code>?</i>
      <br><br>

    <code>208 + 53 = 5</code>: Due to the 8th bit overflowing, <code>00000101</code> remains
      <br>
    <code> 103 + (-24) = 79</code>: From <code>01100111 + 11101000</code>
      <br>
  </li>
  <li>

    <i>Write what <code>-5</code> would be on a 4-bit and an 8-bit system.</i>
      <br><br>
    4-bit system: <code>5<sub>10</sub> = 1011<sub>2</sub></code>
      <br>
    <code>-5<sub>10</sub> = -8<sub>10</sub> + 3<sub>10</sub> = 1000<sub>2</sub> + 0011<sub>2</sub></code>
      <br>
    8-bit system: <code>5<sub>10</sub> = 1011</code>
      <br>
    <code>-5<sub>10</sub> = -128<sub>10</sub> + 123<sub>10</sub> = 10000000<sub>2</sub> + 01111011<sub>2</sub></code>
      <br>
  </li>
  <li>

    <i>Show how to calculate <code>1.250 + 3.375</code> and <code>1.250 * 3.375</code> using floating point.</i>
      <br>
    TODO
      <br>
  </li>
  <li>

    <i>How are 32 bits broken down in IEEE-754?</i>

    <table>
      <tr>
        <th>Sign Bit</th>
        <th>Exponent</th>
        <th>Fraction/Mantissa</th>
      </tr>
      <tr>
        <th>1</th>
        <th>8</th>
        <th>23</th>
      </tr>
    </table>
      <br>
  </li>
</ol>

## Q2. Bitwise Operators
<ol type="a">
  <li>

    <i>Write the results of arithmetic and logical executions of <code>-113 >> 1</code>, where <code>-113</code> is an 8 bit value.</i>
      <br><br>
    <code>-113</code> in 8 bits is <code>10001111</code>.
      <br>
    An arithmetic shift results in <code>11000111<sub>2</sub> = -57<sub>10</sub></code>, preserving the sign bit.
      <br>
    A logical shift results in <code>01000111</code>, treating the sign bit as any other bit.
      <br>
    </li>
  <li>

    <i>What is the fastest way to compute <code>16 * 13</code>? (Hint: don't use multiplication.)</i>
      <br><br>
    <code>16 * 13</code> can be found by <code>13 << 4</code>

    <br>
  </li>
  <li>

    <i>Determine <code>43 | 13</code>, <code>43 & 13</code>, <code>43 ^ 13</code>, and <code>~43</code> (assume operands are unsigned 8 bit.)</i>
      <br><br>
    <code>43<sub>10</sub> = 00101011<sub>2</sub></code>
      <br>
    <code>13<sub>10</sub> = 00001101<sub>2</sub></code>
      <br>
    <code>43<sub>10</sub> | 13<sub>10</sub> = 00101111<sub>2</sub></code>
      <br>
    <code>43<sub>10</sub> & 13<sub>10</sub> = 00001001<sub>2</sub></code>
      <br>
    <code>43<sub>10</sub> ^ 13<sub>10</sub> = 00100110<sub>2</sub></code>
      <br>
    <code>~43<sub>10</sub> = 11010100<sub>2</sub></code>

      <br>
  </li>
</ol>

## Q3. Basic Assembly Questions
<ol type="a">
  <li>

    <i>What are the steps that happen after you run gcc on a .c program? What does the output after each step look like, and what are their file extensions?</i>
    <br><br>
    Compilation, Assembly, Linking
    <br>
    The compile step converts .c source to .s assembly language code (<code>movl $0, %eax</code>)
    <br>
    The assembler step converts .s assembly to .o machine code (machine instructions, binary numbers representing the instruction the CPU should execute)
    <br>
    The linking step combines all .o files into an executable
      <br>
  </li>

  <li>

    <i>How, why, and when do you align the stack pointer?</i>

    TODO
      <br>
  </li>
  <li>

    <i>What are caller and callee saved registers?</i>

    TODO
      <br>
  </li>
  <li>

    <i>Write a local loop, and the line which calls it in <code>main</code>, that sums all the values from 0-9, given

    <code>#define N 9</code></i>

    TODO
      <br>
  </li>
  <li>

    <i>In AT&T syntax, what is the order of arguments for these instructions, and where are the results stored?

    <ul>
    <li><code>addq %r9, %r10</code></li>

    <li><code>movl $FFFF0000, %esi</code></li>

    <li><code>cmpl %eax, %eax</code>
    </li>
    </ul></i>

    TODO
      <br>
  </li>
</ol>

## Q4. x86-64 Assembly Programming

<i>Write an x86-64 assembly language function called <code>swapInts</code> which swaps the values of two <code>int</code> variables. The C function declaration for this function would be

<code>void swapInts(int *a, int *b);</code>

Hints:
* Think about which registers the parameters will be passed in
* Think about what register(s) would be appropriate to use for temporary value(s)
* Consider that <code>int</code> variables are 4 bytes (32 bits), and use an appropriate operand size suffix.

**Important:** Your function should follow proper x86-64 Linux register use conventions. Be sure to include the label defining the name of the function.</i>

  TODO
