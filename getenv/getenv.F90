program my_getenv
  use, intrinsic :: iso_c_binding
  use asgn
  implicit none

  interface
     !  char *getenv(const char *name);
     function mygetenv(name) bind(c,name='getenv')
     ! TODO: add here the correct interface declaration
     end function mygetenv
  end interface

  type(c_ptr) :: c_env
  character(:,c_char), allocatable :: env

  !c_env = mygetenv('HOME'//c_null_char)
  !env = c_env
  env = mygetenv('HOME'//c_null_char)
  print *, 'len(env)=', len(env)

  print *, 'HOME="'//env//'"'
end program my_getenv
