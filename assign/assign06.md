---
layout: default
title: "Assignment 6: Multithreaded network calculator"
---

**Due**: Tues, Dec 8th by 11pm

**Assignment type**: Pair (you may work with one partner, or do the assignment individually)

## Overview

In this assignment you will make your `calcServer` program from [Assignment 5](assign05.html)
multithreaded, so it can handle connections from multiple clients simultaneously.

Get started by making a copy of your code for Assignment 5 in a new directory.  You will
modify both `calcServer.c` and either `calc.cpp` or `calc.c` (depending on
whether you used C++ or C to implement the calculator functionality.)

## Goals of the assignment

The goals of the assignment are:

* Use threads to handle concurrent client connections
* Use synchronization to allow multiple threads to access shared data

## Grading rubric

Your grade will be determined as follows:

* Autograder tests of concurrent client connections: 65%
* `README.txt`, manual review of synchronization: 15%
* Design: 10%
* Coding style: 10%

There is also an extra credit option: if you can make your `calcServer`
program shut down cleanly after receiving a `shutdown` command from
a client, *exiting only after all client connections have finished*, you will
receive an extra 5 points.  Please note that we will only consider your
submission for the extra credit if it implements the base functionality
correctly.

## Your task

Your main tasks are (1) to use multiple threads to handle client connections,
and (2) to use synchronization to protect shared data.

### Using threads for client connections

In general, it makes sense for server applications to handle connections from
multiple clients simultaneously.  Threads are a useful mechanism for handling
multiple client connections because they allow the code which communicates
with each client to execute concurrently.

In your main server loop, create a thread for each accepted client connection.
Use `pthread_create` to create the client threads.  You can let the client
threads be detached (i.e., by having them call `pthread_detach` with their
own thread id.)  You do not need to place any upper limit on the number of
threads that can be active simultaneously (although in practice that's a
good idea.)

You can test that your server can handle multiple client sessions simultaneously
by running 2 (or more) `telnet` sessions connecting to the server.

Note that as with the server from [Assignment 5](assign05.html), all connections should share
a common `struct Calc` instance.  This means that a variable set by one client
is visible to other clients, and in fact, can be considered a simple form
of communication between clients.

