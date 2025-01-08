module module2
use module3
implicit none 

contains 
subroutine who_am_I
implicit none 

print *, "who am I?"

call  drink_water
end subroutine who_am_I
end module module2

