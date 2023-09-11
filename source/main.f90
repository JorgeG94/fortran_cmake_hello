program MainProgram
    use InputFileGroups  ! Use the InputFileGroups module
    use first_mod
    use second_mod
    use InputFileGroups
    implicit none
    type(InputLinesType) :: input_lines
    integer :: num_lines
    call hello_from_first()
    call hello_from_second()
    call general_hello()
    call print_hello()

  

  
    ! Call the read_gamess_input subroutine
    call read_gamess_input('w1.inp', input_lines, num_lines)

    write(*,*) input_lines%lines
    
  
    ! Now, input_lines is an allocated array containing the input file lines
    ! ...
  
    ! Deallocate input_lines when done to free memory
    !deallocate(input_lines)
  
  end program MainProgram
  

