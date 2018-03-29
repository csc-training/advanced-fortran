COMP=cray
#COMP=gnu
#COMP=intel

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

EXE=global
OBJS=global.o cdata.o globalmod.o

$(EXE): $(OBJS)
	$(FC) $(OBJS) -o $@

.SUFFIXES:
.SUFFIXES: .F90 .o .c

globalmod.o:	globalmod.F90 cdata.o
global.o:	global.F90 globalmod.o
cdata.o:	cdata.c

.F90.o:
	$(FC) $(FCFLAGS) -c $<

.c.o:
	$(CC) $(CFLAGS) -c $<

clean:
	@/bin/rm -f $(EXE) a.out *.o *.mod *~
