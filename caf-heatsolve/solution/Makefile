COMP=cray

ifeq ($(COMP),cray)
CC=cc
FC=ftn 
CCFLAGS=
FCFLAGS=-dynamic -efmw
CAF_FLAG=-h caf
endif

ifeq ($(COMP),gnu)
CC=gcc
FC=gfortran
CCFLAGS=-Wall
FCFLAGS=-Wall
CAF_FLAG=-fcoarray=single
endif

ifeq ($(COMP),intel)
CC=icc
FC=ifort
CCFLAGS=
FCFLAGS=
CAF_FLAG=-coarray
endif

EXE_SERIAL=heat_serial
EXE_COARRAY=heat_coarray
OBJS_SERIAL=heat_serial.o heat_serial_main.o
OBJS_COARRAY=heat_coarray.o heat_coarray_main.o
OBJS_PNG=pngwriter.o
OBJS_PNGF=pngwriter_mod.o 
LIBS=-lpng

serial: $(EXE_SERIAL)

parallel: $(EXE_COARRAY)

all: $(EXE_SERIAL) $(EXE_COARRAY)

pngwriter.o: pngwriter.c
pngwriter_mod.o: pngwriter_mod.F90
heat_serial.o: heat_serial.F90 pngwriter_mod.o pngwriter.o
heat_serial_main.o: heat_serial_main.F90 heat_serial.F90
heat_coarray.o: heat_coarray.F90 pngwriter_mod.o pngwriter.o
heat_coarray_main.o: heat_coarray_main.F90 heat_coarray.F90

$(OBJS_SERIAL): F_COMPILER := $(FC)
$(OBJS_PNGF): F_COMPILER := $(FC)
$(OBJS_COARRAY): F_COMPILER := $(FC) $(CAF_FLAG)

$(EXE_SERIAL): $(OBJS_SERIAL) $(OBJS_PNG) $(OBJS_PNGF)
	$(FC) $(FCFLAGS) $(OBJS_SERIAL) $(OBJS_PNG) $(OBJS_PNGF) -o $@ $(LIBS)

$(EXE_COARRAY): $(OBJS_COARRAY) $(OBJS_PNG) $(OBJS_PNGF)
	$(FC) $(CAF_FLAG) $(FCFLAGS) $(OBJS_COARRAY) $(OBJS_PNG) $(OBJS_PNGF) -o $@ $(LIBS)

%.o: %.F90
	$(F_COMPILER) $(FCFLAGS) -c $< -o $@

%.o: %.c
	$(CC) $(CCFLAGS) -c $< -o $@

clean:
	-/bin/rm -f $(EXE_SERIAL) $(EXE_COARRAY) a.out *.o *.mod *.png *~
