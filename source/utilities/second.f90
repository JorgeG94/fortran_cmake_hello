module second_mod
    implicit none
contains
    subroutine hello_from_second()
        write(*, *) "Hello from second!"
    end subroutine hello_from_second
end module second_mod

