# Load application definitions
include(app/capsense-csd-slider-tuning.cmake)
include(app/capsense-csx-button-tuning.cmake)
include(app/empty-app.cmake)
include(app/gpio-interrupt.cmake)
include(app/hello-world.cmake)
include(app/i2c-master-slave.cmake)
include(app/i2c-slave-callback.cmake)
include(app/pwm-trigger-dma.cmake)
include(app/spi-master.cmake)
include(app/spi-slave.cmake)
include(app/tcpwm-interrupt.cmake)
include(app/uart-transmit-receive.cmake)
include(app/uart-transmit-receive-dma.cmake)
include(app/wdc.cmake)
include(app/wdt.cmake)

# Load CMSIS tests
#include(test/cmsis/CoreValidation.cmake)
