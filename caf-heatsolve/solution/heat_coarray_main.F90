
program heat_solve
  use heat
  implicit none

  real(dp), parameter :: a = 0.5 ! Diffusion constant
  type(field) :: current[*], previous[*]    ! Current and previus temperature fields as coarrays
  type(user_input) :: input[*] ! user-provided data now as a coarray
  real(dp) :: dt     ! Time step
  integer, parameter :: image_interval = 50 ! Image output interval
  integer :: iter
  character(len=85) :: arg  ! command line arguments

  ! Default values for grid size and time steps
  input%rows = 200
  input%cols = 200
  input%nsteps = 500
  input%using_input_file = .false.

  ! Read in the command line arguments and
  ! set up the needed variables
  ! done at the Image #1 and then all images fetch the data from there
  if (this_image() == 1) then
     select case(command_argument_count())
     case(0) ! No arguments -> default values
     case(1) ! One argument -> input file name
        input%using_input_file = .true.
        call get_command_argument(1, input%input_file)
     case(2) ! Two arguments -> input file name and number of steps
        input%using_input_file = .true.
        call get_command_argument(1, input%input_file)
        call get_command_argument(2, arg)
        read(arg, *)  input%nsteps
     case(3) ! Three arguments -> rows, cols and nsteps
        call get_command_argument(1, arg)
        read(arg, *) input%rows
        call get_command_argument(2, arg)
        read(arg, *) input%cols
        call get_command_argument(3, arg)
        read(arg, *) input%nsteps
     case default
        call usage()
        stop
     end select
  end if
  sync all
  input = input[1]

  ! Initialize the fields according the command line arguments
  if (input%using_input_file) then
     call read_input(previous, input%input_file)
     call copy_fields(previous, current)
  else
     call initialize_field_metadata(previous, input%rows, input%cols)
     call initialize_field_metadata(current, input%rows, input%cols)
     call initialize(previous)
     call initialize(current)
  end if

  ! Draw the picture of the initial state
  call output(current, 0)

  ! Largest stable time step
  dt = current%dx**2 * current%dy**2 / &
       & (2.0 * a * (current%dx**2 + current%dy**2))

  ! Main iteration loop, save a picture every
  ! image_interval steps
  do iter = 1, input%nsteps
     ! an extra step for the "halo swap"
     call exchange(previous)
     call evolve(current, previous, a, dt)
     if (mod(iter, image_interval) == 0) then
        call output(current, iter)
     end if
     call swap_fields(current, previous)
  end do

  call finalize(current)
  call finalize(previous)

contains

  ! Helper routine that prints out a simple usage if
  ! user gives more than three arguments
  subroutine usage()
    implicit none
    character(len=256) :: buf

    call get_command_argument(0, buf)
    write (*,'(A)') 'Usage:'
    write (*,'(A, " (default values will be used)")') trim(buf)
    write (*,'(A, " <filename>")') trim(buf)
    write (*,'(A, " <filename> <nsteps>")') trim(buf)
    write (*,'(A, " <rows> <cols> <nsteps>")') trim(buf)
  end subroutine usage

end program heat_solve
