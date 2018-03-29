program global_max
  implicit none
  integer, parameter :: n_rand = 1000
  real, dimension(n_rand) :: x
  real :: local_max[*], glbl_max
  integer :: me, im, im_maxval, seed(2)

  me = this_image()
  seed = me
  call random_seed(put=seed)
  call random_number(x)
  local_max = maxval(x)
  print *, me, local_max
  sync all
  if (me == 1) then
     do im = 1, num_images()
        if (local_max[im] > glbl_max) then
           glbl_max = local_max[im]
           im_maxval = im
        end if
     end do
     write(*,*) 'Global maximum=', glbl_max, &
          ' was found at Image', im_maxval
  end if
end program global_max

