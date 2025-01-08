      subroutine hello_from_f77
      use mod_hello_from_module
      implicit none 
      print *, 'Hello, cmake from f77 subroutine!'
      call hello_from_module
      end
