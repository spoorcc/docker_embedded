
# Build a docker image naming it after the directory
FUNCTION(DOCKER_BUILD)
      set(options)
      set(oneValueArgs DIRECTORY IMAGE)
      set(multiValueArgs)
      cmake_parse_arguments(DOCKER_BUILD "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN} )

      MESSAGE("-- Building docker image ${DOCKER_BUILD_IMAGE} from ${DOCKER_BUILD_DIRECTORY}")
      IF(EXISTS "${DOCKER_BUILD_DIRECTORY}" AND IS_DIRECTORY "${DOCKER_BUILD_DIRECTORY}")
          IF(EXISTS "${DOCKER_BUILD_DIRECTORY}/Dockerfile")
              CONFIGURE_FILE("${DOCKER_BUILD_DIRECTORY}/Dockerfile" "${DOCKER_BUILD_DIRECTORY}" COPYONLY)

              IF(NOT "${DOCKER_BUILD_IMAGE}")
                   GET_FILENAME_COMPONENT(DOCKER_BUILD_IMAGE "${DOCKER_BUILD_DIRECTORY}" NAME)
              ENDIF()

              EXEC_PROGRAM(docker "${DOCKER_BUILD_DIRECTORY}" ARGS "build -t ${DOCKER_BUILD_IMAGE} .")
          ENDIF()
      ENDIF()

ENDFUNCTION(DOCKER_BUILD)

FUNCTION(DOCKER_RUN)
      set(options)
      set(oneValueArgs TARGET IMAGE INPUT OUTPUT)
      set(multiValueArgs COMMAND DEPENDS)
      cmake_parse_arguments(DOCKER_RUN "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN} )

      MESSAGE("-- Will create new target ${DOCKER_RUN_TARGET} for running ${DOCKER_RUN_COMMAND} on ${DOCKER_RUN_IMAGE}")
      SET(DOCKER_RUN_CMAKE_SCRIPT "${CMAKE_BINARY_DIR}/${DOCKER_RUN_TARGET}.cmake")

      FILE(WRITE ${DOCKER_RUN_CMAKE_SCRIPT}
"
MESSAGE(\"-- Starting ${DOCKER_RUN_IMAGE}\")
EXEC_PROGRAM(docker ARGS \"run --rm -it -v ${DOCKER_RUN_INPUT}:ro -v ${DOCKER_RUN_OUTPUT} ${DOCKER_RUN_IMAGE} ${DOCKER_RUN_COMMAND}\")
MESSAGE(\"-- Done on ${DOCKER_RUN_IMAGE}\")
"
      )

      ADD_CUSTOM_TARGET(${DOCKER_RUN_TARGET} ALL
                        ${CMAKE_COMMAND} -P ${DOCKER_RUN_CMAKE_SCRIPT}
                        DEPENDS "${DOCKER_RUN_DEPENDS}")

ENDFUNCTION(DOCKER_RUN)
