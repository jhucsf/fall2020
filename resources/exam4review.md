---
layout: default
title: "Exam 4 practice questions"
---

# Exam 4 practice questions

## A. Unix I/O

**A1)** Consider the following server main loop:

```c
int server_fd = Open_listenfd(port);

while (1) {
  int client_fd = Accept(server_fd, NULL, NULL);
  int pid = Fork();
  if (pid == 0) {
    // in child
    chat_with_client(client_fd);
    exit(0);
  }
}
```

Assume that

* `Open_listenfd`, `Accept`, and `Fork` are functions from `csapp.h` and `csapp.c`.
* the `chat_with_client` function correctly handles all details of communicating with the remote client
* the main server process has a handler for `SIGCHLD` to wait for child processes to exit
* the server does not place any limit on how many client sub-processes can be running

Describe a bug in this main loop, and how to fix it.

## B. Network communication

Coming soon

## C. Concurrency

Coming soon
