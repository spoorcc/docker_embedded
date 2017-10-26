PROJECT(DockerEmbedded)

CMAKE_MINIMUM_REQUIRED(VERSION 2.8 FATAL_ERROR)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/CMakeModules/")

include(Docker)

# Build all the containers during configuration
FILE(GLOB containers "tools/Containers/*")
FOREACH(container ${containers})
   DOCKER_BUILD(DIRECTORY "${container}")
ENDFOREACH()

# Use docker images for performing the builds
DOCKER_RUN(TARGET build-msp430
            IMAGE cmake-msp430
            INPUT "${CMAKE_SOURCE_DIR}/src/msp430:/src"
           OUTPUT "${CMAKE_BINARY_DIR}/msp:/artifacts"
          COMMAND /src/build.sh)

DOCKER_RUN(TARGET build-avr
            IMAGE cmake-avr
            INPUT "${CMAKE_SOURCE_DIR}/src/avr:/src"
           OUTPUT "${CMAKE_BINARY_DIR}/avr:/artifacts"
          COMMAND /src/build.sh)

DOCKER_RUN(TARGET test-avr
            IMAGE cmake-simavr
            INPUT "${CMAKE_BINARY_DIR}/avr:/input"
           OUTPUT "${CMAKE_BINARY_DIR}/avr/test_results:/output"
          COMMAND /input/test.sh
          DEPENDS build-avr)
