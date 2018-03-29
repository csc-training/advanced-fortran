module globalmod
  use, intrinsic :: iso_c_binding
  implicit none

  public

  ! TODO: Modify these so that they are mapped
  !       to corresponding declarations in cdata.c
  integer :: pixel ! NB: index swap
  integer :: n

  ! TODO: Add the binding to global variable vector
  type() :: c_vector

  ! TODO: Implement here a mapping to the derived datatype pos_t
  !       and add a module variable 'position' that is mapped to
  !       the corresponding C variable.

end module globalmod
