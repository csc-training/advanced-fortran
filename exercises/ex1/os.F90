program os_tests
  implicit none
  character(len=256) all_args
  character(len=80)  arg, enval
  integer :: numargs, j, istat

  !TODO: call to get the full command line into "all_args"
  !call ..
  print *,'all_args="'//trim(all_args)//'"'

  !numargs = ??
  do j = 0, numargs
     ! TODO: call to each argument (also command itself) to "arg" and print it
     print *,'arg#',j,'="'//trim(arg)//'"'
  end do

  !TODO: get value of $HOME environment variable
  !call ..
  print *, 'HOME="'//trim(enval)//'"'

  !TODO: execute Unix command 'echo $HOME' and obtain exitstat status, too
  !call ..
  print *,'exitstat=',istat

end program os_tests
