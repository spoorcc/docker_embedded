
# Build all the containers during configuration
FILE(GLOB containers "containers/*")
FOREACH(container ${containers})
   DOCKER_BUILD(DIRECTORY "${container}")
ENDFOREACH()

# Use docker images for performing the builds
DOCKER_RUN(TARGET build-stm8
            IMAGE cmake-stm8
            INPUT "${CMAKE_CURRENT_SOURCE_DIR}/src:/src"
           OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/bld:/artifacts"
          COMMAND /src/build.sh)

DOCKER_RUN(PRIVILEGED TARGET flash-stm8
            IMAGE stm8-flash
            INPUT "${CMAKE_CURRENT_BINARY_DIR}/bld:/artifacts"
            OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/tmp:/bld"
            VOLUME "/dev/bus/usb:/dev/bus/usb"
            COMMAND "stm8flash -c stlink -p stm8s208?b -r /bld/data")

IF(UNIX)
    MESSAGE("-- Checking STM LINK v1 workaround is present")
    SET(USB_STORAGE_QUIRK_FILE "/sys/module/usb_storage/parameters/quirks")
    FILE(READ ${USB_STORAGE_QUIRK_FILE} USB_STORAGE_QUIRKS)

    STRING(FIND ${USB_STORAGE_QUIRKS} "0483:3744:i" STR_POSITION)

    IF(STR_POSITION LESS 0)
        MESSAGE(WARNING "
On Linux STM-LinkV1 is buggy and tries to mount storage. This must be disabled
As root user make sure it is ignored

echo 0483:3744:i >> ${USB_STORAGE_QUIRK_FILE}
")
    ENDIF()

ENDIF()
