module InputFileGroups
  implicit none

  ! Define a derived type for the $CONTRL group
  type ContrlGroup
    character(12) :: SCFTYP
    character(12) :: RUNTYP
    integer :: MAXIT
  end type ContrlGroup

  ! Define a derived type for the $SYSTEM group
  type SystemGroup
    character(12) :: COORD
    integer :: MWORDS
    integer :: MEMDDI
  end type SystemGroup

  ! Define a derived type for the $BASIS group
  type BasisGroup
    character(12) :: GBASIS
    integer :: NGAUSS
    integer :: NDFUNC
  end type BasisGroup

contains


subroutine read_gamess_input(input_filename, input_lines, num_lines)
  implicit none 
  character(*), intent(in) :: input_filename
  !character(256), dimension(:), allocatable, intent(out) :: input_lines
  character(256), intent(out) :: input_lines

  integer, intent(out) :: num_lines

  integer :: unit
  integer :: i
  character(256) :: line

  character(256), dimension(:), allocatable :: temp_lines

  ! Attempt to open the input file
  open(unit, file=input_filename, status='old', action='read', iostat=i)
  if (i /= 0) then
    write(*, *) 'Error opening input file ', input_filename
    stop
  end if

  ! Count the number of lines in the file
  num_lines = 0
  do
    read(unit, '(A)', iostat=i) line
    if (i /= 0) exit
    num_lines = num_lines + 1
  end do

  ! Allocate memory for temp_lines array
  allocate(temp_lines(num_lines))

  ! Rewind the file and read lines into the temp_lines array
  rewind(unit)
  do i = 1, num_lines
    read(unit, '(A)') temp_lines(i)
  end do

  ! Close the file
  close(unit)

  ! Copy data from temp_lines to input_lines
  !allocate(input_lines(num_lines))
  input_lines = temp_lines

  ! Deallocate temp_lines
  deallocate(temp_lines)

end subroutine read_gamess_input
  ! Add subroutines or functions for reading and manipulating the groups if needed

end module InputFileGroups





