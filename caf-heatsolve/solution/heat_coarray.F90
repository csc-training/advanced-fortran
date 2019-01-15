module heat
  use, intrinsic :: iso_fortran_env, only : REAL64
  implicit none

  integer, parameter :: dp = REAL64

  real(dp), parameter :: DX = 0.01, DY = 0.01  ! Fixed grid spacing

  type :: field
     integer :: nx
     integer :: ny
     real(dp) :: dx
     real(dp) :: dy
     real(dp), dimension(:,:), allocatable :: data
  end type field

  type :: user_input
     integer :: nsteps       ! Number of time steps
     integer :: rows, cols  ! Field dimensions
     character(len=85) :: input_file, arg  ! Input file name and command line arguments
     logical :: using_input_file
  end type user_input

contains

  ! Initialize the field type metadata
  ! Arguments:
  !   field0 (type(field)): input field
  !   nx, ny, dx, dy: field dimensions and spatial step size
  subroutine initialize_field_metadata(field0, nx, ny)
    implicit none

    type(field), intent(out) :: field0[*]
    integer, intent(in) :: nx, ny

    field0%dx = DX
    field0%dy = DY
    field0%nx = nx
    field0%ny = ny / num_images()
  end subroutine initialize_field_metadata

  ! Initialize the temperature field.  Pattern is disc with a radius
  ! of nx_full / 6 in the center of the grid.
  ! Boundary conditions are (different) constant temperatures outside the grid
  subroutine initialize(field0)
    implicit none

    type(field), intent(inout) :: field0[*]

    real(dp) :: radius2
    integer :: i, j, ds2, nx_full, ny_full

    ! The arrays for field contain also a halo region
    allocate(field0%data(0:field0%nx+1, 0:field0%ny+1))

    nx_full = field0%nx
    ny_full = field0%ny * num_images()
    ! Square of the disk radius
    radius2 = (nx_full / 6.0)**2

    do j = 0, field0%ny + 1
       do i = 0, field0%nx + 1
          ds2 = int((i - nx_full / 2.0 + 1)**2 + &
               & (j + (this_image()-1) * field0%ny - ny_full / 2.0 + 1)**2)
          if (ds2 < radius2) then
             field0%data(i,j) = 5.0_dp
          else
             field0%data(i,j) = 65.0_dp
          end if
       end do
    end do

    ! Boundary conditions
    if (this_image() == 1) then
       field0%data(:, 0) = 20.0_dp
    end if

    if (this_image() == num_images()) then
       field0%data(:, field0%ny + 1) = 70.0_dp
    end if

    field0%data(0,:) = 85.0_dp
    field0%data(field0%nx + 1,:) = 5.0_dp

  end subroutine initialize

  ! Swap the data fields of two variables of type field
  ! Arguments:
  !   curr, prev (type(field)): the two variables that are swapped
  subroutine swap_fields(curr, prev)
    implicit none

    type(field), intent(inout) :: curr[*], prev[*]
    real(dp), allocatable, dimension(:,:) :: tmp

    call move_alloc(curr%data, tmp)
    call move_alloc(prev%data, curr%data)
    call move_alloc(tmp, prev%data)
  end subroutine swap_fields

  ! Copy the data from one field to another
  ! Arguments:
  !   from_field (type(field)): variable to copy from
  !   to_field (type(field)): variable to copy to
  subroutine copy_fields(from_field, to_field)
    implicit none

    type(field), intent(in) :: from_field[*]
    type(field), intent(out) :: to_field[*]

    ! Consistency checks
    if (.not.allocated(from_field%data)) then
       write (*,*) "Can not copy from a field without allocated data"
       stop
    end if
    if (.not.allocated(to_field%data)) then
       ! Target is not initialize, allocate memory
       allocate(to_field%data(lbound(from_field%data, 1):ubound(from_field%data, 1), &
            & lbound(from_field%data, 2):ubound(from_field%data, 2)))
    else if (any(shape(from_field%data) /= shape(to_field%data))) then
       write (*,*) "Wrong field data sizes in copy routine"
       print *, shape(from_field%data), shape(to_field%data)
       stop
    end if

    to_field%data = from_field%data

    to_field%nx = from_field%nx
    to_field%ny = from_field%ny
    to_field%dx = from_field%dx
    to_field%dy = from_field%dy
  end subroutine copy_fields

  subroutine exchange(from_field)
    implicit none
    type(field), intent(inout) :: from_field[*]
    integer, save :: lb_x[*], lb_y[*], ub_x[*], ub_y[*] ! upper and lower boundary indices of the local arrays
    ! accessible by other images
    integer :: me

    me = this_image()
    lb_y = lbound(from_field%data,2)
    ub_y = ubound(from_field%data,2)

    sync all
    ! read the leftmost column of the image on the right to the right halo region
    if (me < num_images()) then ! the board is non-periodic, hence the last image does not read
       from_field%data(:,ub_y) = from_field[me+1]%data(:,lb_y[me+1]+1)
    end if
    ! read the rightmost column of the image on the left to the left halo region
    if (me > 1) then ! the board is non-periodic, hence the first image does not read
       from_field%data(:,lb_y) = from_field[me-1]%data(:,ub_y[me-1]-1)
    end if
  end subroutine exchange


  ! Compute one time step of temperature evolution
  ! Arguments:
  !   curr (type(field)): current temperature values
  !   prev (type(field)): values from previous time step
  !   a (real(dp)): update equation constant
  !   dt (real(dp)): time step value
  ! Unchanged in the coarrays implementation, since each image update their local portion of the field
  subroutine evolve(curr, prev, a, dt)
    implicit none

    type(field), intent(inout) :: curr, prev
    real(dp) :: a, dt
    integer :: i, j, nx, ny

    nx = curr%nx
    ny = curr%ny

    do j = 1, ny
       do i = 1, nx
          curr%data(i, j) = prev%data(i, j) + a * dt * &
               & ((prev%data(i-1, j) - 2.0 * prev%data(i, j) + &
               &   prev%data(i+1, j)) / curr%dx**2 + &
               &  (prev%data(i, j-1) - 2.0 * prev%data(i, j) + &
               &   prev%data(i, j+1)) / curr%dy**2)
       end do
    end do
  end subroutine evolve

  ! Output routine, saves the temperature distribution as a png image
  ! Arguments:
  !   curr (type(field)): variable with the temperature data
  !   iter (integer): index of the time step
  subroutine output(curr, iter)
    use pngwriter
    implicit none

    type(field), intent(in) :: curr[*]
    integer, intent(in) :: iter
    character(len=85) :: filename

    ! The actual write routine takes only the actual data
    ! (without ghost layers) so we need array for that
    integer :: full_nx, full_ny, stat
    real(dp), dimension(:,:), allocatable, target :: full_data

    full_nx = curr%nx
    full_ny = curr%ny

    allocate(full_data(full_nx, full_ny))
    full_data(1:curr%nx, 1:curr%ny) = curr%data(1:curr%nx, 1:curr%ny)

    write(filename,'(A5,I4.4,A1,I4.4,A4,A)')  'heat_', iter, '_', &
         this_image(), '.png'
    stat = save_png(full_data, full_nx, full_ny, filename)
    deallocate(full_data)
  end subroutine output

  ! Clean up routine for field type
  ! Arguments:
  !   field0 (type(field)): field variable to be cleared
  subroutine finalize(field0)
    implicit none

    type(field), intent(inout) :: field0[*]

    deallocate(field0%data)
  end subroutine finalize

  ! Reads the temperature distribution from an input file
  ! Arguments:
  !   field0 (type(field)): field variable that will store the
  !                         read data
  !   filename (char): name of the input file
  ! Note that this version assumes the input data to be in C memory layout
  subroutine read_input(field0, filename)
    implicit none

    type(field), intent(out) :: field0[*]
    character(len=85), intent(in) :: filename

    integer, save :: nx[*], ny[*]
    integer :: i, im, ylow, yup
    character(len=2) :: dummy

    real(kind=dp), dimension(:,:), allocatable :: full_grid

    ! i/o only from the first image
    if (this_image() == 1) then
       open(10, file=filename)
       ! Read the header
       read(10, *) dummy, nx, ny ! nx is the number of rows
       ! allocate the helper array
       allocate(full_grid(nx,ny))
       ! Read the data to the helper array
       do i = 1, nx
          read(10, *) full_grid(i, 1:ny)
       end do
       close(10)
    end if
    sync all
    ny = ny[1] / num_images()
    nx = nx[1]

    call initialize_field_metadata(field0, nx, ny)
    ! The arrays for temperature field contain also a halo region
    allocate(field0%data(0:field0%nx+1, 0:field0%ny+1))

    ! distribute the data from the image #1
    sync all
    if (this_image() == 1) then
       ylow = 1
       do im = 1, num_images()
          yup = ylow + ny[im] - 1
          field0[im]%data(1:nx,1:ny[im]) = full_grid(1:nx,ylow:yup)
          ylow = yup + 1
       end do
    end if
    sync all

    ! Set the boundary values
    field0%data(1:nx,   0     ) = field0%data(1:nx, 1     )
    field0%data(1:nx,     ny+1) = field0%data(1:nx,   ny  )
    field0%data(0,      0:ny+1) = field0%data(1,    0:ny+1)
    field0%data(  nx+1, 0:ny+1) = field0%data(  nx, 0:ny+1)

  end subroutine read_input

end module heat
