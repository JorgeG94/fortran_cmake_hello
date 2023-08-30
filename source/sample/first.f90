module first_mod
    implicit none
contains
    subroutine hello_from_first()
        write(*, *) "Hello from first!"
    end subroutine hello_from_first
end module first_mod

subroutine general_hello()
  write(*,*) "alo bendicion"
end subroutine general_hello
