# CMake rules for the retrofit utilities in upgrade/src
# These programs were intended for BSD upgrades on V6 systems.  They
# rely on the retrofit headers and optional libretro static library.

include_directories(
  ${CMAKE_SOURCE_DIR}/compat
  ${CMAKE_SOURCE_DIR}/upgrade/include
)

# Use the prebuilt libretro if available
set(LIBRETRO_A ${CMAKE_SOURCE_DIR}/upgrade/libretro/libretro.a)
if(EXISTS ${LIBRETRO_A})
  add_library(retro STATIC IMPORTED)
  set_target_properties(retro PROPERTIES IMPORTED_LOCATION ${LIBRETRO_A})
endif()

set(UCB_TOOLS
  from
  last
  ls
  mkstr
  msgs
  printenv
  reset
  setenv
  strings
  tset
  whereis
)

foreach(tool IN LISTS UCB_TOOLS)
  add_executable(${tool} ${tool}.c)
  target_compile_features(${tool} PRIVATE c_std_11)
  target_compile_options(${tool} PRIVATE -Wall -Wextra -O2)
  if(TARGET retro)
    target_link_libraries(${tool} PRIVATE retro)
  endif()
endforeach()

