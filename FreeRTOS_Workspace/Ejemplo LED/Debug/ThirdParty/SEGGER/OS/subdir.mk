################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (10.3-2021.10)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../ThirdParty/SEGGER/OS/SEGGER_SYSVIEW_FreeRTOS.c 

OBJS += \
./ThirdParty/SEGGER/OS/SEGGER_SYSVIEW_FreeRTOS.o 

C_DEPS += \
./ThirdParty/SEGGER/OS/SEGGER_SYSVIEW_FreeRTOS.d 


# Each subdirectory must supply rules for building sources it contributes
ThirdParty/SEGGER/OS/%.o ThirdParty/SEGGER/OS/%.su: ../ThirdParty/SEGGER/OS/%.c ThirdParty/SEGGER/OS/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DNUCLEO_F411RE -DSTM32 -DSTM32F4 -DSTM32F411RETx -DSTM32F411xE=1 -c -I../Inc -I"/home/miller/Documentos/GitHub/TestRobotics/FreeRTOS_Workspace/Ejemplo LED/ThirdParty/FreeRTOS/include" -I"/home/miller/Documentos/GitHub/TestRobotics/FreeRTOS_Workspace/Ejemplo LED/ThirdParty/FreeRTOS/portable/GCC/ARM_CM4F" -I"/home/miller/Documentos/GitHub/TestRobotics/FreeRTOS_Workspace/Ejemplo LED/ThirdParty/SEGGER/Config" -I"/home/miller/Documentos/GitHub/TestRobotics/FreeRTOS_Workspace/Ejemplo LED/ThirdParty/SEGGER/OS" -I"/home/miller/Documentos/GitHub/TestRobotics/FreeRTOS_Workspace/Ejemplo LED/ThirdParty/SEGGER/SEGGER" -I"/home/miller/Documentos/GitHub/TestRobotics/FreeRTOS_Workspace/STM32Cube_FW_F4_V1.27.0/Drivers/CMSIS/Core/Include" -I"/home/miller/Documentos/GitHub/TestRobotics/FreeRTOS_Workspace/STM32Cube_FW_F4_V1.27.0/Drivers/CMSIS/Device/ST/STM32F4xx/Include" -I/home/miller/Documentos/GitHub/MillerQuintero_Tareas_Proyectos_Taller_5/PeripheralDrivers/Inc -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-ThirdParty-2f-SEGGER-2f-OS

clean-ThirdParty-2f-SEGGER-2f-OS:
	-$(RM) ./ThirdParty/SEGGER/OS/SEGGER_SYSVIEW_FreeRTOS.d ./ThirdParty/SEGGER/OS/SEGGER_SYSVIEW_FreeRTOS.o ./ThirdParty/SEGGER/OS/SEGGER_SYSVIEW_FreeRTOS.su

.PHONY: clean-ThirdParty-2f-SEGGER-2f-OS

