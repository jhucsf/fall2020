---
layout: default
title: "Assignment 7: Arbitrary-precision calculator"
---

**Due:** Friday, Dec 11th by 11pm (hard deadline, late submissions will not be accepted)

**Assignment type:** This is an optional **individual** assignment; it will be graded for extra credit

*Update 11/23*: The [Testing](#testing) section has been updated with instructions on how to download and run the script the autograder tests will use

*Update 11/29*: Mention how much this assignment is worth.

*Update 11/29*: Mention the "UNGRADED ApInt Tester" assignment on Gradescope to test ApInt implementation

# Overview

In this assignment, you will use your arbitrary-precision integer data type from [Assignment 1](assign01.html) to implement a simple calculator program.

This is an extra credit assignment.  It is worth up to 4.5 points, to be added to your course average.  This means it is worth about half of what the other assignments are worth.

## Grading criteria

Your grade is determined as follows:

* Support for addition: 10%
* Support for subtraction: 10%
* Support for multiplication: 70%
* Correct handling of variables: 10%

The grading will be done mostly using an autograder.

# Getting started

Get started by downloading [csf\_assign07.zip](csf_assign07.zip) and unzipping it.

Copy the `apint.c` source file from your implementation of [Assignment 1](assign01.html) into the directory containing the files for this assignment.  Note that you will need to change the definitions of several functions so that all functions that originally had a parameter of type `ApInt *` are changed so that the parameter type is `const ApInt *`.

The `Makefile` included in the skeleton project builds a program called `apcalc`.  The `main` function is in a C++ source file called `apcalc.cpp`.

# Requirements

## Calculator language

The calculator should read lines of text from standard input.  Each line will contain an expression in one of the following forms (which follow the calculator language in [Assignment 5](assign05.html)):

* *operand*
* *operand* *op* *operand*
* *var* = *operand*
* *var* = *operand* *op* *operand*

You may assume that the tokens in each expression will be separated by at least one whitespace character.

An *operand* is either a literal hexadecimal value or a variable name.

An *op* is either `+`, `-`, or `*`, representing addition, subtraction, and multiplication, respectively.

Hexadecimal literals consist of `0x` followed by 1 or more hex digits.  A hex digit is either a decimal digit (`0`–`9`) or `a`, `b`, `c`, `d`, `e`, or `f`.  The hex digits `a`–`f` represent the values 10 through 15.

A variable name is a sequence of 1 or more letters (`a`–`z` or `A`–`Z`.)

## Evaluation

The calculator program should evaluate each expression and print the result of the evaluation on a single line of output.  The result should be printed in the same format as the format for hexadecimal literals.

When the end of the input is reached, the calculator program should print a single line of output with the text `done` and then exit with a 0 exit code.

If the expression is an assignment to a variable, the variable's value should be updated with the result of evaluating the expression on the right hand side of the `=` token, and the overall result of the expression is the value assigned to the variable.

Note that there are two types of semantically invalid expressions:

* Subtractions where the difference would be negative
* Expressions which use undefined variables

For semantically invalid expressions, the calculator program should print the output `Invalid`.

Example session (used input in **bold**):

<div class="highlighter-rouge"><pre>
<b>0x7659d0baf6090671ef69a1ad8 - 0xa4141137377997dfd84c</b>
0x7659c679b4f592fa55eba428c
<b>foo = 0x2cfde7ad18e6fe1a9836877cdbb53c0cf21c200</b>
0x2cfde7ad18e6fe1a9836877cdbb53c0cf21c200
<b>foo * 0xcd81ffdef59348d2f157</b>
0x241e2b6f7447bb1c33cca0de044423db90836c05c13adf9c7c6501aee00
<b>foo + bar</b>
Invalid
<b>0xb08fd5e32a795dcd3832 - foo</b>
Invalid
done
</pre></div>

Note that after the final "`Invalid`" line was printed, the user typed Control-D to end the input to the program.

# Hints and suggestions

## Main loop, program logic

A main program loop that reads lines of text into an `std::string` variable is provided in `apcalc.cpp`.

You may implement the calculator functionality in whatever way you think would be best.

We suggest using an `std::stringstream` to divide each input line into tokens.

We also suggest using an `std::map` to keep track of the values of variables.

## Implementing multiplication

Multiplication is fairly easy to implement using `apint_lshift_n` and `apint_add`, as follows.

Any integer can be represented as the sum of powers of 2.  For example,

<blockquote>
37 = 32 + 4 + 1 = 2<sup>5</sup> + 2<sup>2</sup> + 2<sup>0</sup>
</blockquote>

Let's say we want to multiply another integer *m* by 37.  We can simply compute the sum of multiplying *m* by the powers of 2 that make up 37, as follows:

<blockquote>
37 × <i>m</i> = (2<sup>5</sup> × <i>m</i>) + (2<sup>2</sup> × <i>m</i>) + (2<sup>0</sup> × <i>m</i>)
</blockquote>

As we know, left shifting an integer's binary representation by *n* bits is equivalent to multiplying it by 2<sup><i>n</i></sup>.  This suggests an algorithm for multiplying arbitrary-precision integers *a* and *b*:

* Start with the result set to 0
* For each bit in the binary representation of *a*:
    * Compute a term by left shifting *b* by the bit position of the bit in *a*
    * Update the result by adding the term to its current value

The `apint.h` header file provided in the skeleton project suggests adding a function called `apint_is_bit_set` to test whether a bit at a specified position in an `ApInt` instance is set to 1.

## Things to watch out for

Two things to look out for include

* Shifts of 64 or greater are undefined for 64 bit types
* Shifts of 32 or greater are undefined for 32 bit types

Note that integer literals belong to the `int` data type, which is a 32 bit type on x84-64 Linux.  For example, the code

```c
1 << n
```

is undefined if `n` is 32 or greater.  If the goal is to create a 64 bit value, where shifts of 32 or more are meaningful, use the code

```c
1UL << n
```

## Testing

As with [Assignment 1](assign01.html), unit testing should be very helpful in testing the new functions you are implementing, such as `apint_is_bit_set` and `apint_mul`.

A Ruby program called `fakecalc.rb` is provided.  This program approximate the expected behavior of your `apcalc` program, and should be useful to check your program's results against.  Here is an example of running it (user input in **bold**):

<div class="highlighter-rouge"><pre>
$ <b>ruby ./fakecalc.rb</b>
<b>0x7659d0baf6090671ef69a1ad8 - 0xa4141137377997dfd84c</b>
0x7659c679b4f592fa55eba428c
<b>foo = 0x2cfde7ad18e6fe1a9836877cdbb53c0cf21c200</b>
0x2cfde7ad18e6fe1a9836877cdbb53c0cf21c200
<b>foo * 0xcd81ffdef59348d2f157</b>
0x241e2b6f7447bb1c33cca0de044423db90836c05c13adf9c7c6501aee00
</pre></div>

The autograder will test your `apcalc` program using a script, running it with a specific input file and then checking that the expected output was produced.  You can download the script and example input/output files by running the following commands:

```
mkdir -p input expected_output
curl -O https://jhucsf.github.io/fall2020/assign/assign07/example.in
mv example.in input
curl -O https://jhucsf.github.io/fall2020/assign/assign07/example.out
mv example.out expected_output
curl -O https://jhucsf.github.io/fall2020/assign/assign07/run_test.rb
chmod a+x run_test.rb
```

Next, run the script as follows:

```
./run_test.rb example
```

If you see the output `Program output matched expected output`, then your `apcalc` produced the expected output for the example input file.

If you have made changes to your ApInt code from Assignment 1, you may submit that code to the "UNGRADED ApInt Tester" assignment on Gradescope. This will not be evaluated as part of your final grade, and is just to help you debug your code as you prepare for Assignment 7. It is the same autograder as was used in Assignment 1.

# Submitting

To submit your work:

* Run the command `make solution.zip`
* Upload `solution.zip` to [Gradescope](https://www.gradescope.com/) as **Assignment 7 - Arbitrary-precision calculator**
* Please check the files you uploaded to make sure they are the ones you intended to submit

**Important**: Late submissions for this assignment will not be accepted!  Please plan accordingly.
