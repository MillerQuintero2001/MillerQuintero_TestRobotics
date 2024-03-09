################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (10.3-2021.10)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../ThirdParty/FreeRTOS/portable/ThirdParty/Community-Supported-Ports/GCC/TriCore_38xa/port.c \
../ThirdParty/FreeRTOS/portable/ThirdParty/Community-Supported-Ports/GCC/TriCore_38xa/porttrap.c 

OBJS += \
./ThirdParty/FreeRTOS/portable/ThirdParty/Community-Supported-Ports/GCC/TriCore_38xa/port.o \
./ThirdParty/FreeRTOS/portable/ThirdParty/Community-Supported-Ports/GCC/TriCore_38xa/porttrap.o 

C_DEPS += \
./ThirdParty/FreeRTOS/portable/ThirdParty/Community-Supported-Ports/GCC/TriCore_38xa/port.d \
./ThirdParty/FreeRTOS/portable/ThirdParty/Community-Supported-Ports/GCC/TriCore_38xa/porttrap.d 


# Each subdirectory must supply rules for building sources it contributes
ThirdParty/FreeRTOS/portable/ThirdParty/Community-Supported-Ports/GCC/TriCore_38xa/%.o ThirdParty/FreeRTOS/portable/ThirdParty/Community-Supported-Ports/GCC/TriCore_38xa/%.su: ../ThirdParty/FreeRTOS/portable/ThirdParty/Community-Supported-Ports/GCC/TriCore_38xa/%.c ThirdParty/FreeRTOS/portable/ThirdParty/Community-Supported-Ports/GCC/TriCore_38xa/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DNUCLEO_F411RE -DSTM32 -DSTM32F4 -DSTM32F411RETx -c -I../Inc -I"/home/miller/Documentos/GitHub/TestRobotics/FreeRTOS_Workspace/Base_FreeRTOS/ThirdParty/FreeRTOS/include" -I"/home/miller/Documentos/GitHub/TestRobotics/FreeRTOS_Workspace/Base_FreeRTOS/ThirdParty/FreeRTOS/portable/GCC/ARM_CM4F" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-ThirdParty-2f-Community-2d-Supported-2d-Ports-2f-GCC-2f-TriCore_38xa

clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-ThirdParty-2f-Community-2d-Supported-2d-Ports-2f-GCC-2f-TriCore_38xa:
	-$(RM) ./ThirdParty/FreeRTOS/portable/ThirdParty/Community-Supported-Ports/GCC/TriCore_38xa/port.d ./ThirdParty/FreeRTOS/portable/ThirdParty/Community-Supported-Ports/GCC/TriCore_38xa/port.o ./ThirdParty/FreeRTOS/portable/ThirdParty/Community-Supported-Ports/GCC/TriCore_38xa/port.su ./ThirdParty/FreeRTOS/portable/ThirdParty/Community-Supported-Ports/GCC/TriCore_38xa/porttrap.d ./ThirdParty/FreeRTOS/portable/ThirdParty/Community-Supported-Ports/GCC/TriCore_38xa/porttrap.o ./ThirdParty/FreeRTOS/portable/ThirdParty/Community-Supported-Ports/GCC/TriCore_38xa/porttrap.su

.PHONY: clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-ThirdParty-2f-Community-2d-Supported-2d-Ports-2f-GCC-2f-TriCore_38xa

