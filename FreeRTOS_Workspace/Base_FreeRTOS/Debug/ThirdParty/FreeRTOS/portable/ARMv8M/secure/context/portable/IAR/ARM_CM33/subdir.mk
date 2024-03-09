################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (10.3-2021.10)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../ThirdParty/FreeRTOS/portable/ARMv8M/secure/context/portable/IAR/ARM_CM33/secure_context_port_asm.s 

OBJS += \
./ThirdParty/FreeRTOS/portable/ARMv8M/secure/context/portable/IAR/ARM_CM33/secure_context_port_asm.o 

S_DEPS += \
./ThirdParty/FreeRTOS/portable/ARMv8M/secure/context/portable/IAR/ARM_CM33/secure_context_port_asm.d 


# Each subdirectory must supply rules for building sources it contributes
ThirdParty/FreeRTOS/portable/ARMv8M/secure/context/portable/IAR/ARM_CM33/%.o: ../ThirdParty/FreeRTOS/portable/ARMv8M/secure/context/portable/IAR/ARM_CM33/%.s ThirdParty/FreeRTOS/portable/ARMv8M/secure/context/portable/IAR/ARM_CM33/subdir.mk
	arm-none-eabi-gcc -mcpu=cortex-m4 -g3 -DDEBUG -c -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"

clean: clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-ARMv8M-2f-secure-2f-context-2f-portable-2f-IAR-2f-ARM_CM33

clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-ARMv8M-2f-secure-2f-context-2f-portable-2f-IAR-2f-ARM_CM33:
	-$(RM) ./ThirdParty/FreeRTOS/portable/ARMv8M/secure/context/portable/IAR/ARM_CM33/secure_context_port_asm.d ./ThirdParty/FreeRTOS/portable/ARMv8M/secure/context/portable/IAR/ARM_CM33/secure_context_port_asm.o

.PHONY: clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-ARMv8M-2f-secure-2f-context-2f-portable-2f-IAR-2f-ARM_CM33

