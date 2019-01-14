## Accessing global C data from Fortran

1. Modify Fortran module file `globalmod.F90` to map C
   variables correctly to Fortran representation.
1. Repeat run with Intel compiler, too and realize that the C
   struct may not be optimal from data alignment point of view. Fix
   the alignment in C-code make sure Fortran gets corrected, too.
1. Fix the Fortran main program `global.F90` to get a correct
   C-to-F pointer mapping.
