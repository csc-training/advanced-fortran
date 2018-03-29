module points

interface
  function intfun(x, param) result(y) ! TODO: write contents
  end function
end interface

type ft
  ! TODO: write type declaration
end type

contains

function map(f, x) result(y) ! TODO: write contents
  type(ft) :: f
  ! TODO: write missing
end function 

end module

program procpoint
use points
implicit none

type(ft) :: pptr(6)
integer :: n
pptr(1:3) = [ (ft(add_param, n), n=1,3) ]
pptr(4:6) = [ (ft(sub_param, n), n=1,3) ]

do n=1,6
  print *, 'map(pptr(n), [1,2,3,4]) =', map(pptr(n), [1,2,3,4]), ', n = ', n
end do

contains

function add_param(x,param) result(y)
  integer, intent(in) :: x, param
  integer :: y
  y = x+param
end function

function sub_param(x,param) result(y)
  integer, intent(in) :: x, param
  integer :: y
  y = x-param
end function


end program
