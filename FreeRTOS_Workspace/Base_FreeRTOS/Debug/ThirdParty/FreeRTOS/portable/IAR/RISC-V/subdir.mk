################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (10.3-2021.10)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../ThirdParty/FreeRTOS/portable/IAR/RISC-V/portASM.s 

C_SRCS += \
../ThirdParty/FreeRTOS/portable/IAR/RISC-V/port.c 

OBJS += \
./ThirdParty/FreeRTOS/portable/IAR/RISC-V/port.o \
./ThirdParty/FreeRTOS/portable/IAR/RISC-V/portASM.o 

S_DEPS += \
./ThirdParty/FreeRTOS/portable/IAR/RISC-V/portASM.d 

C_DEPS += \
./ThirdParty/FreeRTOS/portable/IAR/RISC-V/port.d 


# Each subdirectory must supply rules for building sources it contributes
ThirdParty/FreeRTOS/portable/IAR/RISC-V/%.o ThirdParty/FreeRTOS/portable/IAR/RISC-V/%.su: ../ThirdParty/FreeRTOS/portable/IAR/RISC-V/%.c ThirdParty/FreeRTOS/portable/IAR/RISC-V/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DNUCLEO_F411RE -DSTM32 -DSTM32F4 -DSTM32F411RETx -c -I../Inc -I"/home/miller/Documentos/GitHub/TestRobotics/FreeRTOS_Workspace/Base_FreeRTOS/ThirdParty/FreeRTOS/include" -I"/home/miller/Documentos/GitHub/TestRobotics/FreeRTOS_Workspace/Base_FreeRTOS/ThirdParty/FreeRTOS/portable/GCC/ARM_CM4F" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
ThirdParty/FreeRTOS/portable/IAR/RISC-V/%.o: ../ThirdParty/FreeRTOS/portable/IAR/RISC-V/%.s ThirdParty/FreeRTOS/portable/IAR/RISC-V/subdir.mk
	arm-none-eabi-gcc -mcpu=cortex-m4 -g3 -DDEBUG -c -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"

clean: clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-IAR-2f-RISC-2d-V

clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-IAR-2f-RISC-2d-V:
	-$(RM) ./ThirdParty/FreeRTOS/portable/IAR/RISC-V/port.d ./ThirdParty/FreeRTOS/portable/IAR/RISC-V/port.o ./ThirdParty/FreeRTOS/portable/IAR/RISC-V/port.su ./ThirdParty/FreeRTOS/portable/IAR/RISC-V/portASM.d ./ThirdParty/FreeRTOS/portable/IAR/RISC-V/portASM.o

.PHONY: clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-IAR-2f-RISC-2d-V

