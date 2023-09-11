program main
    use first_mod
    use second_mod
    implicit none
    call hello_from_first()
    call hello_from_second()
    call general_hello()
    call print_hello()
end program main

program MainProgram
    use InputFileGroups  ! Use the InputFileGroups module
    use first_mod
    use second_mod
    use InputFileGroups
    implicit none
    call hello_from_first()
    call hello_from_second()
    call general_hello()
    call print_hello()
  
    
    implicit none
  
    character(256), dimension(:), allocatable :: input_lines
    integer :: num_lines
  
    ! Call the read_gamess_input subroutine
    call read_gamess_input('input_file.dat', input_lines, num_lines)
  
    ! Now, input_lines is an allocated array containing the input file lines
    ! ...
  
    ! Deallocate input_lines when done to free memory
    deallocate(input_lines)
  
  end program MainProgram
  

