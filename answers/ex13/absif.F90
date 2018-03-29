program absif
  use, intrinsic :: iso_fortran_env, only : dp => REAL64
  implicit none

  integer, parameter :: n = 5

  ! Type definition
  type vector
     real(kind=dp), allocatable :: data(:)
  end type vector

  abstract interface
     function vecvecop(x,y) result(z)
       import
       type(vector), intent(in) :: x, y
       type(vector) :: z
     end function vecvecop
     function vecscalop(x,y) result(z)
       import
       type(vector), intent(in) :: x, y
       real(kind=dp) :: z
     end function vecscalop
  end interface

  integer :: i
  type(vector) :: v1, v2, v3

  v1 = vector([(i,i=1,n)])
  v2 = vector([(n-i+1,i=1,n)])

  print *,'vecsum'
  v3 = vecsum(v1,v2)
  print '(*(F8.3))',v3 % data
  ! Same computation with abstract interface
  print *,'vecfun(vecsum)'
  v3 = vecfun(vecsum,v1,v2)
  print '(*(F8.3))',v3 % data
  print *,'vecprod'
  v3 = vecprod(v1,v2)
  print '(*(F8.3))',v3 % data
  ! Same computation with abstract interface
  print *,'vecfun(vecprod)'
  v3 = vecfun(vecprod,v1,v2)
  print '(*(F8.3))',v3 % data
  print *,'vecdotprod'
  print *,vecdotprod(v1,v2)
  ! Same computation with abstract interface
  print *,'scalfun(vecdotprod)'
  print *,scalfun(vecdotprod,v1,v2)

contains

  function vecfun(fun,x,y) result(z)
    implicit none
    procedure(vecvecop) :: fun
    type(vector), intent(in) :: x, y
    type(vector) :: z

    z = fun(x,y)
  end function vecfun

  function scalfun(fun,x,y) result(z)
    implicit none
    procedure(vecscalop) :: fun
    type(vector), intent(in) :: x, y
    real(kind=dp) :: z

    z = fun(x,y)
  end function scalfun

  function vecsum(x,y) result(z)
    implicit none

    type(vector), intent(in) :: x, y
    type(vector) :: z
    integer :: i

    allocate(z % data(size(x % data)))
    do i = 1, size(x % data)
       z % data(i) = x % data(i)+y % data(i)
    end do

  end function vecsum

  function vecprod(x,y) result(z)
    implicit none

    type(vector), intent(in) :: x, y
    type(vector) :: z
    integer :: i

    allocate(z % data(size(x % data)))
    do i = 1, size(x % data)
       z % data(i) = x % data(i)*y % data(i)
    end do
  end function vecprod

  function vecdotprod(x,y) result(z)
    implicit none

    type(vector), intent(in) :: x, y
    real(kind=dp) :: z
    integer :: i

    z = 0_dp
    do i = 1, size(x % data)
       z = z + x % data(i)*y % data(i)
    end do
  end function vecdotprod

end program absif
