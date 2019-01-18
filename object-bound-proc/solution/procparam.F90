module points

  ! This interface should match with add_param and sub_param
  ! procedures
  interface
     function intfun(x, param) result(y) ! write contents
       integer, intent(in) :: x, param
       integer :: y
     end function intfun
  end interface

  type ft
     procedure(intfun), pointer, nopass :: fun => null()
     integer :: param
  end type ft

contains

  function map(f, x) result(y) ! write contents
    type(ft) :: f
    integer, intent(in) :: x(:)
    integer, allocatable :: y(:)
    integer :: n
    allocate(y(size(x,1)))

    do n = lbound(y,1), ubound(y,1)
       y(n) = f % fun(x(n), f % param)
    end do
  end function map

end module points

program procpoint
  use points
  implicit none

  type(ft) :: pptr(6)
  integer :: n
  pptr(1:3) = [ (ft(add_param, n), n=1,3) ]
  pptr(4:6) = [ (ft(sub_param, n), n=1,3) ]

  do n =1, 6
     write(*,'(A,4I3,A,I2)') 'map(pptr(n), [1,2,3,4]) =', &
          & map(pptr(n), [1,2,3,4]), ', n = ', n
  end do

contains

  function add_param(x,param) result(y)
    integer, intent(in) :: x, param
    integer :: y
    y = x+param
  end function add_param

  function sub_param(x,param) result(y)
    integer, intent(in) :: x, param
    integer :: y
    y = x-param
  end function sub_param

end program procpoint
