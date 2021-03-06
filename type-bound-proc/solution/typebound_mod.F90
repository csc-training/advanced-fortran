module typebound_mod
  use, intrinsic :: iso_fortran_env, only : dp => REAL64
  implicit none

  ! Type definition
  type vector
     real(kind=dp), allocatable :: data(:)
   contains
     procedure :: sum => vecsum
     procedure :: prod => vecprod
     procedure :: dot => vecdotprod
     generic :: operator(+) => sum
     generic :: operator(.prod.) => prod
     generic :: operator(*) => dot
  end type vector

contains

  function vecsum(x, y) result(z)
    implicit none

    class(vector), intent(in) :: x, y
    type(vector) :: z
    integer :: i

    allocate(z % data(size(x % data)))
    do i = 1, size(x % data)
       z % data(i) = x % data(i) + y % data(i)
    end do

  end function vecsum

  function vecprod(x, y) result(z)
    implicit none

    class(vector), intent(in) :: x, y
    type(vector) :: z
    integer :: i

    allocate(z % data(size(x % data)))
    do i = 1, size(x % data)
       z % data(i) = x % data(i) * y % data(i)
    end do
  end function vecprod

  function vecdotprod(x, y) result(z)
    implicit none

    class(vector), intent(in) :: x, y
    real(kind=dp) :: z
    integer :: i

    z = 0_dp
    do i = 1, size(x % data)
       z = z + x % data(i) * y % data(i)
    end do
  end function vecdotprod

end module typebound_mod
