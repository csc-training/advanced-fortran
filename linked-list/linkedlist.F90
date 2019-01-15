! The output of this program should be similar to:
! ---
!  unsorted list:
!  1 small
!  10 foo
!  4 bar
!  6 Hello,
!  2 world
!  13 key thirteen
!  11 key eleven
!  12 key twelve
!  got:
!  1 small
!  unsorted list:
!  10 foo
!  4 bar
!  6 Hello,
!  2 world
!  13 key thirteen
!  11 key eleven
!  12 key twelve
!  finalizing list
!  removing: 10 foo
!  removing: 4 bar
!  removing: 6 Hello,
!  removing: 2 world
!  removing: 13 key thirteen
!  removing: 11 key eleven
!  removing: 12 key twelve
! ---

module listmod
  implicit none
  private

  type, public :: key_t ! {{{
     integer :: val
     ! TODO: Fill if necessary
  end type key_t ! }}}

  type, public :: data_t ! {{{
     character(len=:), allocatable :: str
     ! TODO: Fill if necessary
  end type data_t ! }}}

  type, public :: node_t ! {{{
     type(data_t) :: data
     type(key_t) :: key
     type(node_t), pointer :: right => null()
     ! TODO: Fill
  end type node_t ! }}}

  type, public :: list_t ! {{{
     type(node_t), pointer :: root => null()
     type(node_t), pointer :: last => null()
     integer :: length
     ! TODO: Fill
  end type list_t ! }}}

contains

  ! TODO: Write subroutines that returns compares two nodes n1 and n2
  !       and returns true if n1 % key < n2 % key

  subroutine list_t_finalize(list) !  {{{
    type(list_t) :: list
    type(node_t), pointer :: node
    print *, 'finalizing list'
    ! TODO: Fill in here
    ! This should print out the key-data pair
    ! of each node as it is being deallocated
  end subroutine list_t_finalize ! }}}

  subroutine list_t_append(list, key, value) ! {{{
    class(list_t) :: list
    type(key_t) :: key
    type(data_t) :: value
    ! TODO: Fill in here
  end subroutine list_t_append ! }}}

  function list_t_get(list) result(node)
    class(list_t) :: list
    type(node_t), pointer :: node
    ! TODO: Fill in here
  end function list_t_get

  subroutine print_node(node) ! {{{
    type(node_t) :: node
    print *, node % key % val, node % data % str
  end subroutine print_node ! }}}

  subroutine print_list(list) ! {{{
    class(list_t), intent(in) :: list
    type(node_t), pointer :: node
    node => list % root

    if (is_sorted(list)) then
       print *, 'sorted list:'
    else
       print *, 'unsorted list:'
    end if

    if(.not. associated(list % root)) then
       print *, 'empty list'
       return
    end if

    do while (.not. associated(node % right, node))
       call print_node(node)
       node => node % right
    end do
    call print_node(node)
  end subroutine print_list ! }}}

  function is_sorted(list) result(sorted)! {{{
    type(list_t), intent(in) :: list
    type(node_t), pointer :: node
    logical :: sorted

    sorted = .true.
    if(.not. associated(list % root)) return ! empty list is sorted

    ! TODO Fill in here to loop over non-empty list


  end function is_sorted ! }}}

end module listmod

program test_prog
  use listmod
  implicit none

  call submain()

contains

  subroutine submain()
    type(list_t) :: list
    type(node_t), pointer :: node

    call list % append(key_t(1), data_t("small"))
    call list % append(key_t(10), data_t("foo"))
    call list % append(key_t(4), data_t("bar"))
    call list % append(key_t(6), data_t("Hello, "))
    call list % append(key_t(2), data_t("world"))
    call list % append(key_t(13), data_t("key thirteen"))
    call list % append(key_t(11), data_t("key eleven"))
    call list % append(key_t(12), data_t("key twelve"))
    call list % printme()

    node => list % get()

    if (associated(node)) then
       print *, 'got:'
       call print_node(node)
       call list % printme()
       deallocate(node)
    end if
  end subroutine submain

  subroutine print_node(node) ! {{{
    type(node_t) :: node
    print *, node % key % val, node % data % str
  end subroutine print_node ! }}}

end program test_prog
