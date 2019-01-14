## Heat equation solver

The heat equation is a partial differential equation that describes
the variation of temperature in a given region over time

<p align="center"><img src="images/heateqn_eq1.svg?invert_in_darkmode" align="middle" width="84pt" height="33.8pt"/></p>
	
where u(x, y, z, t) represents temperature variation over space at a
given time, and α is a thermal diffusivity constant.  We limit
ourselves to two dimensions (plane) and discretize the equation onto a
grid.  Then the Laplacian can be expressed as finite differences as

<p align="center"><img src="images/heateqn_eq2.svg?invert_in_darkmode" align="middle" width="579pt" height="38.8pt"/></p>

Where ∆x and ∆y are the grid spacing of the temperature grid
u(i,j). We can study the development of the temperature grid with
explicit time evolution over time steps ∆t:

<p align="center"><img src="images/heateqn_eq3.svg?invert_in_darkmode" align="middle" width="276pt" height="18.3pt"/></p>

There are a solver for the 2D equation implemented with Fortran
(including some C for printing out the images). You can compile the
program by adjusting the Makefile as needed and typing “make”.  The
solver carries out the time development of the 2D heat equation over
the number of time steps provided by the user. The default geometry is
a flat rectangle (with grid size provided by the user), but other
shapes may be used via input files - a bottle is give as an
example. Examples on how to run the binary:

1. `./heat` (no arguments - the program will run with the default
arguments: 256x256 grid and 500 time steps)
2. `./heat bottle.dat` (one argument - start from a temperature grid
provided in the file bottle.dat for the default number of time steps)
3. `./heat bottle.dat 1000` (two arguments - will run the program
starting from a temperature grid provided in the file bottle.dat for
1000 time steps)
4. `./heat 1024 2048 1000` (three arguments - will run the program in
a 1024x2048 grid for 1000 time steps)
