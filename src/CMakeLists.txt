# CMake rules for modern utilities within the src directory
# These programs are simple single-file tools; they compile cleanly on
# modern compilers with minimal headers.

set(UTILS
  whoami
  head
  expand
  printenv
)

foreach(prog IN LISTS UTILS)
  add_executable(${prog} ${prog}.c)
  target_include_directories(${prog} PRIVATE ${CMAKE_SOURCE_DIR}/compat)
  target_compile_features(${prog} PRIVATE c_std_11)
  target_compile_options(${prog} PRIVATE -Wall -Wextra -O2)
endforeach()

