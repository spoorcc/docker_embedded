
# Build all the containers during configuration
FILE(GLOB containers "containers/*")
FOREACH(container ${containers})
   DOCKER_BUILD(DIRECTORY "${container}")
ENDFOREACH()

DOCKER_RUN(TARGET build-avr
            IMAGE cmake-avr
            INPUT "${CMAKE_CURRENT_SOURCE_DIR}/src:/src"
           OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/bld:/artifacts"
          COMMAND /src/build.sh)

DOCKER_RUN(TARGET test-avr
            IMAGE cmake-simavr
            INPUT "${CMAKE_CURRENT_BINARY_DIR}/bld:/input"
           OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/test_results:/output"
          COMMAND /input/test.sh
          DEPENDS build-avr)
