program global_max
  implicit none
  integer, parameter :: n_rand = 1000
  real, dimension(n_rand) :: x
  real :: local_max[*], glbl_max
  integer :: me, im, im_maxval, seed_size
  integer, allocatable :: seed(:)

  call random_seed(size=seed_size)
  allocate(seed(seed_size))

  me = this_image()
  seed = me
  call random_seed(put=seed)
  call random_number(x)
  local_max = maxval(x)
  write(*,'(I5,A,F10.7)')  me, ': ', local_max

  sync all
! TODO: find the global maximum across the images
end program global_max
