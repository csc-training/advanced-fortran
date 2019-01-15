module listmod
  implicit none
  private

  type, public :: key_t ! {{{
     integer :: val
   contains
     procedure, private :: key_t_lt
     generic, public :: operator(<) => key_t_lt
  end type key_t ! }}}

  type, public :: data_t ! {{{
     character(len=:), allocatable :: str
  end type data_t ! }}}

  type, public :: node_t ! {{{
     type(data_t) :: data
     type(key_t) :: key
     type(node_t), pointer :: right => null()
   contains
     procedure, private :: node_lt
     generic :: operator(<) => node_lt
  end type node_t ! }}}

  type, public :: list_t ! {{{
     type(node_t), pointer :: root => null()
     type(node_t), pointer :: last => null()
     integer :: length
   contains
     procedure :: append => list_t_append
     procedure :: get => list_t_get
     procedure :: printme => print_list
     final :: list_t_finalize
  end type list_t ! }}}

contains

  subroutine list_t_finalize(list) ! {{{
    type(list_t) :: list
    type(node_t), pointer :: node
    print *, 'finalizing list'
    do
       node => list % get()
       if(.not. associated(node)) exit
       write (*,'(A)', advance='no') 'removing: '
       call print_node(node)
       deallocate(node)
    end do
  end subroutine list_t_finalize ! }}}

  function key_t_lt(x,y) result(lt) ! {{{
    class(key_t), intent(in) :: x, y
    logical :: lt
    lt = x % val < y % val
  end function key_t_lt ! }}}

  function node_lt(x,y) result(lt) ! {{{
    class(node_t), intent(in) :: x, y
    logical :: lt
    lt = x % key < y % key
  end function node_lt ! }}}

  subroutine list_t_append(list, key, value) ! {{{
    class(list_t) :: list
    type(key_t) :: key
    type(data_t) :: value
    type(node_t), pointer :: node

    allocate(node)
    node % data = value
    node % key = key
    node % right => node

    if (.not. associated(list % root)) then
       list % last => node
       list % root => node
       list % last % right => node
    else
       list % last % right => node
       list % last => node
    end if
  end subroutine list_t_append ! }}}

  function list_t_get(list) result(node) ! exercise
    class(list_t) :: list
    type(node_t), pointer :: node
    if(.not. associated(list % root))  then ! empty list
       node => null()
       return
    end if
    node => list % root
    if (associated(node, node % right)) then ! last node was given
       list % root => null()
       list % last => null()
    else
       list % root => list % root % right
    end if
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

  function is_sorted(list) result(sorted)! exercise {{{
    type(list_t), intent(in) :: list
    type(node_t), pointer :: node
    logical :: sorted

    sorted = .true.
    if(.not. associated(list % root)) return ! empty list is sorted
    node => list % root

    do while (.not. associated(node % right, node))
       if (.not. node < node % right ) then
          sorted = .false.
          return
       end if
       node => node % right
    end do

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
