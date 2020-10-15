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

TODO

## C: Caches

TODO
