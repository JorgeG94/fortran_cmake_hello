module mod_hello_from_module
implicit none 
contains 
subroutine hello_from_module()
print *, "hello cmake from module!"
end subroutine hello_from_module 

end module mod_hello_from_module
