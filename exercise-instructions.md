## General exercise instructions

### Computing servers

We will use CSC’s Cray XC40 supercomputer Sisu for the exercises. Log onto Sisu
using the provided tnrgXX username and password, e.g.

``` shell
% ssh –X trng10@sisu.csc.fi
```

For editing program source files you can use e.g. Emacs editor with or
without (the option `–nw`) X-Windows:

``` shell
module load emacs
emacs –nw prog.F90 emacs prog.F90
```

Other popular editors (vim, nano) are also available.

### Simple compilation and execution

Compilation and execution are done via the `ftn` (and `cc` for C
programs as needed) wrapper commands and the aprun scheduler:

``` shell
% ftn –o my_exe test.F90
% cc –o my_C_exe test.c
% aprun –n 1 ./my_exe
```

We will use the default Cray compiling environment. There are also
other compilers (GNU and Intel) available on Sisu, which can be
changed (for example) as

``` shell
% module swap PrgEnv-cray PrgEnv-gnu
```

Use the commands `module list` and `module avail` to see the currently
loaded and available modules, respectively.  When requiring multiple
cores (in case of coarrays exercises), just increment the –n switch
for `aprun`, e.g. `–n 4` for running with 4 images.

### Skeleton codes

For most of the exercises, skeleton codes are provided in the
exercises folder, under a corresponding subdirectory. Generally, you
should look for sections marked with “TODO” for completing the
exercises.
