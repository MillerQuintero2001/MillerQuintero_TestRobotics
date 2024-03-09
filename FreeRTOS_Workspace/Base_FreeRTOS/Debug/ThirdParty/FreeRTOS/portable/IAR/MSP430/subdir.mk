################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (10.3-2021.10)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../ThirdParty/FreeRTOS/portable/IAR/MSP430/port.c 

OBJS += \
./ThirdParty/FreeRTOS/portable/IAR/MSP430/port.o 

C_DEPS += \
./ThirdParty/FreeRTOS/portable/IAR/MSP430/port.d 


# Each subdirectory must supply rules for building sources it contributes
ThirdParty/FreeRTOS/portable/IAR/MSP430/%.o ThirdParty/FreeRTOS/portable/IAR/MSP430/%.su: ../ThirdParty/FreeRTOS/portable/IAR/MSP430/%.c ThirdParty/FreeRTOS/portable/IAR/MSP430/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DNUCLEO_F411RE -DSTM32 -DSTM32F4 -DSTM32F411RETx -c -I../Inc -I"/home/miller/Documentos/GitHub/TestRobotics/FreeRTOS_Workspace/Base_FreeRTOS/ThirdParty/FreeRTOS/include" -I"/home/miller/Documentos/GitHub/TestRobotics/FreeRTOS_Workspace/Base_FreeRTOS/ThirdParty/FreeRTOS/portable/GCC/ARM_CM4F" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-IAR-2f-MSP430

clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-IAR-2f-MSP430:
	-$(RM) ./ThirdParty/FreeRTOS/portable/IAR/MSP430/port.d ./ThirdParty/FreeRTOS/portable/IAR/MSP430/port.o ./ThirdParty/FreeRTOS/portable/IAR/MSP430/port.su

.PHONY: clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-IAR-2f-MSP430

