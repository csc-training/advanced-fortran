program async_io
  use, intrinsic :: iso_fortran_env, only : sp => REAL32
  implicit none
  integer(kind=sp), allocatable :: bigdata(:,:)
  integer :: n
  integer, parameter :: nrecs = 3
  integer :: iu, id(nrecs), j

  n = 500000000
  allocate(bigdata(n,nrecs))

  iu = 20
  open(iu, file='bigdata.bin', &
       & asynchronous='yes', &
       & access='direct', recl = 4 * n, &
       & form='unformatted', status='unknown')

  do j = 1, nrecs ! write <nrecs> x 2GB
     write(iu, id=id(j), asynchronous='yes', rec=j) bigdata(:,j)
     write(0,'("id(",i0,")=",i0)') j,id(j)
  enddo

  if (any(id(2:) /= id(1))) then
     call working()
  else
     write(0,*) 'Async I/O probably not asynchronous after all'
  endif

  ! wait until all async I/O is finished
  write(0,*) 'calling wait()'
  wait(iu)

  write(0,*) 'closing file'
  close(iu, status='delete')

  deallocate(bigdata) ! would happen automatically anyroad

contains

  subroutine working
    write(0,*) 'working() whilst async I/O still in progress ...'
  end subroutine working

end program async_io
