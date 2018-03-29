program contiguous_attribute
  implicit none
  integer :: N = 5
  real, allocatable, target :: memory(:)
  real, pointer, contiguous :: Matrix(:,:)
  real, pointer, contiguous :: Diagonal(:) 
  integer :: i

  allocate(memory(n*n)) ! Space for N-by-N matrix

  memory = 0
  Matrix (1:n, 1:n) => memory 
  Diagonal => memory(::n+1) 
  Diagonal = [ (-i, i=1,n) ]

  print *,'is_contiguous(memory)=',is_contiguous(memory)
  print *,'is_contiguous(Matrix)=',is_contiguous(Matrix)
  print *,'is_contiguous(Diagonal)=',is_contiguous(Diagonal)

  do i = 1, n
     print '(10g13.5)', matrix(i,:)
  end do

  deallocate(memory)

end program contiguous_attribute
