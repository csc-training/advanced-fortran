module globalmod
  use, intrinsic :: iso_c_binding
  implicit none

  public
  
  integer(c_short), bind(c) :: pixel(4,2) ! NB: index swap
  integer(c_int), bind(c) :: n
  type(c_ptr), bind(c, name='vector') :: c_vector

  type, bind(c) :: pos_t
     real(c_double) :: x, y
     integer(c_int) :: id
     real(c_double) :: z
  end type pos_t

  type(pos_t), bind(c, name='position') :: position
  
end module globalmod
