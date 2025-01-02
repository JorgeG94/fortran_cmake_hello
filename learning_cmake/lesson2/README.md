# Lesson 2: Compile flags for our simple project 

Here we will learn how to add compile flags! We will reuse most of Lesson 1. Only the new constructs will be commented

```
cmake_minimum_required(VERSION 3.22)

project(MyFortranProject LANGUAGES Fortran)

# Set compiler flags (e.g., optimization and warnings)
# this will set these flags for compilation for all files and directories below the current one 
add_compile_options(-O2 -Wall)

add_executable(main_executable main.f90)
```

## How to build:

```
mkdir build
cd build
cmake ../
make 
./main_executable
```
