program global
  use, intrinsic :: iso_c_binding
  use globalmod
  implicit none

  interface
     ! void cinit()
     subroutine cinit () bind(c)
     end subroutine cinit
  end interface

  real(c_float), pointer :: vector(:)

  call cinit()

  print *, 'pixel(:,:)=', pixel(:,:)
  print *, 'n=', n
  call c_f_pointer(c_vector, vector, (/n/))
  print *, 'vector(1:n)=', vector(1:n)
  print *, 'position (x,y,id,z)=', &
       & position%x, position%y, position%id, position%z

end program global
