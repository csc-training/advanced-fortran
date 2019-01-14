program callc

  use, intrinsic :: iso_c_binding

  implicit none

  interface
     ! double DotProduct(int n, const double x[], const double y[])
     function dotp(n, x, y) bind(c, name='DotProduct')
       use, intrinsic :: iso_c_binding
       implicit none
       integer(kind=c_int), value :: n
       real(kind=c_double), intent(in) :: x(*), y(*)
       real(kind=c_double) :: dotp
     end function dotp
  end interface

  real(kind=c_double), allocatable :: x(:), y(:)

  x = real([ 1, 2, 3, 4, 5], c_double)
  y = x

  print *, 'dot product = ', dotp(size(x), x, y)

end program callc
