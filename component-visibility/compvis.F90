module people
  implicit none

  type person_t
     character(len=:), allocatable :: name
     integer :: age ! age stored in months
     logical :: flag = .false.
  end type person_t

  ! interface person_t
  !   ! Fill
  ! end interface

contains

  ! subroutine set_age(person, years, months)
  !   ! Fill
  ! end subroutine

  ! subroutine set_name(person, name)
  !   ! Fill
  ! end subroutine

  subroutine print_person(person)
    type(person_t), intent(in) :: person
    write (*,'(A,A,I3,A,I3,A,L)') person % name,',', person % age / 12, ' years and', &
         mod(person % age, 12), ' months.', person%flag
  end subroutine print_person

  ! function init_person_t(name, years, months) result(new_person)
  !   character(*), intent(in) :: name
  !   ! Fill
  ! end function

end module people

program peopleprogram
  use people
  implicit none
  type(person_t) :: john, lisa

  ! Old way, dont edit anything between #if 1...#endif
  ! Disable by setting next line to "#if 0"
#if 1
  john = person_t("John", 13*12+5, .true.)
  lisa = person_t("Lisa", 57*12+3, .true.)
#endif

  ! New way, dont edit anything between #if 0...#endif
  ! Enable by setting next line to "#if 1"
#if 0
  call set_name(john, "John")
  call set_age(john, 13, 5)
  john % flag = .true.
  lisa = person_t("Lisa", 57, 3)
#endif

  ! Dont edit anything below this line
  call print_person(lisa)
  call print_person(john)

end program peopleprogram
