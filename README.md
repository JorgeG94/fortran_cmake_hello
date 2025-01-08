# Lesson 7 

This one is simply to teach the concept of more complex project structures, different fortran standards, and how to 
compile larger projects. 

GAMESS currently approaches compilation by simply compiling all source files into objects and waiting till the 
end to link into the GAMESS executable. 

CMake can do this well enough too, however it is in our best interest to minimize errors and reduce recompilation of 
unecessary files to divide projects into libraries of similar code. 

In this simple project we have the following project structure:

```
source/
source/main.f90
source/f77/subroutine.f 
source/f90/module.f90 
```

This of course can be as complex as you can, you can further add new subdirectories, say:
```
source/f90/integrals 
source/f90/fock_build
source/f90/math
```

You could, from the top level directory add each file that is present in each directory. However, this would be toxic. 
Instead, we use the cmake command `add_subdirectory(dir_name)`. This basically includes a directory into your 
CMake build. For example, the CMake at the top has: `add_subdirectory(source)`. Then from the `CMakeLists.txt` in `source/`
we have the same `add_subdirectory(f77/f90)` that includes those two subdirectories in the build.

The `CMakeLists.txt` at the `source/` level just serves as a point of control. Then inside each one of these 
directories. We include the source files into the corresponding library. In the main `CMakeLists.txt` you can see we did:

```
add_library(f90_lib STATIC)
add_library(f77_lib STATIC)
```

We created two `TARGETS` that are libraries and they are both static. You can feed sources into these targets by doing:

`target_sources(f77_lib PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/subroutine.f)`

This will attach `subroutine.f` into the `f77_lib` target that you've created. Same for the other directory that contains f90 files. 

This is a simple example, you _do not_ need to separate f77 from f90 if you don't want to. However, because they might take different global flags, it might be best to do so. 

Then the final step is linking these libraries into your executable: 

`target_link_libraries(main_executable PRIVATE f90_lib f77_lib)`

This creates a dependency, the executable will not be created until f90 and f77 lib are compiled. 

