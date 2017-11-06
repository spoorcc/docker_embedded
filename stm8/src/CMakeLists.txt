cmake_minimum_required(VERSION 2.8)
set(STM8_CHIP stm8s208mb)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/CMakeModules/")
include(sdcc-generic)
include(sdcc-stm8)

project(blinkled C)

add_executable(blinkled main.c)
