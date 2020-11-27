# This application relies on BSP providing design.cycapsense
if(NOT TARGET bsp_design_capsense)
  return()
endif()

# This application provides custom design.modus for the below boards
psoc4_check_bsp(
  CY8CKIT-145-40XX
  CY8CKIT-149
)

project(capsense-csd-slider-tuning)

psoc4_load_application(
  NAME mtb-example-psoc4-capsense-csd-slider-tuning
  VERSION 1.0.0
)
psoc4_add_executable(
  SOURCES
    ${APP_DIR}/main.c
  LINK_LIBRARIES
    mtb-pdl-cat2
    capsense
  DESIGN_MODUS
    ${APP_DIR}/COMPONENT_CUSTOM_DESIGN_MODUS/TARGET_${BSP_NAME}/design.modus
  DESIGN_CAPSENSE
    ${APP_DIR}/COMPONENT_CUSTOM_DESIGN_MODUS/TARGET_${BSP_NAME}/design.cycapsense
)
