# Load application definitions
include(app/capsense-csx-button-tuning.cmake)
include(app/empty-app.cmake)
include(app/gpio-interrupt.cmake)
include(app/i2c-master-slave.cmake)
include(app/i2c-slave-callback.cmake)
include(app/tcpwm-interrupt.cmake)

# Load CMSIS tests
include(test/cmsis/CoreValidation.cmake)
