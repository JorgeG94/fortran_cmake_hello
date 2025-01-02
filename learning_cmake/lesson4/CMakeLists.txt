cmake_minimum_required(VERSION 3.22)

# Set the project name and specify that it is a Fortran project
project(MyFortranProject LANGUAGES Fortran)

# Set compiler flags (e.g., optimization and warnings)
add_compile_options(-O2 -Wall)

# Create a library from the module.f90 file
add_library(mod_hello STATIC source/module.f90)

# Add the executable target for the main Fortran file in the source/ directory
add_executable(main_executable source/main.f90)

# Link the module library to the main executable
target_link_libraries(main_executable PRIVATE mod_hello)

