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

EXE3=getenv
OBJS3=getenv.o asgn.o

ALL_EXES=$(EXE3)

$(EXE3): $(OBJS3)
	$(FC) $(OBJS3) -o $@

.SUFFIXES:
.SUFFIXES: .F90 .o .c

asgn.o:		asgn.F90
getenv.o:	getenv.F90 asgn.o

.F90.o:
	$(FC) $(FCFLAGS) -c $<

.c.o:
	$(CC) $(CFLAGS) -c $<

clean:
	@/bin/rm -f $(ALL_EXES) a.out *.o *.mod *~
