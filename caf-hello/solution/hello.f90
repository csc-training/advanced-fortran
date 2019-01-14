program hello2
  implicit none
  integer :: me, i

  me = this_image()
  do i = 1, num_images()
     sync all
     if (i == me) write(*,*) 'Hello! From Image', me
  end do

end program hello2
