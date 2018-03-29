program pointer_enhancements
  implicit none
  real, target :: budget(1917:2016)
  real, pointer, dimension(:) :: A, B, C
  real, pointer :: D(:)
  integer :: j, lbs(1), ubs(1)
  
  print *, &
       'lbound(budget), ubound(budget), size(budget), is_contiguous(budget)=',&
       &   lbound(budget),ubound(budget),size(budget),is_contiguous(budget)
  lbs = lbound(budget)
  ubs = ubound(budget)
  call random_number(budget)
  budget = abs(budget) * 1.0e8
  
  A => budget
  B => budget(1939:1945:2)
  C (1939:) => budget(1939:1945) ! New feature
  D => budget(1939:1945:2) 
  
  print *, 'lbound(A), ubound(A), size(A), is_contiguous(A)=',&
       lbound(A), ubound(A), size(A), is_contiguous(A)
  print *, 'lbound(B), ubound(B), size(B), is_contiguous(B)=',&
       lbound(B), ubound(B), size(B), is_contiguous(B)
  print *, 'lbound(C), ubound(C), size(C), is_contiguous(C)=',&
       lbound(C), ubound(C), size(C), is_contiguous(C)
  print *, 'lbound(D), ubound(D), size(D), is_contiguous(D)=',&
       lbound(D), ubound(D), size(D), is_contiguous(D)
  
  print *,'B=', B
  print *,'C=', C
  print *,'D=', D
  
end program pointer_enhancements
