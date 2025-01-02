cmake_minimum_required(VERSION 3.22)

# Set the project name and specify that it is a Fortran project
project(MyFortranProject LANGUAGES Fortran)

# Set the directory to store the compiled Fortran modules (.mod files)
set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/modules)

# Find MPI
find_package(MPI REQUIRED)
if (MPI_Fortran_FOUND)
    include_directories(SYSTEM ${MPI_Fortran_INCLUDE_PATH})
endif()

# Find OpenMP
find_package(OpenMP REQUIRED)

# Find BLAS and LAPACK
find_package(BLAS REQUIRED)
find_package(LAPACK REQUIRED)

# Create a library from the module.f90 file
add_library(mod_hello STATIC source/module.f90)

# Ensure the module files from the library are stored in the module directory
set_target_properties(mod_hello PROPERTIES Fortran_MODULE_DIRECTORY ${CMAKE_Fortran_MODULE_DIRECTORY})

# Set compile flags for the module library (-Wall)
target_compile_options(mod_hello PRIVATE -Wall)

# Add the executable target for the main Fortran file in the source/ directory
add_executable(main_executable source/main.f90)

# Set compile flags for the main executable (-O3)
target_compile_options(main_executable PRIVATE -O3)

# Make sure the main executable can find the modules in the specified directory
target_include_directories(main_executable PRIVATE ${CMAKE_Fortran_MODULE_DIRECTORY})

# Link the MPI, OpenMP, BLAS, and LAPACK libraries to the final executable
target_link_libraries(main_executable PRIVATE mod_hello MPI::MPI_Fortran OpenMP::OpenMP_Fortran BLAS::BLAS LAPACK::LAPACK)

