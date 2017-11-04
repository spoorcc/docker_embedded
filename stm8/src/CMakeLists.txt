cmake_minimum_required(VERSION 2.8)
project(blinkled C)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/CMakeModules/")
include(sdcc-stm8)

add_executable(blinkled main.c)
