
# Build a docker image naming it after the directory
FUNCTION(build_docker_image directory_path)

    IF(EXISTS "${directory_path}" AND IS_DIRECTORY "${directory_path}")
        IF(EXISTS "${directory_path}/Dockerfile")
            CONFIGURE_FILE("${directory_path}/Dockerfile" "${directory_path}" COPYONLY)
            GET_FILENAME_COMPONENT(dirname "${directory_path}" NAME)
            EXEC_PROGRAM(docker "${directory_path}" ARGS "build -t ${dirname} .")
        ENDIF()
    ENDIF()

ENDFUNCTION(build_docker_image)

FILE(GLOB containers "Containers/*")
FOREACH(container ${containers})
   build_docker_image("${container}")
ENDFOREACH()
