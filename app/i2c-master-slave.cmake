project(i2c-master-slave)

# This application provides custom design.modus for the below boards
psoc4_check_bsp(
  CY8CKIT-149
)

psoc4_load_application(
  NAME mtb-example-psoc4-i2c-master-slave
  VERSION 1.0.0
)
psoc4_add_executable(
  SOURCES
    ${APP_DIR}/source/main.c
    ${APP_DIR}/source/I2CMaster.h
    ${APP_DIR}/source/I2CMaster.c
    ${APP_DIR}/source/I2CSlave.h
    ${APP_DIR}/source/I2CSlave.c
  DESIGN_MODUS
    ${APP_DIR}/COMPONENT_CUSTOM_DESIGN_MODUS/TARGET_${BSP_NAME}/design.modus
)
