---
layout: default
title: "Assignment 1: Arbitrary-precision arithmetic"
---

**Due:** Tuesday, September 15th by 11pm

# Overview

In this assignment you will implement a simple C library for arbitrary-precision integer arithmetic.

The grading breakdown is as follows:

* Impementation of data type and functions: 60%
* Unit tests: 30%
* Design and coding style: 10% (see the [style guidelines](style.html))

## Getting started

Download [csf\_assign01.zip](csf_assign01.zip), which contains the skeleton code for the assignment.

You can download this file from a Linux command prompt using the `curl` command:

```bash
curl -O https://jhucsf.github.io/fall2020/assign/csf_assign01.zip
```

Note that in the `-O` option, it is the letter "O", not the numeral "0".

# Arbitrary-precision integer arithmetic

As you know from the material we have been covering, including Chapter 2 of the textbook, the hardware-supported numeric data types are *finite*, meaning that only a finite set of values can be directly represented using those data types.  Most programming languages (such as C, C++, and Java) use hardware numeric data types to implement their primitive numeric types (`int`, `long`, `double`, etc.)  As you have seen, the finite nature of machine data types leads to some odd situations, such as the existence of values *a* and *b* such that

> *a ≥ 0*

> *b ≥ 0*

> *a + b &lt; a*

The above inequalities could be true if, for example, the sum *a + b* is too large to represent using the data type to which *a* and *b* belong.

Some applications, such as cryptographic applications, need to represent values which behave like mathematical integers, in which case the machine integer data types can't be used directly.  Some programming languages, notably languges in the LISP family, have first-class support for arbitrary-precision integers (often referred to as "bignums".)  For programming languages without such support, having an arbitrary-precision integer data type can be very useful.

## Bit strings

Arbitrarily large integer values can be represented as bit strings.  For example, the decimal value

> 159114774885074890108

can be represented by the bit string

> 10001010000000101001001111001011101101010101001000100110110101111100

Note that 68 bits are required to represent this particular integer value, and that the highest bit set to 1 is the one representing 2<sup>67</sup>.

Hexadecimal (base 16) notation is convenient for working with bit strings, because each hex "digit" represents exactly 4 bits of information.  The value shown above, represented in hexadecimal, is

> 8A0293CBB55226D7C

# The `ApInt` data type

An instance of the `ApInt` data type (**A**rbitrary **p**recision **Int**eger) represents an arbitrary nonnegative integer value.

The `ApInt` data type is defined as follows (in the header file **apint.h**):

```c
typedef struct {
    /* TODO: representation */
} ApInt;
```

So, `ApInt` is a typedef (alias) for an unnamed struct type.  You will need to add fields to the unnamed struct type so that an allocated instance of `ApInt` can represent any nonnegative integer value.

Because `ApInt` instances can represent any arbitrarily-large integer value, they can require an arbitrary amount of memory, and so are accessed via pointers (so that their representations can be allocated dynamically.)

A set of functions is defined to allow a program to create, use, and destroy instance of `ApInt`.  All of these functions have named beginning with `apint`.  (It is a good practice when designing APIs for C programs to use a common naming prefix for functions associated with a particular data type.)  These functions are:

```c
ApInt *apint_create_from_u64(uint64_t val);
ApInt *apint_create_from_hex(const char *hex);
void apint_destroy(ApInt *ap);
uint64_t apint_get_bits(ApInt *ap, unsigned n);
int apint_highest_bit_set(ApInt *ap);
ApInt *apint_lshift(ApInt *ap);
ApInt *apint_lshift_n(ApInt *ap, unsigned n);
char *apint_format_as_hex(ApInt *ap);
ApInt *apint_add(const ApInt *a, const ApInt *b);
ApInt *apint_sub(const ApInt *a, const ApInt *b);
int apint_compare(const ApInt *left, const ApInt *right);
```

Note that all of the functions declared as returning `ApInt *` must return a pointer to a dynamically allocated instance of `ApInt` that will be deallocated by a subsequent call to `apint_destroy`.

Here are brief descriptions of the expected behavior of these functions.

`apint_create_from_u64`: Returns a pointer to an `ApInt` instance whose value is specified by the `val` parameter, which is a 64-bit unsigned value.

`apint_create_from_hex`: Returns a pointer to an `ApInt` instance whose value is specified by the `hex` parameter, which is an arbitrary sequence of hexadecimal (base 16) digits.  This function should accept both the lower-case letters `a` through `f` and the upper-case letters `A` through `F` as the hex digits with values 10 through 15.

`apint_destroy`: Deallocates the memory used by the `ApInt` instance pointed-to by the `ap` parameter.

