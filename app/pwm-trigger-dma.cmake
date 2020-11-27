project(pwm-trigger-dma)

# This application provides custom design.modus for the below boards
psoc4_check_bsp(
  CY8CKIT-149
)

psoc4_load_application(
  NAME mtb-example-psoc4-pwm-trigger-dma
  VERSION 1.0.0
)
psoc4_add_executable(
  SOURCES
    ${APP_DIR}/main.c
  DESIGN_MODUS
    ${APP_DIR}/COMPONENT_CUSTOM_DESIGN_MODUS/TARGET_${BSP_NAME}/design.modus
  GENERATED_SOURCES
    cycfg.h
    cycfg.c
    cycfg_clocks.h
    cycfg_clocks.c
    cycfg_dmas.h
    cycfg_dmas.c
    cycfg_notices.h
    cycfg_peripherals.h
    cycfg_peripherals.c
    cycfg_pins.h
    cycfg_pins.c
    cycfg_routing.h
    cycfg_routing.c
    cycfg_system.h
    cycfg_system.c
)
