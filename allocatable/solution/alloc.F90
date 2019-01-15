program ALLOC
  implicit none
  integer, allocatable :: IA(:), IB(:)
  integer :: N

  call TEST_AUTO_ALLOC

  call ALLOC_IA(IA, N)
  if (allocated(IA)) then
     print '(A,8(1X,I0))','SIZE(IA), IA(:)=',size(IA),IA
     deallocate(IA)
  endif

  IA = FUNC_ALLOC_IA(N)
  if (allocated(IA)) then
     print *,'SIZE(IA), IA(:)=',size(IA),IA

     call move_alloc(IA, IB)
     print *,'SIZE(IB), IB(:)=',size(IB),IB

     if (allocated(IA)) deallocate(IA)
     if (allocated(IB)) deallocate(IB)
  endif

  call TEST_STRING_ALLOC

contains

  subroutine TEST_AUTO_ALLOC
    real, allocatable :: A(:), B(:)
    real :: INPUT(3)
    INPUT = [ 1, 2, 3 ]
    ! A(:) = INPUT(:) would be illegal !
    A = INPUT ! Automatic ALLOCATE
    print *,size(A) ! Gives 3
    print *,'A=',A
    B = (/ 1,2,4,8,16 /) ! Automatic alloc. of B
    A = [ A, B ] ! Automatic re-sizing
    print *,size(A) ! Size now = 8
    print '(A,8(1X,G0))','A=',A
    print *,'A=',A
    ! DEALLOCATEs legal, but not necessary
    deallocate(A, B)
  end subroutine TEST_AUTO_ALLOC

  subroutine ALLOC_IA(A, N)
    integer, allocatable, intent(OUT) :: A(:)
    integer, intent(OUT) :: N
    N = 5
    allocate ( A(N) )
    A(:) = -N
  end subroutine ALLOC_IA

  function FUNC_ALLOC_IA(N) result(A)
    integer, allocatable :: A(:)
    integer, intent(OUT) :: N
    N = 5
    allocate ( A(N) )
    A(:) = -N
  end function FUNC_ALLOC_IA

  subroutine TEST_STRING_ALLOC
    character(LEN=:), allocatable :: CH
    integer LENCH
    LENCH = 12
    allocate(character(LENCH)::CH) ! We do not need this at all -- the next line would do !
    CH = 'Hello World!'
    print *,' CH="'//CH//'"'
  end subroutine TEST_STRING_ALLOC


end program ALLOC
