
# Build all the containers during configuration
FILE(GLOB containers "containers/*")
FOREACH(container ${containers})
   DOCKER_BUILD(DIRECTORY "${container}")
ENDFOREACH()

# Use docker images for performing the builds
DOCKER_RUN(TARGET build-stm32
            IMAGE cmake-stm32
            INPUT "${CMAKE_CURRENT_SOURCE_DIR}/src:/src"
           OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/bld:/artifacts"
          COMMAND /src/build.sh)
