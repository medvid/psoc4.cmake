source [find interface/kitprog3.cfg]
source [find target/psoc4.cfg]
${_TARGETNAME} configure -rtos auto -rtos-wipe-on-reset-halt 1
