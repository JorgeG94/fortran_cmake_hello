# Lesson 1: Starting a simple CMake project 

This first lesson will just cover compiling a very simple program using CMake, basically our main program will be 
a main.f90 which is simply a "hello world". 

We start by creating a file called `CMakeLists.txt` the CM and L capitalization matters! 

```
# this will make the cmake fail if you do not have at least version 3.22 this ensures that the constructs you are using
# are available 
cmake_minimum_required(VERSION 3.22)

# Set the project name and specify that it is a Fortran project
# by using the command project, CMake then creates the global variable
# ${PROJECT_SOURCE_DIR} which will be the `pwd` where this project command has been issued
project(MyFortranProject LANGUAGES Fortran)

# Add the executable target for the main Fortran file
#this works by add_executable(name_of_executable name_of_file)
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
