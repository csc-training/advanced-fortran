program callc

  use, intrinsic :: iso_c_binding

  implicit none

  interface
     ! double DotProduct(int n, const double x[], const double y[])
     ! TODO: Add here interface for the C function DotProduct.
     !       The function is defined in file cfunc.c
  end interface

  real(kind=c_double), allocatable :: x(:), y(:)

  x = real([ 1, 2, 3, 4, 5], c_double)
  y = x

  print *, 'dot product = ', dotp(size(x), x, y)

end program callc
