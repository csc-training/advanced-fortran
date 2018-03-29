module asgn
  use, intrinsic :: iso_c_binding
  implicit none

  interface assignment(=)
     module procedure asgn_c_str_to_fortran_str
  end interface assignment(=)

  interface
     ! size_t strlen(const char *s);
     function strlen(s) bind(c)
       use, intrinsic :: iso_c_binding
       implicit none
       type(c_ptr), value, intent(in) :: s
       integer(c_size_t) :: strlen
     end function strlen
     ! char *strncpy(char *dest, const char *src, size_t n);
     function strncpy(dest, src, n) bind(c)
       use, intrinsic :: iso_c_binding
       implicit none
       character(kind=c_char), intent(in) :: dest(*)
       type(c_ptr), value, intent(in) :: src
       integer(c_size_t), value :: n
       type(c_ptr) :: strncpy
     end function strncpy
  end interface

contains

  subroutine asgn_c_str_to_fortran_str(fstr, cstr)
    character(:), allocatable, intent(out) :: fstr
    type(c_ptr), value, intent(in) :: cstr
    integer(c_size_t) :: lenstr
    type(c_ptr) :: dummy
    lenstr = strlen(cstr)
    allocate(character(len=lenstr)::fstr)
    dummy = strncpy(fstr, cstr, lenstr)
  end subroutine asgn_c_str_to_fortran_str

end module asgn
