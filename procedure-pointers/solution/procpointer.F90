module points

  abstract interface
     function intfun(x) result(y) ! write contents
       integer, intent(in) :: x
       integer :: y
     end function intfun
  end interface

contains

  function map(f, x) result(y) ! write contents
    procedure(intfun) :: f
    integer, intent(in) :: x(:)
    integer, allocatable :: y(:)
    integer :: n
    allocate(y(size(x,1)))

    do n=lbound(y,1),ubound(y,1)
       y(n) = f(x(n))
    end do
  end function map

  function add_two(x) result(y)
    integer, intent(in) :: x
    integer :: y
    y = x+2
  end function add_two

end module points

program procpoint
  use points
  implicit none

  procedure(intfun), pointer :: pptr
  integer, allocatable :: y(:)

  pptr => add_one
  y = map(pptr, [1,2,3,4])
  write(unit=*,fmt='(A,*(I0,:,","))',advance='no') 'map(add_one, [1,2,3,4]) = [', y
  write(*,'(A)') ']'
  pptr => add_two
  y = map(pptr, [1,2,3,4])
  write(unit=*,fmt='(A,*(I0,:,","))',advance='no') 'map(add_two, [1,2,3,4]) = [', y
  write(*,'(A)') ']'

contains

  function add_one(x) result(y)
    integer, intent(in) :: x
    integer :: y
    y = x+1
  end function add_one

end program procpoint
