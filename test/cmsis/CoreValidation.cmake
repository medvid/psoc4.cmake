if(${TOOLCHAIN} STREQUAL IAR)
  return()
endif()

psoc4_add_executable(
  NAME
    CoreValidation
  SOURCES
    ${CMSIS_DIR}/CMSIS/CoreValidation/Include/cmsis_cv.h
    ${CMSIS_DIR}/CMSIS/CoreValidation/Include/CV_Framework.h
    ${CMSIS_DIR}/CMSIS/CoreValidation/Include/CV_Report.h
    ${CMSIS_DIR}/CMSIS/CoreValidation/Include/CV_Typedefs.h
    ${CMSIS_DIR}/CMSIS/CoreValidation/Source/cmsis_cv.c
    ${CMSIS_DIR}/CMSIS/CoreValidation/Source/CV_CoreFunc.c
    ${CMSIS_DIR}/CMSIS/CoreValidation/Source/CV_CoreInstr.c
    ${CMSIS_DIR}/CMSIS/CoreValidation/Source/CV_CoreSimd.c
    ${CMSIS_DIR}/CMSIS/CoreValidation/Source/CV_Framework.c
    ${CMSIS_DIR}/CMSIS/CoreValidation/Source/CV_Report.c
    ${CMSIS_DIR}/CMSIS/CoreValidation/Tests/main.c
  INCLUDE_DIRS
    ${CMSIS_DIR}/Device/ARM/ARMCM0plus/Include
    ${CMSIS_DIR}/CMSIS/CoreValidation/Include
    ${CMSIS_DIR}/CMSIS/CoreValidation/Tests
    ${CMSIS_DIR}/CMSIS/CoreValidation/Tests/config/core_m
  DEFINES
    ARMCM0P
)

if(${TOOLCHAIN} STREQUAL IAR)
  # TODO:  no definition for "__write", "__lseek", "__close", "remove"
  target_compile_options(CoreValidation PRIVATE "--dlib_config=full")
endif()
