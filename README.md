# CMake based build system for PSoC 4 designs

[![Build Status](https://dev.azure.com/vmedvid/psoc4.cmake/_apis/build/status/medvid.psoc4.cmake?branchName=master)](https://dev.azure.com/vmedvid/psoc4.cmake/_build/latest?definitionId=4&branchName=master)

## Prerequisites

* ModusToolbox 2.2
* CMake >= 3.16
* Ninja build system

### Install prerequisites - Windows

1. Download and install ModusToolbox 2.2:

    [https://www.cypress.com/ModusToolboxForWindows][ModusToolboxForWindows]

2. Download and install the latest Git for Windows:

    https://gitforwindows.org/

3. Download and install the latest CMake win64-x64 Installer:

    https://cmake.org/download/

4. Download Ninja executable, add to user PATH:

    https://github.com/ninja-build/ninja/releases

    CLI example: to install Ninja 1.10.0 to %LOCALAPPDATA%\Programs\Ninja, execute the below commands in Git Bash terminal:

        curl -fsSL https://github.com/ninja-build/ninja/releases/download/v1.10.0/ninja-win.zip -o $TMPDIR/ninja-win.zip
        mkdir -p $LOCALAPPDATA/Programs/Ninja
        unzip $TMPDIR/ninja-win.zip -d $LOCALAPPDATA/Programs/Ninja

    Then add %LOCALAPPDATA%\Programs\Ninja to user PATH in Windows advanced system settings.

5. _(Optional)_ Download and install the latest GNU Arm Embedded toolchain:

    https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads

    Installation path assumed in this guide:

        C:/Program Files (x86)/GNU Arm Embedded Toolchain/10 2020-q4-major

6. _(Optional)_ Download and install Arm Compiler 6:

    https://developer.arm.com/tools-and-software/embedded/arm-compiler/downloads/version-6

    Example installation path:

        C:/Program Files/ARMCompiler6.13

    Arm Compiler 6 is also bundled with Keil uVision 5 IDE:

    https://www.keil.com/arm/

    Installation path assumed in this document:

        C:/Keil_v5/ARM/ARMCLANG

    Note: valid license is required to use the Arm Compiler.

7. _(Optional)_ Download and install IAR Embedded Workbench for ARM:

    https://www.iar.com/iar-embedded-workbench/#!?architecture=Arm

    Installation path assumed in this document:

        C:\Program Files (x86)\IAR Systems\Embedded Workbench 8.4

    Note: valid license is required to use the IAR Compiler.

### Install prerequisites - macOS

1. Download and install ModusToolbox 2.2:

    [https://www.cypress.com/ModusToolboxForMac][ModusToolboxForMac]

2. Install Xcode - this provides git client

3. Download and install Homebrew Package Manager:

    https://brew.sh

4. Install CMake and Ninja using Homebrew:

    brew install cmake ninja

5. _(Optional)_ Download and install the latest GNU Arm Embedded toolchain:

    https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads

    Installation path assumed in this guide:

        /Applications/ARM

### Install prerequisites - Linux

1. Download and install ModusToolbox 2.2:

    [https://www.cypress.com/ModusToolboxForLinux][ModusToolboxForLinux]

2. Download and install Git, CMake>=3.16 and Ninja using the system package manager.

    Example for Ubuntu 20.04:

        sudo apt install git cmake ninja-build

    Note: Ubuntu 18.04 provides an old version CMake, not compatible with CMake recipes in this repo.
    To download latest CMake package, follow the instructions at https://apt.kitware.com.

3. _(Optional)_ Download and install the latest GNU Arm Embedded toolchain:

    https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads

    Installation path assumed in this guide:

        /opt/gcc-arm-none-eabi-10-2020-q4-major

    CLI installation example:

        curl -fsSL https://developer.arm.com/-/media/Files/downloads/gnu-rm/10-2020q4/gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2 -o /tmp/gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2
        sudo tar -C /opt -xjf /tmp/gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2

## Quick Start Guide - CLI

1. Open interactive terminal, for example Git Bash on Windows.

2. Check the prerequisite tools were properly installed and added to PATH:

        cmake --version
        ninja --version

3. Clone this repo:

        git clone https://github.com/medvid/psoc4.cmake
        cd psoc4.cmake

4. Generate Ninja build rules using CMake. Example that generates build recipes for bare-metal applications targeting CY8CKIT-149 board and GCC toolchain:

        cmake -G Ninja -S . -B build/CY8CKIT-149/NOOS/GCC/Debug \
            -DTARGET=CY8CKIT-149 -DOS=NOOS -DTOOLCHAIN=GCC \
            -DCMAKE_BUILD_TYPE=Debug

5. Build all applications enabled for the selected TARGET and OS combination:

        cmake --build build/CY8CKIT-149/NOOS/GCC/Debug

6. Connect CY8CKIT-149 to the host. If needed, update the KitProg firmware using fw-loader:

    https://github.com/cypresssemiconductorco/Firmware-loader

    Make sure the kit is in CMSIS-DAP mode.

7. Program hello-world application to the PSoC 4 MCU:

        cmake --build build/CY8CKIT-149/NOOS/GCC/Debug --target hello-world_PROGRAM

8. Check the application behaves in accorandce with [app/hello-world/README.md][hello-world]

## Usage - Visual Studio Code

1. Install Visual Studio Code:

    https://aka.ms/vscode

2. Start Visual Studio Code. Select File -> Open Folder... -> browse to psoc4.cmake directory (on macOS, use File -> Open menu).

3. Install the required extensions:

    * [ms-vscode.cpptools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)
    * [ms-vscode.cmake-tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools)
    * [marus25.cortex-debug](https://marketplace.visualstudio.com/items?itemName=marus25.cortex-debug)

4. Copy .vscode/settings-template-$os.json as .vscode/settings.json, adjust paths as necessary.

    * Example of Windows-specific tweaks to settings.json:

        ```json
        {
            "modustoolbox.toolsPath": "${env:HOME}/ModusToolbox/tools_2.2",
            "cortex-debug.openocdPath": "${config:modustoolbox.toolsPath}/openocd/bin/openocd",
            "cortex-debug.armToolchainPath": "${config:modustoolbox.toolsPath}/gcc/bin",
            "cmake.configureSettings": {
                "CY_TOOLS_PATHS": "${env:HOME}/ModusToolbox/tools_2.2",
                "GCC_TOOLCHAIN_PATH": "C:/Program Files (x86)/GNU Arm Embedded Toolchain/10 2020-q4-major",
                "ARM_TOOLCHAIN_PATH": "C:/Keil_v5/ARM/ARMCLANG",
                "IAR_TOOLCHAIN_PATH": "C:/Program Files (x86)/IAR Systems/Embedded Workbench 8.4/arm"
            }
        }
        ```

    * Example of macOS-specific tweaks to settings.json:

        ```json
        {
            "modustoolbox.toolsPath": "/Applications/ModusToolbox/tools_2.2",
            "cortex-debug.openocdPath": "${config:modustoolbox.toolsPath}/openocd/bin/openocd",
            "cortex-debug.armToolchainPath": "${config:modustoolbox.toolsPath}/gcc/bin",
            "cmake.configureSettings": {
                "CY_TOOLS_PATHS": "/Applications/ModusToolbox/tools_2.2",
                "GCC_TOOLCHAIN_PATH": "/Applications/ARM"
            }
        }
        ```

    * Example of Linux-specific tweaks to settings.json:

        ```json
        {
            "modustoolbox.toolsPath": "${env:HOME}/ModusToolbox/tools_2.2",
            "cortex-debug.openocdPath": "${config:modustoolbox.toolsPath}/openocd/bin/openocd",
            "cortex-debug.armToolchainPath": "${config:modustoolbox.toolsPath}/gcc/bin",
            "cmake.configureSettings": {
                "CY_TOOLS_PATHS": "${env:HOME}/tools_2.2",
                "GCC_TOOLCHAIN_PATH": "/opt/gcc-arm-none-eabi-10-2020-q4-major"
            }
        }
        ```

5. In VSCode menu, select View -> Command Palette -> type: "CMake: Select a Kit" -> select one of the custom kits defined in .vscode/cmake-kits.json, for example: CY8CKIT-149/NOOS/GCC. Never select standard kits scanned from the host OS.

6. In the Command Palette, type: "CMake: Configure", wait while the CMake project is configured.

7. Type "CMake: Build Target", and select the build target, for example: hello-world_PROGRAM. Wait while the hello-world application is built and programmed.

8. Switch to the Debug tab on the left Panel, select the debug configuration Launch (KitProg3).

9. Select the target ELF file, that corresponds to the CMake selected build target. For example, select "hello-world.elf" in case the current CMake target is "hello-world_PROGRAM".

10. The Cortex-Debug extension should start the debugging session using OpenOCD and KitProg3 CMSIS-DAP built-in debugger.

## Continuous integration

Script `ci/build-all.sh` simplifies the automated build/compile testing of this solution. By default, it builds all supported applications for all BSPs, OSes, toolchains and build configurations.

Arguments:

* -b/--bsp - Select target BSP (CY8CKIT-149/CY8CKIT-145-40XX/...)
* -o/--os - Select target OS (NOOS/FREERTOS/RTX)
* -t/--toolchain - Select toolchain (GCC/ARM/IAR/LLVM)
* -c/--config - Select CMake build configuration (Debug/Release)

Each argument can be supplied multiple times.

### Examples

Build everything:

    ./ci/build-all.sh

Build everything using IAR and ARM toolchains:

    ./ci/build-all.sh -t IAR -t ARM

Build all CY8CKIT-149 and CY8CKIT-145-40XX BSP compatible applications in Debug mode:

    ./ci/build-all.sh -b CY8CKIT-149 -b CY8CKIT-145-40XX -c Debug

Build all FreeRTOS enabled applications in Release mode:

    ./ci/build-all.sh -o FREERTOS -c Release

#### Azure Pipelines

Azure Pipeline is executed for each commit in master and each GitHub Pull Request:

https://dev.azure.com/vmedvid/psoc4.cmake/_build?definitionId=4&_a=summary

The pipeline builds all applications with GCC 10.2.1 toolchain on [vmmedvid/psoc6.cmake](https://hub.docker.com/r/vmmedvid/psoc6.cmake) Docker image.
The docker image is built on top of unofficial ModusToolbox Docker image: [vmmedvid/modustoolbox](https://hub.docker.com/r/vmmedvid/modustoolbox).

## Additional tips

* It is possible to call the Ninja program directly, for example:

        ninja -C build/CY8CKIT-149/NOOS/GCC/Debug hello-world_PROGRAM

    Often it is useful to call the ninja with additional arguments.
    For example, the below command enables verbosity and disables parallel compilation:

        cd build/CY8CKIT-149/NOOS/GCC/Debug
        ninja -v -j1

* When switching between toolchain versions (cmake -DGCC_TOOLCHAIN_PATH), the old toolchain version
  is sometimes cached in the CMake build directory. The most reliable way to address this is to delete
  the build directory before switching the toolchain version:

        rm -rf build/CY8CKIT-149/NOOS/GCC/Debug
        cmake -G Ninja -S . -B build/CY8CKIT-149/NOOS/GCC/Debug \
            -DTARGET=CY8CKIT-149 -DOS=NOOS -DTOOLCHAIN=GCC \
            -DGCC_TOOLCHAIN_PATH="C:/Program Files (x86)/GNU Arm Embedded Toolchain/10 2020-q4-major" \
            -DCMAKE_BUILD_TYPE=Debug

[ModusToolboxForWindows]: http://dlm.cypress.com.edgesuite.net/akdlm/downloadmanager/software/ModusToolbox/ModusToolbox_2.2/ModusToolbox_2.2.0.2801-windows-install.exe
[ModusToolboxForMac]: http://dlm.cypress.com.edgesuite.net/akdlm/downloadmanager/software/ModusToolbox/ModusToolbox_2.2/ModusToolbox_2.2.0.2801-macos-install.pkg
[ModusToolboxForLinux]: http://dlm.cypress.com.edgesuite.net/akdlm/downloadmanager/software/ModusToolbox/ModusToolbox_2.2/ModusToolbox_2.2.0.2801-linux-install.tar.gz
[hello-world]: https://github.com/cypresssemiconductorco/mtb-example-psoc4-hello-world/blob/master/README.md#operation
