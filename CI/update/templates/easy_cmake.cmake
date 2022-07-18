# This file was autogenerated by {{scriptfile}}.
# Use it in your CMake configuration by `include()`'ing it.
# You can also copy it in your sketch's folder and edit it to fit your project.

cmake_minimum_required(VERSION 3.13)

# STEP 1: set up bases of environment
# -----------------------------------------------------------------------------

file(REAL_PATH "{{corepath}}" CORE_PATH EXPAND_TILDE)
file(TO_CMAKE_PATH "{{"${CORE_PATH}"}}" CORE_PATH)

file(REAL_PATH "{{userlibs}}" USER_LIBS EXPAND_TILDE)
file(TO_CMAKE_PATH "{{"${USER_LIBS}"}}" USER_LIBS)

set(BOARDNAME "{{boardname or "@board_name_here@"}}")

list(APPEND CMAKE_MODULE_PATH {{"${CORE_PATH}"}}/cmake)
set(CMAKE_TOOLCHAIN_FILE toolchain)


# You may remove this block when using this file as the sketch's CMakeLists.txt
if (NOT ${CMAKE_PARENT_LIST_FILE} STREQUAL ${CMAKE_CURRENT_LIST_FILE})
    # When we are imported from the main CMakeLists.txt, we should stop here
    # not to interfere with the true build config.
    return()
endif()



# STEP 2: configure the build
# -----------------------------------------------------------------------------

include(set_board)
set_board("{{"${BOARDNAME}"}}"
  # SERIAL generic
  # USB none
  # XUSB FS
  # VIRTIO disabled
)

include(overall_settings)
overall_settings(
  # STANDARD_LIBC
  # PRINTF_FLOAT
  # SCANF_FLOAT
  # DEBUG_SYMBOLS
  # LTO
  # NO_RELATIVE_MACRO
  # UNDEF_NDEBUG
  # OPTIMIZATION "s"
  # BUILD_OPT ./build.opt
  # DISABLE_HAL_MODULES ADC I2C RTC SPI TIM DAC EXTI ETH SD QSPI
)

# STEP 3: configure your sketch
# -----------------------------------------------------------------------------
project("{{tgtname+"_project" if tgtname else "@project_name_here@"}}")

include(external_library)
# I cannot tell the dependencies of the library ahead-of-time
# Please write them in using the DEPENDS ... clause
{% for libdir in libs | sort %}
external_library(PATH "{{"${USER_LIBS}"}}/{{libdir}}")
{% endfor %}

include(build_sketch)
build_sketch(TARGET "{{tgtname or "@binary_name_here@"}}"
  SOURCES
  {% for file in scrcfiles | sort %}
  {{file}}
  {% else %}
  ./file1.ino
  ./file2.ino
  ./file3.cpp
  ./file4.c
  ./file5.S
  {% endfor %}

  # DEPENDS
  # SD
  # Wire
)

# STEP 4: optional features
# -----------------------------------------------------------------------------

include(insights)
insights(TARGET "{{tgtname or "@binary_name_here@"}}"
  # DIRECT_INCLUDES
  # TRANSITIVE_INCLUDES
  # SYMBOLS
  # ARCHIVES
  # LOGIC_STRUCTURE
)