The following screen capture shows two instances of telnet connecting to the
same `calcServer` (using [GNU Screen](https://www.gnu.org/software/screen/)
as a split-screen terminal):

<center>
<video width="720" controls>
  <source src="calcServer.webm" type="video/webm">
Your browser does not support the video tag.
</video>
</center>

### Using synchronization to protect shared data

Any time two thread access shared data, such that one or both threads
might modify the shared data, *synchronization* is typically necessary
to ensure the integrity of the shared data.

In your calculator server, the data structure you used to store the
values of variables (quite possibly an STL `map` object) will be accessed
by multiple client threads.  Without synchronization, this data structure
could be corrupted.

To allow safe access from multiple client threads, use a mutex or semaphore
to protect the shared data in your `struct Calc` implementation.  The following
guidelines should help you think about how you will need to modify your program:

* Your calculator data type (e.g., `class CalcImpl` if you used C++) will need
  to have a mutex or semaphore as a member variable (i.e., a
  variable whose type is `pthread_mutex_t` or `sem_t`)
* In initializing a calculator instance, the mutex or semaphore should be
  initialized (e.g., call `pthread_mutex_init` or `sem_init`)
* In destroying a calculator instance, the appropriate cleanup function
  (`pthread_mutex_destroy` or `sem_destroy`) should be called
* Any code accessing or modifying the data structure storing the values of
  variables should be executed with the mutex or semaphore held for exclusive
  access; this will cause threads to take turns accessing the shared data
  (achieving *mutual exclusion*)

Critical sections (regions of code where mutual exclusion is necessary)
should be protected with calls to `pthread_mutex_lock`/`pthread_mutex_unlock`
or `sem_wait`/`sem_post`.

Note that access to data that is either

* *not* shared between client threads, or
* is shared between client threads, but never modified

does not need to be protected.

**Important requirement**: In a file called `README.txt`, briefly describe
how you made the calculator instance's shared data safe to access from multiple
threads.  Indicate what kind of synchronization object you used, and how
you determined which regions of code were critical sections.

### Clean shutdown (extra credit!)

*You can ignore this section if you're not planning to try the extra
credit, although what's described here is useful stuff to think about
if you're interested in systems and network programming.*

One difficulty in implementing a multithreaded server is how to allow it
to shut down cleanly.

For `calcServer`, the problem is that when one client sends a `shutdown`
command, there could be other threads still running, and shutting down
the server would interrupt these connections.

For up to 10 points extra credit, you can implement the `shutdown`
command such that the server will exit

* after a `shutdown` command has been received from any client
* only after all currently-connected clients have finished

In addition, once a `shutdown` command has been received, `calcServer`
should not accept any further client connections.

Shutting down cleanly is fairly challenging.  Here are some
rough ideas that might be useful:

* Use a semaphore to keep track of the number of client threads
  (this will also allow you to limit the maximum number of simultanous
  client connections, which is good!)
* Use the `select` or `poll` system calls to do a timed wait for
  incoming client connections, rather than doing a blocking
  call to `accept`
* Use a `volatile` global variable to keep track of whether any client
  has requested a shutdown: loading and storing the value of a volatile
  global variable does not constitute a data race if, in its lifetime,
  the variable only transitions from one value to one other value
  (e.g., it's initially false, but some thread sets it to true at a later
  time)

The reason that calls to `accept` need to be nonblocking is because if the
server is stuck waiting for an incoming client connection, it might not
be aware that one of its currently-connected clients has requested a
shutdown.  By using a timed wait, the server can "wake up" periodically
in order to check the global shutdown variable.

### Testing

Here are some automated tests you can try.

Download the following files into the directory containing your `calcServer` executable:

* [test\_server\_concurrent1.sh](assign06/test_server_concurrent1.sh)
* [test\_server\_concurrent2.sh](assign06/test_server_concurrent2.sh)
* [test\_server\_concurrent\_stress.sh](assign06/test_server_concurrent_stress.sh)
* [test\_input.txt](assign06/test_input.txt)
* [conc\_test\_input1.txt](assign06/conc_test_input1.txt)
* [conc\_test\_input2.txt](assign06/conc_test_input2.txt)

You can download the above files from a terminal by running the following commands:

```bash
curl -O https://jhucsf.github.io/spring2020/assign/assign06/test_server_concurrent1.sh
curl -O https://jhucsf.github.io/spring2020/assign/assign06/test_server_concurrent2.sh
curl -O https://jhucsf.github.io/spring2020/assign/assign06/test_server_concurrent_stress.sh
curl -O https://jhucsf.github.io/spring2020/assign/assign06/test_input.txt
curl -O https://jhucsf.github.io/spring2020/assign/assign06/conc_test_input1.txt
curl -O https://jhucsf.github.io/spring2020/assign/assign06/conc_test_input2.txt
```

Make the scripts executable:

```bash
chmod a+x test_server_concurrent1.sh
chmod a+x test_server_concurrent2.sh
chmod a+x test_server_concurrent_stress.sh
```

**First test**: run the following commands:

```bash
./test_server_concurrent1.sh 30000 test_input.txt actual1.txt
cat actual1.txt
```

The output of the `cat` command should be:

```
2
3
5
```

This test tests that a long-running client does not prevent the server from handling an additional client connection.

**Second test**: run the following commands:

```bash
./test_server_concurrent2.sh 30000 conc_test_input1.txt actual1.txt conc_test_input2.txt actual2.txt
cat actual1.txt
cat actual2.txt
```

The output of the first `cat` command should be:

```
1
42
```

The output of the second `cat` command should be:

```
40
54
```

This test tests that two client sessions can interact with each other through commands accessing a shared variable.

**Third test**: run the following commands:

```bash
./test_server_concurrent_stress.sh 30000
cat final_count.txt
```

The file `final_count.txt` does not need to contain any specific value, but it will probably be somewhere between 200000 and 400000.

If you fully synchronized `calc_eval`, such that each expression is fully evaluated with the mutex held, the final count should be 400000.

The most important outcome of this test is that your server should not crash.

## Deliverables

You will need to make one modification to your `Makefile` from Assignment 5.  Change
the rule to build `solution.zip` from:

```make
solution.zip :
	zip -9r solution.zip *.c *.cpp *.h Makefile
```

to

```make
solution.zip :
	zip -9r solution.zip *.c *.cpp *.h Makefile README.txt
```

This change will ensure that your `README.txt` is submitted.

To submit your work, run the command

```
make solution.zip
```

and upload `solution.zip` to Gradescope as **Assignment6**.
