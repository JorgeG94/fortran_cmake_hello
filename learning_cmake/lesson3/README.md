# Lesson 3: Adding subdirectores  

Now let's learn how to compile files that are not in the top level directory, aka the `${PROJECT_SOURCE_DIR}`.

```
cmake_minimum_required(VERSION 3.22)

project(MyFortranProject LANGUAGES Fortran)

add_compile_options(-O2 -Wall)

# because this is a simple one file source, we can point to source directly from the top level
add_executable(main_executable source/main.f90)
```

## How to build:

```
mkdir build
cd build
cmake ../
make 
./main_executable
```
