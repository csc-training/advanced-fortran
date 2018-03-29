program coarray_input
  implicit none
  integer :: user_input[*]

  if (this_image() == 1) then
     write(*,*) 'Give a value for parameter n:'
     read(*,*) user_input
  end if
  sync all
  user_input = user_input[1]
  
  write (*,*) 'User-provided parameter in image=', &
       this_image(), ' is: ', user_input
end program coarray_input

