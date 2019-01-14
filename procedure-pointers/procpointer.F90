module points

  abstract interface
     function intfun(x) result(y) ! write contents
     end function intfun
  end interface

contains

  function map(f, x) result(y) ! write contents

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

  ! TODO: write the declaration of procedure pointer pptr
  !       implementing abstract interface intfun
  integer, allocatable :: y(:)

  pptr => add_one
  y = map(pptr, [1,2,3,4])
  print *, 'map(add_one, [1,2,3,4]) =', y
  pptr => add_two
  y = map(pptr, [1,2,3,4])
  print *, 'map(add_two, [1,2,3,4]) =', y

contains

  function add_one(x) result(y)
    integer, intent(in) :: x
    integer :: y
    y = x+1
  end function add_one

end program procpoint
