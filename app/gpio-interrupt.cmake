project(gpio-interrupt)

# This application provides custom design.modus for the below boards
psoc4_check_bsp(
  CY8CKIT-041-41XX
  CY8CKIT-145-40XX
  CY8CKIT-149
)

psoc4_load_application(
  NAME mtb-example-psoc4-gpio-interrupt
  VERSION 2.0.0
)
psoc4_add_executable(
  SOURCES
    ${APP_DIR}/main.c
  DESIGN_MODUS
    ${APP_DIR}/COMPONENT_CUSTOM_DESIGN_MODUS/TARGET_${BSP_NAME}/design.modus
)
