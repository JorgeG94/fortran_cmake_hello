program cmake_lesson1
use mod_hello_from_module, only: hello_from_module
implicit none 

print *, "hello, cmake!"

call hello_from_module

call hello_from_f77
end program cmake_lesson1
