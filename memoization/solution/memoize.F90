module memoize
  private ! make module subroutines accessible only through public types by default

  ! This type should function as a memoized sum of x and y
  ! Add as restricting module and type access control as
  ! possible and fill missing parts

  type, public :: data_t
     integer, private :: x, y
     integer, private :: val
     procedure(calcdata), pointer, public :: calculate => calcdata
   contains
     procedure, public :: printme
  end type data_t

  interface data_t
     module procedure initdata
  end interface data_t

contains

  subroutine printme(data)
    class(data_t) :: data
    print '("  x: ", I0, ", y: ", I0, ", val: ", I0)', data % x, data % y, data % val
  end subroutine printme

  function initdata(x,y) result(obj)
    integer :: x, y
    type(data_t) :: obj
    obj % x = x
    obj % y = y
    obj % val = 0
    obj % calculate => calcdata
  end function initdata

  function calcdata(this) result(val)
    class(data_t) :: this
    integer :: val
    this % val = this % x + this % y
    val = this % val
    this % calculate => getval
  end function calcdata

  function getval(this) result(val)
    class(data_t) :: this
    integer :: val
    print *, 'getval is called!'
    val = this % val
  end function getval

end module memoize

program memoprog
  use memoize
  implicit none

  type(data_t) :: foo
  integer :: val

  print *, 'Init'
  foo = data_t(1, 1)
  call foo % printme()
  print *, 'Call calculate'
  val = foo % calculate()
  call foo % printme()

  print *, 'Calling calculate again'
  val = foo % calculate()

  print *, 'Reinit'
  foo = data_t(2,1)
  call foo % printme()
  val = foo % calculate()
  print '(A,I0)', ' Calculated again, value = ', val
  call foo % printme()

end program memoprog
