module mod_hello_from_module
use module2
implicit none 
contains 
subroutine hello_from_module()
implicit none
print *, "hello cmake from module!"
end subroutine hello_from_module 

subroutine print_other_stuff
implicit none 
call who_am_I
end subroutine print_other_stuff

end module mod_hello_from_module
