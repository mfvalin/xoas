cmake_minimum_required(VERSION 2.8.12)
#cmake_minimum_required(VERSION 2.8.7)

project(GEM_EXPO NONE)

# gfortran is defined here as the default compiler
# Its value can be changed here, or using the command:
# cmake -DCOMPILER=ifort or cmake -DCOMPILER=pgfortran
set(COMPILER gfortran CACHE INTERNAL compiler)
message(STATUS "Compiler to be used is: ${COMPILER}")

# Include an architecture dependent file that contains settings for a
# particular architecture and compiler, using the default value of the
# compiler defined above or the argument given to cmake command.
set(ARCH "${CMAKE_SYSTEM_NAME}-${CMAKE_SYSTEM_PROCESSOR}")
include("${ARCH}-${COMPILER}.cmake")
message(STATUS "include ${ARCH}-${COMPILER}.cmake")

# get name and version of operating system
execute_process(COMMAND sh "-c" "${CMAKE_CURRENT_SOURCE_DIR}/os.sh" OUTPUT_VARIABLE OS)
message(STATUS "Operating system is: ${OS}")

# get name and version of compiler
execute_process(COMMAND sh "-c" "${CMAKE_CURRENT_SOURCE_DIR}/compiler.sh ${COMPILER}" OUTPUT_VARIABLE COMP_VERSION)
message(STATUS "Compiler version is: ${COMPILER} ${COMP_VERSION}")

set(BUILD build)
set(ROOT ${CMAKE_CURRENT_SOURCE_DIR})

# Enable the two languages that are used
enable_language(C)
enable_language(Fortran)
set(CMAKE_Fortran_SOURCE_FILE_EXTENSIONS f;f90;F90 CACHE STRING "Fortran extension files")

# message(STATUS "CMAKE_<LANG>_COMPILER_VERSION: ${CMAKE_C_COMPILER_VERSION}")
#message(STATUS "COMPILER_BASE_NAME: ${COMPILER_BASE_NAME}")
# Enable distclean target
include("distclean.cmake")

set(FTNSRC "" CACHE INTERNAL "" FORCE)
set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${BUILD}/modules CACHE STRING "Where Fortran modules go")

message("Sources directory is: ${CMAKE_CURRENT_SOURCE_DIR}")
message("Build directory is: ${CMAKE_CURRENT_BINARY_DIR}")

add_definitions(-DWITHOUT_OpenMP)

# Include an architecture dependent file that contains include files for a
# particular architecture and compiler, using the default value of the
# compiler defined above or the argument given to cmake command.
message(STATUS "arch-dependent include directory: src/archdep/include/${ARCH}-${COMPILER}")

include_directories(src/archdep/include/${ARCH}-${COMPILER}
                    ${CMAKE_CURRENT_BINARY_DIR}/${BUILD}/modules
                    ${ROOT}/src/rmn/PUBLIC_INCLUDES
                    ${ROOT}/src/RPN/compiler_includes
                    )

#TODO - link to the local libraries already installed
#link_directories(${ROOT}/src/archdep/libs/${ARCH})

add_subdirectory(src ${BUILD}/src)