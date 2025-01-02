cmake_minimum_required(VERSION 3.22)

# Set the project name and specify that it is a Fortran project
project(MyFortranProject LANGUAGES Fortran)

# Set the directory to store the compiled Fortran modules (.mod files)
set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/modules)

# create libraries for the f90 and f77 code
add_library(f90_lib STATIC)
add_library(f77_lib STATIC)

# Ensure the module files from the library are stored in the module directory
set_target_properties(f90_lib PROPERTIES Fortran_MODULE_DIRECTORY ${CMAKE_Fortran_MODULE_DIRECTORY})

# Set compile flags for the module library (-Wall)
target_compile_options(f90_lib PRIVATE -Wall)

# Add the executable target for the main Fortran file in the source/ directory
add_executable(main_executable source/main.f90)

# Set compile flags for the main executable (-O3)
target_compile_options(main_executable PRIVATE -O3)

# Make sure the main executable can find the modules in the specified directory
target_include_directories(main_executable PRIVATE ${CMAKE_Fortran_MODULE_DIRECTORY})

# Link the MPI, OpenMP, BLAS, and LAPACK libraries to the final executable
target_link_libraries(main_executable PRIVATE f90_lib f77_lib)

add_subdirectory(source)
