module memoize

  ! This type should function as a memoized sum of x and y
  ! Add as restricting module and type access control as
  ! possible and fill missing parts

  type :: data_t
     ! TODO: Fill in here
   contains
     procedure :: printme
  end type data_t

  interface data_t
     module procedure initdata
  end interface data_t

contains

  subroutine printme(data)
    class(data_t) :: data
    print *, data % x, data % y, data % val
  end subroutine printme

  function initdata(x,y) result(obj)
    integer :: x, y
    type(data_t) :: obj
    ! TODO: fill
  end function initdata

  function calcdata(this) result(val)
    class(data_t) :: this
    integer :: val
    ! TODO: fill
  end function calcdata

  ! TODO: add a function that only returns the stored result

end module memoize

program memoprog
  use memoize
  implicit none

  type(data_t) :: foo
  integer :: val

  print *, 'init'
  foo = data_t(1, 1)
  call foo % printme()
  val = foo % calculate()
  print *, 'value = ', val

  print *, 'calling calculate again'
  val = foo % calculate()

  print *, 'reinit'
  foo = data_t(2,1)
  call foo % printme()
  val = foo % calculate()
  print *, 'calculate again, value = ', val
  call foo % printme()

end program memoprog
