# Lesson 4: Adding more files 

Now let's create another file that will contain a `module` which we will use in the main program. We want to compile this module
before the main subprogram. The best way to do this is by compiling the module first into a library, preferrably static to the link into the main program. 

```
cmake_minimum_required(VERSION 3.22)

# Set the project name and specify that it is a Fortran project
project(MyFortranProject LANGUAGES Fortran)

# Set compiler flags (e.g., optimization and warnings)
add_compile_options(-O2 -Wall)

# Set the directory to store the compiled Fortran modules (.mod files)
# this is specific for Fortran, if your project is C/C++ this is not needed
set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/modules)

# Create a library from the module.f90 file
# stil because this is a simple project, we can just point at it frmo the top level cmake
# add_library creates what we call a "target" which is simply a cmake construct that has certain properties
# we creating a STATIC library, this can also be SHARED, with the name mod_hello
add_library(mod_hello STATIC source/module.f90)

# Add the executable target for the main Fortran file in the source/ directory
add_executable(main_executable source/main.f90)

# Link the module library to the main executable
# by using this, we have created a dependency between main_executable and mod_hello
target_link_libraries(main_executable PRIVATE mod_hello)
```

## How to build:

```
mkdir build
cd build
cmake ../
make 
./main_executable
```
