project(spi-slave)

# This application provides custom design.modus for the below boards
psoc4_check_bsp(
  CY8CKIT-041-41XX
  CY8CKIT-145-40XX
  CY8CKIT-149
)

psoc4_load_application(
  NAME mtb-example-psoc4-spi-slave
  VERSION 1.0.0
)
psoc4_add_executable(
  SOURCES
    ${APP_DIR}/source/main.c
    ${APP_DIR}/source/SpiSlave.h
    ${APP_DIR}/source/SpiSlave.c
  DESIGN_MODUS
    ${APP_DIR}/COMPONENT_CUSTOM_DESIGN_MODUS/TARGET_${BSP_NAME}/design.modus
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
# TODO: data-driven from the BSP build recipe?
if (${BSP_NAME} STREQUAL CY8CKIT-149)
  target_sources(${TARGET_NAME} PRIVATE ${CUSTOM_GENERATED_SOURCE_DIR}/cycfg_routing.c)
endif()