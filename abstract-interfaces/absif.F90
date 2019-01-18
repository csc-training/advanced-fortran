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
       ! TODO: Add function that takes two arguments of type "vector"
       !       and returns a "vector"
     end function vecvecop
     function vecscalop(x,y) result(z)
       ! TODO: Add function that takes two arguments of type "vector"
       !       and returns a scalar
     end function vecscalop
  end interface

  integer :: i
  type(vector) :: v1, v2, v3


  ! TODO: Allocate and initialize v1 to [1,2,3,4,5]
  ! TODO: Allocate and initialize v2 to [5,4,3,2,1]

  print *,'vecsum'
  v3 = vecsum(v1,v2)
  print '(*(F8.3))',v3 % data
  ! Same computation with abstract interface
  print *,'vecfun(vecsum)'
  ! TODO: Add here the call to vecfun

  print '(*(F8.3))',v3 % data
  print *,'vecprod'
  v3 = vecprod(v1,v2)
  print '(*(F8.3))',v3 % data
  ! Same computation with abstract interface
  print *,'vecfun(vecprod)'
  ! TODO: Add here the call to vecfun

  print '(*(F8.3))',v3 % data
  print *,'vecdotprod'
  print '(F8.3)',vecdotprod(v1,v2)
  ! Same computation with abstract interface
  print *,'scalfun(vecdotprod)'
  ! TODO: Add here the call to scalfun

contains

  function vecfun(fun,x,y) result(z)
    implicit none
    ! TODO: implement this
  end function vecfun

  function scalfun(fun,x,y) result(z)
    implicit none
    ! TODO: implement this
  end function scalfun

  function vecsum(x,y) result(z)
    implicit none

    type(vector), intent(in) :: x, y
    type(vector) :: z
    integer :: i

    ! TODO: implement this
  end function vecsum

  function vecprod(x,y) result(z)
    implicit none

    type(vector), intent(in) :: x, y
    type(vector) :: z
    integer :: i

    ! TODO: implement this
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
