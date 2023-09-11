program MainProgram
   use InputFileGroups  ! Use the InputFileGroups module
   use first_mod
   use second_mod
   use InputFileGroups
   use ControlReader
   use SystemReader
   implicit none
   type(InputLinesType) :: input_lines
   type(ContrlGroup) :: control_data
   type(SystemGroup) :: system_data
   integer :: num_lines, i
   call hello_from_first()
   call hello_from_second()
   call general_hello()
   call print_hello()




   ! Call the read_gamess_input subroutine
   call read_gamess_input('w1.inp', input_lines, num_lines)


   
  ! Call the read_contrl_group subroutine to populate the control_data variable
  call read_contrl_group(input_lines, control_data)

  ! Now, control_data contains the data from the $CONTRL group
  print *, 'SCFTYP:', control_data%SCFTYP
  print *, 'RUNTYP:', control_data%RUNTYP
  print *, 'MAXIT:', control_data%MAXIT

  call read_system_group(input_lines, system_data)

  write(*,*) 'MWORDS:', system_data%MWORDS
  print *, 'MEMDDI:', system_data%MEMDDI


   ! Check if the lines array is allocated
   if (associated(input_lines%lines)) then
      deallocate(input_lines%lines)
   end if


   ! Now, input_lines is an allocated array containing the input file lines
   ! ...

   ! Deallocate input_lines when done to free memory
   !deallocate(input_lines)

end program MainProgram


