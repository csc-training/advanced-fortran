COMP=cray
#COMP=gnu

ifeq ($(COMP),cray)
#export CRAY_CPU_TARGET=x86-64
FC=ftn
FCFLAGS=-efmw -target-cpu=sandybridge
CC=cc
CFLAGS=-target-cpu=sandybridge
endif

ifeq ($(COMP),gnu)
FC=gfortran
FCFLAGS=-std=f2008 -fbacktrace -g
CC=gcc
CFLAGS=-g
endif

ifeq ($(COMP),intel)
FC=ifort
FCFLAGS=-assume realloc_lhs -assume byterecl -traceback -stand f08
CC=icc
CFLAGS=-traceback
endif

EXE1=callc
OBJS1=callc.o cfunc.o

ALL_EXES=$(EXE1) $(EXE2) $(EXE3)

$(EXE1): $(OBJS1)
	$(FC) $(OBJS1) -o $@

.SUFFIXES:
.SUFFIXES: .F90 .o .c

callc.o:	callc.F90 cfunc.o
cfunc.o:	cfunc.c

.F90.o:
	$(FC) $(FCFLAGS) -c $<

.c.o:
	$(CC) $(CFLAGS) -c $<

clean:
	@/bin/rm -f $(ALL_EXES) a.out *.o *.mod *~
