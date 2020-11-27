# Download BSP sources from GitHub
psoc4_load_bsp(
  NAME CY8CKIT-041-41XX
  VERSION 1.0.0
)

# Set target MPN
psoc4_set_device(CY8C4146AZI-S433)

# Set target CPU core
psoc4_set_core()

set(BSP_SOURCES
  ${BSP_DIR}/system_cat2.h
  ${BSP_DIR}/system_cat2.c
  ${BSP_DIR}/startup_psoc4100s.c
  ${BSP_DIR}/cybsp.h
  ${BSP_DIR}/cybsp.c
  ${BSP_DIR}/cybsp_doc.h
  ${BSP_DIR}/cybsp_types.h
)
set(BSP_LINK_LIBRARIES
  mtb-pdl-cat2
  mtb-hal-cat2
)

# Include BSP_DIR globally
include_directories(${BSP_DIR})

add_definitions(-DCY_USING_HAL)
psoc4_add_component(BSP_DESIGN_MODUS)
psoc4_add_component(CAT2)
psoc4_add_component(PSOC4HAL)

if(${TOOLCHAIN} STREQUAL GCC)
  set(BSP_LINKER_SCRIPT ${BSP_DIR}/TOOLCHAIN_GCC_ARM/cy8c4xx6.ld)
elseif(${TOOLCHAIN} STREQUAL ARM)
  set(BSP_LINKER_SCRIPT ${BSP_DIR}/TOOLCHAIN_ARM/cy8c4xx6.sct)
elseif(${TOOLCHAIN} STREQUAL IAR)
  set(BSP_LINKER_SCRIPT ${BSP_DIR}/TOOLCHAIN_IAR/cy8c4xx6.icf)
elseif(${TOOLCHAIN} STREQUAL LLVM)
  set(BSP_LINKER_SCRIPT ${BSP_DIR}/TOOLCHAIN_GCC_ARM/cy8c4xx6.ld)
else()
  message(FATAL_ERROR "bsp: TOOLCHAIN ${TOOLCHAIN} is not supported.")
endif()

# Define BSP library
add_library(bsp STATIC EXCLUDE_FROM_ALL ${BSP_SOURCES})
target_link_libraries(bsp PUBLIC ${BSP_LINK_LIBRARIES})

# Load library definitions
include(lib/cmsis.cmake)
include(lib/core-lib.cmake)
include(lib/mtb-pdl-cat2.cmake)

# Include common libraries
include(lib/mtb-hal-cat2.cmake)
include(lib/capsense.cmake)
include(lib/retarget-io.cmake)

# Define custom recipes for BSP generated sources
psoc4_add_bsp_design_modus(${BSP_DIR}/COMPONENT_BSP_DESIGN_MODUS/design.modus)
psoc4_add_bsp_design_capsense(${BSP_DIR}/COMPONENT_BSP_DESIGN_MODUS/design.cycapsense)
