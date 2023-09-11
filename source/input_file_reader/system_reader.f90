module SystemReader
  use InputFileGroups
  implicit none
  

contains

subroutine read_system_group(input_lines, system_data)
  type(InputLinesType), intent(in) :: input_lines
  type(SystemGroup), intent(out) :: system_data

  character(256), pointer :: lines(:)
  integer :: i, num_lines
  character(256) :: line, value
  logical :: group_found, multiple_contrls

  ! Initialize variables
  system_data%MWORDS = 1000
  system_data%MEMDDI = 1000

  ! Get a pointer to the lines array
  lines => input_lines%lines

  ! Get the number of lines in the input
  num_lines = size(lines)

  ! Initialize flags
  group_found = .false.
  multiple_contrls = .false.

  ! Loop through the input lines
  i = 1

  do while (i <= num_lines)
    ! Check if the line contains "$CONTRL" (case insensitive)
    if (index(trim(adjustl(lines(i))), "$SYSTEM") == 1) then
      if (group_found) then
        ! Multiple $CONTRL groups found, raise an error
        multiple_contrls = .true.
        exit
      end if
      group_found = .true.
      ! Initialize an empty line to accumulate $CONTRL group data
      line = ""
      do while (i <= num_lines)
        ! Accumulate lines within the $CONTRL group
        line = trim(adjustl(line)) // " " // trim(adjustl(lines(i)))
        ! Check if the current line ends with "$END" (case insensitive)
        if (index(line, "$END") == len_trim(line) - 3) then
          ! Process the accumulated line to extract keyword-value pairs
          call process_system_line(line, system_data)
          exit ! Exit the loop when "$END" is encountered
        end if
        i = i + 1
      end do
    end if
    i = i + 1
  end do

  ! If multiple $CONTRL groups are found, print an error message
  if (multiple_contrls) then
    print *, 'Error: Multiple $SYSTEM groups found in input.'
  end if

  ! If $CONTRL group is not found, print an error message
  if (.not. group_found) then
    print *, 'Error: $SYSTEM group not found in input.'
  end if
end subroutine read_system_group


subroutine process_system_line(line, system_data)
  character(256), intent(in) :: line
  type(SystemGroup), intent(out) :: system_data

  character(256) :: keyword, value
  integer :: index_equal, start_index, end_index

  ! Initialize variables
  ! Initialize variables
  system_data%MWORDS = 1000
  system_data%MEMDDI = 1000

  ! Find all occurrences of "=" in the line
  start_index = 9
  do while (start_index <= len_trim(line))
    ! Find the next "=" in the line
    index_equal = index(line(start_index:), '=')
    if (index_equal == 0) exit ! No more "=" found
    ! Determine the keyword and value based on "=" positions
    
    end_index = start_index + index_equal - 2
    keyword = trim(adjustl(line(start_index:end_index)))
    start_index = start_index + index_equal ! Move the start_index for the next search
    ! Find the end of the value (next space or end of line)
    do while (start_index <= len_trim(line) .and. line(start_index:start_index) == ' ')
      start_index = start_index + 1
    end do
    end_index = start_index
    do while (end_index <= len_trim(line) .and. line(end_index:end_index) /= ' ')
      end_index = end_index + 1
    end do
    value = trim(adjustl(line(start_index:end_index-1)))
    ! Process the keyword and value
    select case (keyword)
    case ("MWORDS")
      read(value, *) system_data%MWORDS
    case ("MEMDDI")
      read(value, *) system_data%MEMDDI
    end select
    start_index = end_index ! Move the start_index for the next search
  end do
end subroutine process_system_line


end module SystemReader





