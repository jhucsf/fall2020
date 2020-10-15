---
layout: default
title: "Exam 2 practice questions"
---

# Exam 2 practice questions

## A: x86-64

TODO

## B: Code optimization, performance

B1)

Consider the following function:

```c
// combine a collection of strings into a single string
char *combine(const char *strings, unsigned num_strings) {
  // determine amount of space needed
  size_t total_size = 0;
  for (unsigned i = 0; i < num_strings; i++) {
    total_size += strlen(strings[i]);
  }

  // allocate buffer large enough for all strings
  char *result = malloc(total_size + 1);

  // copy the data into the buffer
  result[0] = '\0';
  for (unsigned i = 0; i < num_strings; i++) {
    strcat(result, strings[i]);
  }

  return result;
}
```

Explain the performance problem with this function and how to fix it.

B2)

Consider the following C code (assume that all variables have the type
`uint64_t`):

```c
a = b * c;
d = e * f;
g = h * i;
j = a * d * g;
```

Assume that all of the variables refer to CPU registers, and that
the CPU has two integer multipliers, each of which is fully pipelined, and
can execute a single instruction in 3 cycles.  What is the mininum
number of cycles required for the computation to complete?

## C: Caches

TODO
