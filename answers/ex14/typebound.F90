program typebound
  use typebound_mod
  implicit none

  integer, parameter :: n = 5

  integer :: i
  type(vector) :: v1, v2, v3

  v1 = vector([1,2,3,4,5])
  v2 = vector([(n-i+1,i=1,n)])

  print *,'vecsum'
  v3 = v1 % sum(v2)
  print '(*(F8.3))',v3 % data
  print *,'Operator: +'
  v3 = v1+v2
  print '(*(F8.3))',v3 % data
  print *,'vecprod'
  v3 = v1 % prod(v2)
  print '(*(F8.3))',v3 % data
  print *,'Operator: .prod.'
  v3 = v1 .prod. v2
  print '(*(F8.3))',v3 % data
  print *,'vecdotprod'
  print *,v1 % dot(v2)
  print *,'Operator: *'
  print *,v1 * v2

end program typebound
