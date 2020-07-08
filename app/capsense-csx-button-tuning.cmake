# This applications relies on BSP providing design.cycapsense
if(NOT TARGET bsp_design_capsense)
  return()
endif()

# This application provides custom design.modus for the below boards
psoc4_check_bsp(
  CY8CKIT-149
)

project(capsense-csx-button-tuning)

psoc4_load_application(
  NAME mtb-example-psoc4-capsense-csx-button-tuning
  VERSION 1.0.0
)
psoc4_add_executable(
  SOURCES
    ${APP_DIR}/main.c
  LINK_LIBRARIES
    psoc4pdl
    capsense
  DESIGN_MODUS
    ${APP_DIR}/COMPONENT_CUSTOM_DESIGN_MODUS/TARGET_${BSP_NAME}/design.modus
  DESIGN_CAPSENSE
    ${APP_DIR}/COMPONENT_CUSTOM_DESIGN_MODUS/TARGET_${BSP_NAME}/design.cycapsense
  GENERATED_SOURCES
    cycfg.h
    cycfg.c
    cycfg_clocks.h
    cycfg_clocks.c
    cycfg_notices.h
    cycfg_peripherals.h
    cycfg_peripherals.c
    cycfg_pins.h
    cycfg_pins.c
    cycfg_routing.h
    cycfg_system.h
    cycfg_system.c
)
