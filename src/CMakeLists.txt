cmake_minimum_required(VERSION 2.8)

set(CMAKE_TOOLCHAIN_FILE "${CMAKE_SOURCE_DIR}/generic-gcc-msp430.cmake")

project(LedToggle)

# Set mandatory MCU variables
set(MSP430_MCU msp430g2553)
set(MSP430_MCU_FREQ 1000000UL)

msp430_add_executable(main main.c)
