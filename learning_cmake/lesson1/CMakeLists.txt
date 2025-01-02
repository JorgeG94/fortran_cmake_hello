cmake_minimum_required(VERSION 3.22)

# Set the project name and specify that it is a Fortran project
project(MyFortranProject LANGUAGES Fortran)

# Add the executable target for the main Fortran file
add_executable(main_executable main.f90)

