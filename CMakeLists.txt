# CMake build script for the UnixV6_BSD2 project
#
# This file orchestrates optional compilation on a modern host.  The
# historic sources rely on classic makefiles; we expose convenience
# targets so `cmake --build` can delegate into them when requested.
#
# -- Toolchain requirements -------------------------------------------------
#   * GCC 10+ or Clang 12+ with C11 support
#   * Standard flags : -Wall -Wextra -O2 -pedantic
#   * Additional -fcommon may be required for some legacy objects
# --------------------------------------------------------------------------
cmake_minimum_required(VERSION 3.16)
project(UnixV6_BSD2 LANGUAGES C)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

#------------------------------------------------------------------------------
# Legacy subtrees built via their original Makefiles
#------------------------------------------------------------------------------
set(SRC_SUBDIRS
  src
  src/termlib
  src/Mail
  src/csh
  src/ex
  src/eyacc
  src/libNS
  src/me
  src/net
  src/pascal
  src/pi
  src/pi0
  src/pi1
  src/px
  src/pxp
  src/pxref
)
set(UPGRADE_SUBDIRS
  upgrade/libretro
  upgrade/src
)

# Convenience target to invoke make in each legacy directory
set(LEGACY_TARGETS)
foreach(dir IN LISTS SRC_SUBDIRS UPGRADE_SUBDIRS)
  add_custom_target(make_${dir}
    COMMAND ${CMAKE_MAKE_PROGRAM} -C ${CMAKE_SOURCE_DIR}/${dir}
    COMMENT "Building legacy tree ${dir} with make")
  list(APPEND LEGACY_TARGETS make_${dir})
endforeach()
add_custom_target(legacy ALL DEPENDS ${LEGACY_TARGETS})

#------------------------------------------------------------------------------
# Tiny modern utilities in src/
#------------------------------------------------------------------------------
add_subdirectory(src)

#------------------------------------------------------------------------------
# Programs for retrofit environments under upgrade/src
#------------------------------------------------------------------------------
add_subdirectory(upgrade/src)
