################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (10.3-2021.10)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../ThirdParty/FreeRTOS/portable/IAR/AVR32_UC3/port.c \
../ThirdParty/FreeRTOS/portable/IAR/AVR32_UC3/read.c \
../ThirdParty/FreeRTOS/portable/IAR/AVR32_UC3/write.c 

OBJS += \
./ThirdParty/FreeRTOS/portable/IAR/AVR32_UC3/port.o \
./ThirdParty/FreeRTOS/portable/IAR/AVR32_UC3/read.o \
./ThirdParty/FreeRTOS/portable/IAR/AVR32_UC3/write.o 

C_DEPS += \
./ThirdParty/FreeRTOS/portable/IAR/AVR32_UC3/port.d \
./ThirdParty/FreeRTOS/portable/IAR/AVR32_UC3/read.d \
./ThirdParty/FreeRTOS/portable/IAR/AVR32_UC3/write.d 


# Each subdirectory must supply rules for building sources it contributes
ThirdParty/FreeRTOS/portable/IAR/AVR32_UC3/%.o ThirdParty/FreeRTOS/portable/IAR/AVR32_UC3/%.su: ../ThirdParty/FreeRTOS/portable/IAR/AVR32_UC3/%.c ThirdParty/FreeRTOS/portable/IAR/AVR32_UC3/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DNUCLEO_F411RE -DSTM32 -DSTM32F4 -DSTM32F411RETx -c -I../Inc -I"/home/miller/Documentos/GitHub/TestRobotics/FreeRTOS_Workspace/Base_FreeRTOS/ThirdParty/FreeRTOS/include" -I"/home/miller/Documentos/GitHub/TestRobotics/FreeRTOS_Workspace/Base_FreeRTOS/ThirdParty/FreeRTOS/portable/GCC/ARM_CM4F" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-IAR-2f-AVR32_UC3

clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-IAR-2f-AVR32_UC3:
	-$(RM) ./ThirdParty/FreeRTOS/portable/IAR/AVR32_UC3/port.d ./ThirdParty/FreeRTOS/portable/IAR/AVR32_UC3/port.o ./ThirdParty/FreeRTOS/portable/IAR/AVR32_UC3/port.su ./ThirdParty/FreeRTOS/portable/IAR/AVR32_UC3/read.d ./ThirdParty/FreeRTOS/portable/IAR/AVR32_UC3/read.o ./ThirdParty/FreeRTOS/portable/IAR/AVR32_UC3/read.su ./ThirdParty/FreeRTOS/portable/IAR/AVR32_UC3/write.d ./ThirdParty/FreeRTOS/portable/IAR/AVR32_UC3/write.o ./ThirdParty/FreeRTOS/portable/IAR/AVR32_UC3/write.su

.PHONY: clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-IAR-2f-AVR32_UC3