`apint_get_bits`: Returns a `uint64_t` value containing 64 bits of the binary representation of the `ApInt` instance pointed to by `ap`.  The parameter `n` indicates which bits to return.  If `n` is 0, bits 0..63 are returned, if `n` is 1 bits 64..127 are returned, etc.  The function should be prepared to handle arbitrarily large values of `n`.

`apint_highest_bit_set`: Returns the position of the most significant bit set to 1 in representation of the `ApInt` pointed to by `ap`. As a special case, returns -1 if the `ApInt` instance pointed to by `ap` represents the value 0.

`apint_lshift`: Returns a pointer to an `ApInt` instance formed by shifting each bit of the `ApInt` instance pointed to by `ap` one bit position to the left.

`apint_lshift_n`: Returns a pointer to an `ApInt` instance formed by shifting each bit of the `ApInt` instance pointed to by `ap` *n* bit positions to the left.  **Important**: your implementation of this function should *not* involve calling `apint_lshift` in a loop.


`apint_format_as_hex`: Returns a pointer to a dynamically-allocated C character string containing the hexadecimal (base 16) digits of the representation of the `ApInt` instance pointed to by `ap`.  Note that the hex digits representing the values 10 through 15 should be *lower-case* `a` through `f`.  The string returned should not have any leading zeroes, except in the special case of the `ApInt` instance representing the value 0, in which case the returned string should consist of a single `0` digit.

`apint_add`: Computes the sum `a` plus `b`, and returns a pointer to an `ApInt` instance representing the sum.

`apint_sub`: Computes the difference `a` minus `b`, and returns a pointer to an `ApInt` instance representing the difference.  As a special case, if `b` is greater than `a`, returns `NULL` (since the `ApInt` data type cannot represent a negative value.)

`apint_compare`: Compares the values represented by the `ApInt` instances pointed-to by the parameters `left` and `right`.  Returns a negative value if `left` is less that `right`, a positive value if `left` is greater than `right`, and 0 if the values are equal.

# Tasks

This section explains the tasks you are responsible for completing.  Note that they aren't meant to be strictly sequential, although you will need to handle [Task 1](#task-1-determine-a-data-representation) before proceeding to [Task 2](#task-2-function-implementation) and [Task 3](#task-3-unit-testing).

## Task 1: Determine a data representation

You will need to determine a suitable data representation for `ApInt` values by specifying fields within the `ApInt` data type.

The basic idea is that the bit string required to represent the numeric value of an `ApInt` instance is stored in a variable-length array of fixed-precision integer values.

The representation should be reasonably space efficient.  For example, an array of `uint32_t` or `uint64_t` values, such that the bits of the overall integer value are packed into the array elements, would be a space-efficient representation, because at most some small number (63 or fewer) of bits per instance would be "wasted" (by being leading 0 bits in the array element representing the most significant chunk of the bit string.)  In contrast, representing the numeric value using hexadecimal digits stored n an array of `char` values would *not* be a space-efficient representation, since each `char` element would store one of only 16 possible values, wasting half of the bits in the array.

Note that you could represent the value using an array of small (8 or 16 bit) integer elements.  However, the `apint_add` and `apint_sub` functions can be implemented more efficiently if they can operate on larger chunks of data.

The `ApInt` representation should have a way of keeping track of the length of the array storing the bit string.  The idea is that `ApInt` values requiring more bits to represent will (in general) require more storage.  The functions which operate on `ApInt` values will need to know the array length of each `ApInt` instance.

## Task 2: Function implementation

Your main task is to implement all of the required functions as described above.

