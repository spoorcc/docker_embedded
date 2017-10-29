PROJECT(DockerEmbedded)

CMAKE_MINIMUM_REQUIRED(VERSION 2.8 FATAL_ERROR)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/CMakeModules/")

include(Docker)

add_subdirectory(avr)
add_subdirectory(msp430)
add_subdirectory(stm32)
