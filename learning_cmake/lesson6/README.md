# Lesson 6: Adding known dependencies 

CMake has a lot of known dependencies, you can find them [here](https://cmake.org/cmake/help/latest/command/find_package.html) 
and the possible options to use. For example, we can use `find_package(BLAS)` to find our BLAS library. CMake will look in common places, or use environment variables to find the libraries. For example, see the find [BLAS](https://cmake.org/cmake/help/latest/module/FindBLAS.html) documentation. 

Our CMake is now getting more complex, so let's just focus on the main things here:
```
find_package(BLAS)
#versus 
find_package(BLAS REQUIRED)
```

The `REQUIRED` keyword will make the build fail if BLAS is not found, if `REQUIRED` is not used then the build will just show a 
warning that it failed to find BLAS. If it is not a critical dependency, the code will still compile and link. 

To link the found libraries, many of these `find_package` packages come with a custom `target` to link into, for example in the project 
here, we have asked for OpenMP, MPI, BLAS, and LAPACK: therefore, we can link like:

```
target_link_libraries(main_executable PRIVATE mod_hello MPI::MPI_Fortran OpenMP::OpenMP_Fortran BLAS::BLAS LAPACK::LAPACK)
```

## How to build:

```
mkdir build
cd build
cmake ../
make 
./main_executable
```