Note that as you work on the functions, you should also work on the unit tests!  So, this task and [Task 3](#task-3-unit-testing) should be done in parallel.

Here are a few hints.

Use the `assert` macro to verify preconditions, postconditions, and invariants: assertions are a great way of catching logic errors in your code before they cause a crash or incorrect results

Start with the simpler functions (such as `apint_create_from_u64` and `apint_destroy`), verify that they are working completely by writing unit tests, then move on to more complex functions (such as `apint_lshift_n` and `apint_add`)

Getting the `apint_create_from_hex` and `apint_format_as_hex` functions to work is an important milestone because they allow your test code to easily create and verify arbitrarily large integer values

## Task 3: Unit testing

Whenever you develop data types and their associated operations, it is extremely important to have confidence that they behave correctly.  Unit tests are a very effective way to test the behavior of functions to make sure they meet their specfications.

In this assignment, you will use a simple unit testing framework for C code called [TCTest](https://github.com/daveho/tctest).  You can read the [README](https://github.com/daveho/tctest/blob/master/README.md) and [demo program](https://github.com/daveho/tctest/blob/master/demo.c) for specific information about how it works, but if you've used unit testing frameworks such as [JUnit](https://junit.org), it should be fairly straightforward.

The basic idea is to create instances of `ApInt` that can be used to test the various functions: these objects form the *test fixture*.  Then, test methods carry out function calls on the test fixture objects (potentially creating new instances of `ApInt` as intermediate results), and use assertions to check that the observed behavior matches the expected behavior.

The `apintTests.c` source file contains the test program that will contain your unit tests.  Some minimal test code is provided; you should improve the tests by adding new test fixture objects and test methods.  To compile and run the test program, use the following commands:

```bash
# compile the tests
make depend
make apintTests

# run the tests
./apintTests
```

Note that the command `./apintTests` runs all of the test functions.  You can run a specific test function by specifying its name as a command line argument: for example,

```bash
./apintTests testCreateFromU64
```

When you run the test program, you will see output indicating which tests passed and failed.  A test will fail if

* a test assertion (using the `ASSERT` macro) fails
* a C language assertion (using the `assert` macro) fails
* a runtime exception such as a segmentation fault or floating point exception occurs

Here are some guidelines and hints to help you develop effective unit tests.

*Test the simpler functions first.*  A good place to start is the `apint_create_from_u64` and `apint_get_bits` functions.

*Test every function.*  Your unit tests should test each of the `ApInt` functions thoroughly.

*Test corner cases.*  Test for situations such as:

* Operations on `ApInt` values with varying bit string lengths
* Left shifts of varying lengths
* Adding `ApInt` instances with different-length bit strings

*Generate test cases programmatically.*  Write a script or program to generate large random integer values in hexadecimal format, generate test code to test operations on these values, and add them to your unit test program.  For example, here is a script-generated test for the `apint_add` function:

```c
a = apint_create_from_hex("7e5ff912c8ede6ccff0d56ae5a9b5459804f9");
b = apint_create_from_hex("6057bccd860546f03fd51bf5488d50cca96");
sum = apint_add(a, b);
ASSERT(0 == strcmp("7ec050cf9673ec13ef4d2bca4fe3e1aa4cf8f",
       (s = apint_format_as_hex(sum))));
apint_destroy(sum);
apint_destroy(b);
apint_destroy(a);
free(s);
```

As part of generating tests, it will be helpful to have a language or tool that can do arbitrary-precision arithmetic.  Options include Python and the Unix `bc` program.

[genfact.rb](genfact.rb) is a Ruby program which generates arithmetic facts that you can use for testing.  Run it as follows:

```bash
ruby genfact.rb
```

It will output an addition fact, subtraction fact, or inequality.  You can take the generated fact and turn it into a test case.  For example, the inequality

```
962d7e839ed2d377 < 8e11539c5ea7a510656b3fcc5403c83b91229139ab28bce
```

could be converted into the following test code:

```c
a = apint_create_from_hex("962d7e839ed2d377");
b = apint_create_from_hex("8e11539c5ea7a510656b3fcc5403c83b91229139ab28bce");
ASSERT(apint_compare(a, b) < 0);
apint_destroy(b);
apint_destroy(a);
```

The script-generated addition fact

```
d4fa6f0b63ad80a34b93b74d + 3935dcebf95bdf = d4fa6f0b63e6b680378d132c
```

could be converted into the following test code:

```c
a = apint_create_from_hex("d4fa6f0b63ad80a34b93b74d");
b = apint_create_from_hex("3935dcebf95bdf");
sum = apint_add(a, b);
ASSERT(0 == strcmp("d4fa6f0b63e6b680378d132c", (s = apint_format_as_hex(sum))));
apint_destroy(sum);
apint_destroy(b);
apint_destroy(a);
free(s);
```

Feel free to use [genfact.rb](genfact.rb) as a basis for generating unit tests.

*Use gdb to investigate bugs.* When a test fails, use `gdb` to help determine the reason for the failure.  Set breakpoints at the program location just prior to the point where the program state becomes corrupted.  Single step and inspect variables to understand what the code is doing.

*Use valgrind to check memory use.* The [valgrind](http://www.valgrind.org/) tool is enormously useful for making sure your code does not contain memory errors such as

* use of uninitialized values
* out of bounds memory accesses
* memory leaks
* double free errors

To run valgrind, on your test program, the command is `valgrind ./apintTests`.

# Submitting

To submit your work:

* Run the command `make solution.zip`
* Upload `solution.zip` to [Gradescope](https://www.gradescope.com/) as **Assignment 1 - Arbitrary-precision arithmetic**
* Please check the files you uploaded to make sure they are the ones you intended to submit

## Autograder

When you upload your submission to Gradescope, it will be tested by the autograder, which executes unit tests for each required function.  Please note the following:

* Only the "Impementation of data type and functions" rubric item is autograded
* If your code does not compile successfully, all of the tests will fail
* The autograder runs `valgrind` on your code, but it does *not* report any information about the result of running `valgrind`: points will be deducted if your code has memory errors or memory leaks!
