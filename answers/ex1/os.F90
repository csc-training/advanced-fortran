program os_tests
  implicit none
  character(len=256) all_args
  character(len=80)  arg, enval
  integer :: numargs, j, istat

  call get_command(all_args)
  print *,'all_args="'//trim(all_args)//'"'

  numargs = command_argument_count()
  do j = 0, numargs
     call get_command_argument(j,arg)
     print *,'arg#',j,'="'//trim(arg)//'"'
  end do

  call get_environment_variable('HOME',enval)
  print *, 'HOME="'//trim(enval)//'"'

  call execute_command_line('echo $HOME',exitstat=istat)
  print *,'exitstat=',istat

end program os_tests
