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
      set(options PRIVILEGED)
      set(oneValueArgs TARGET IMAGE)
      set(multiValueArgs INPUT OUTPUT VOLUME COMMAND DEPENDS)
      cmake_parse_arguments(DOCKER_RUN "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN} )

      MESSAGE("-- Will create new target ${DOCKER_RUN_TARGET} for running ${DOCKER_RUN_COMMAND} on ${DOCKER_RUN_IMAGE}")
      SET(DOCKER_RUN_CMAKE_SCRIPT "${CMAKE_BINARY_DIR}/${DOCKER_RUN_TARGET}.cmake")

      IF(DOCKER_RUN_PRIVILEGED)
          set(DOCKER_FLAGS "--privileged")
      ENDIF()

      IF(DOCKER_RUN_INPUT)
          FOREACH(MAPPING IN ITEMS ${DOCKER_RUN_INPUT})
              STRING(CONCAT DOCKER_RUN_INPUT_TMP "${DOCKER_RUN_INPUT_TMP}" "-v " ${MAPPING} ":ro ")
          ENDFOREACH()
          set(DOCKER_RUN_INPUT ${DOCKER_RUN_INPUT_TMP})
      ENDIF()

      IF(DOCKER_RUN_OUTPUT OR DOCKER_RUN_VOLUME)
          LIST(APPEND ${DOCKER_RUN_VOLUME} ${DOCKER_RUN_OUTPUT})
          FOREACH(MAPPING IN ITEMS ${DOCKER_RUN_VOLUME})
              STRING(CONCAT DOCKER_RUN_OUTPUT_TMP "${DOCKER_RUN_OUTPUT_TMP}" "-v " ${MAPPING} " ")
          ENDFOREACH()
          set(DOCKER_RUN_OUTPUT ${DOCKER_RUN_OUTPUT_TMP})
      ENDIF()

      FILE(WRITE ${DOCKER_RUN_CMAKE_SCRIPT}
"
MESSAGE(\"-- Starting ${DOCKER_RUN_IMAGE}\")
EXEC_PROGRAM(docker ARGS \"run --rm -it ${DOCKER_FLAGS} ${DOCKER_RUN_INPUT} ${DOCKER_RUN_OUTPUT} ${DOCKER_RUN_IMAGE} ${DOCKER_RUN_COMMAND}\")
MESSAGE(\"-- Done on ${DOCKER_RUN_IMAGE}\")
"
      )

      ADD_CUSTOM_TARGET(${DOCKER_RUN_TARGET} ALL
                        ${CMAKE_COMMAND} -P ${DOCKER_RUN_CMAKE_SCRIPT}
                        DEPENDS "${DOCKER_RUN_DEPENDS}")

ENDFUNCTION(DOCKER_RUN)
