cmake_minimum_required(VERSION 3.23)

project(my_project VERSION 0.0
        DESCRIPTION "My Fortran program"
        LANGUAGES Fortran C CXX)

enable_language(Fortran)
enable_language(C)
enable_language(CXX)


set(default_build_type "Release")
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  message(STATUS "Setting build type to '${default_build_type}' as none was specified.")
  set(CMAKE_BUILD_TYPE "${default_build_type}" CACHE STRING "Choose the type of build." FORCE)
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()

set(project_name quetzal)
set(main_library quetzal_lib)
set(f77_library quetzal_f77_lib)
set(all_binaries ${project_name} ${main_library} ${f77_library})

set(LIBRARY_TYPE STATIC)

add_library(${main_library} ${LIBRARY_TYPE})
add_library(${f77_library} ${LIBRARY_TYPE})
#set(Fortran_MODULE_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/modules)

target_include_directories(${main_library} PUBLIC 
#${Fortran_MODULE_DIRECTORY}
			   #${CMAKE_CURRENT_SOURCE_DIR}/source/sample
			   #${CMAKE_CURRENT_SOURCE_DIR}/source/utilities
)
find_package(OpenMP REQUIRED)
find_package(HDF5 REQUIRED)

target_link_libraries(${main_library} PUBLIC OpenMP::OpenMP_Fortran hdf5::hdf5_fortran)


set_target_properties(${main_library} PROPERTIES 
			Fortran_FORMAT FREE
			)
set_target_properties(${f77_library} PROPERTIES 
			Fortran_FORMAT FREE
			)
#set(FVERSION "-std=f95")
set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS}")

target_compile_options(${main_library} PRIVATE ${FVERSION})

add_executable(${project_name} ${CMAKE_CURRENT_SOURCE_DIR}/source/main.f90)
target_include_directories(${project_name} PUBLIC
#${Fortran_MODULE_DIRECTORY}
#			   ${CMAKE_CURRENT_SOURCE_DIR}/source/sample
#			   ${CMAKE_CURRENT_SOURCE_DIR}/source/utilities
)
target_link_libraries(${project_name} PRIVATE ${main_library} ${f77_library})

install(TARGETS ${project_name} DESTINATION ${PROJECT_SOURCE_DIR})


# Source code
add_subdirectory(source)

