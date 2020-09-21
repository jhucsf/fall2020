---
layout: default
title: "Resources"
category: "resources"
---

This page has links to useful resources.

# Information

This section has links to some information resources you might find useful.

## Practice exams

* [Midterm, Spring 2020](resources/midterm-spring2020.pdf)

## x86-64 assembly programming resources

* [Brown x64 cheat sheet](https://cs.brown.edu/courses/cs033/docs/guides/x64_cheatsheet.pdf)
* [Brown gdb cheat sheet](https://cs.brown.edu/courses/cs033/docs/guides/gdb.pdf)
* [CMU summary of gdb commands for x86-64](http://csapp.cs.cmu.edu/3e/docs/gdbnotes-x86-64.pdf)

# Exercises and practice problems

This section links to exercises, practice problems, and similar resources.

* [Exam 1 practice questions](resources/exam1review.html)
* [Assembly language exercise](exercise/assembly.html), [solution](exercise/asmExerciseSoln.zip)
* [Assembly language exercise 2 (more challenging)](exercise/assembly2.html)
* [Assembly language mini-exercises](exercise/assemblyMini.html)

# Software

This section covers the software you'll be using in working on programming assignments.

## Linux

For the programming assignments, you will need to use a recent x86-64 (64 bit) version of Linux.

Any of the computers that are part of the [Ugrad
net](https://support.cs.jhu.edu/wiki/Linux_Clients_on_the_CS_Undergrad_Net)
will work reasonably well, although the compiler versions will not
necessarily be the same ones that Gradescope uses.  You can use ssh to
connect to one of these computers via the network.

If you are planning to use your own computer for development,
we *highly* recommend using some flavor of Ubuntu 18.04.  If your
computer is running Windows or MacOS, and you would still like to do
development on your own machine, one excellent option is to install
[VirtualBox](https://www.virtualbox.org) on your computer, and then
download one of the following Virtual Machine images:

> [Ubuntu MATE 18.04 for CSF.ova](https://drive.google.com/file/d/13rsQzOWNvAW3AIIC6M-BcoNRDYgdwcYA/view?usp=sharing) (3.6 GB download: username `csf`, password `csf`)

> [Lubuntu 18.04 for CSF.ova](https://drive.google.com/file/d/1ohKmrl7sH1P9zsPIUV6ZzkEukgATdH81/view?usp=sharing) (2.6 GB download: username `csf`, password `csf`)

The second (Lubuntu) image is configured with a smaller virtual hard disk, and
might work better if your disk space is limited.

The above VM images have all of the software you will need to work on
assignments in CSF, and they more or less exactly match the environment
used by Gradescope autograders.

After you've downloaded one of the images above, use **File** → **Import Appliance**
within VirtualBox, select the `.ova` file, wait for the import to complete,
then you should be able to start and run the VM.  Note that VirtualBox will
require that your CPU's hardware virtualization features are enabled.
If you see a message about CPU virtualization not being enabled, you should
be able to reboot your computer, enter the BIOS configuration, and enable
the CPU virtualization features.

## Tools

Some of the tools you'll want to have are:

* gcc
* g++
* make
* ruby
* valgrind
* git

All of these are available by default on the Ugrad computers.

To install on an Ubuntu-based system:

> <code class="cmd">sudo apt-get install gcc g++ make ruby valgrind git</code>

To install on a Fedora system:

> <code class="cmd">sudo yum install gcc g++ make ruby valgrind git</code>
