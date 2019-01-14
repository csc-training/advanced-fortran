COMP=cray
#COMP=gnu
#COMP=intel

ifeq ($(COMP),cray)
#export CRAY_CPU_TARGET=x86-64
FC=ftn
FCFLAGS=-efmw -target-cpu=sandybridge
LDFLAGS=
RUN=
endif

ifeq ($(COMP),gnu)
FC=gfortran
FCFLAGS=-std=f2008 -fbacktrace -g
RUN=
endif

ifeq ($(COMP),intel)
FC=ifort
FCFLAGS=-traceback -stand f08 -standard-semantics
RUN=
endif

EXE=typebound
OBJS=typebound_mod.o typebound.o

all:	$(EXE)

$(EXE): $(OBJS)
	$(FC) $(LDFLAGS) $(OBJS) -o $@

%.o: %.F90
	$(FC) $(FCFLAGS) -c $< -o $@

.SUFFIXES:
.SUFFIXES: .F90 .o

typebound.o: typebound_mod.o typebound.F90
typebound_mod.o: typebound_mod.F90

clean:
	@/bin/rm -f $(EXE) a.out *.o *.mod *~
