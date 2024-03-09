################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (10.3-2021.10)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../ThirdParty/FreeRTOS/portable/ARMv8M/non_secure/portable/IAR/ARM_CM23_NTZ/portasm.s 

OBJS += \
./ThirdParty/FreeRTOS/portable/ARMv8M/non_secure/portable/IAR/ARM_CM23_NTZ/portasm.o 

S_DEPS += \
./ThirdParty/FreeRTOS/portable/ARMv8M/non_secure/portable/IAR/ARM_CM23_NTZ/portasm.d 


# Each subdirectory must supply rules for building sources it contributes
ThirdParty/FreeRTOS/portable/ARMv8M/non_secure/portable/IAR/ARM_CM23_NTZ/%.o: ../ThirdParty/FreeRTOS/portable/ARMv8M/non_secure/portable/IAR/ARM_CM23_NTZ/%.s ThirdParty/FreeRTOS/portable/ARMv8M/non_secure/portable/IAR/ARM_CM23_NTZ/subdir.mk
	arm-none-eabi-gcc -mcpu=cortex-m4 -g3 -DDEBUG -c -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"

clean: clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-ARMv8M-2f-non_secure-2f-portable-2f-IAR-2f-ARM_CM23_NTZ

clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-ARMv8M-2f-non_secure-2f-portable-2f-IAR-2f-ARM_CM23_NTZ:
	-$(RM) ./ThirdParty/FreeRTOS/portable/ARMv8M/non_secure/portable/IAR/ARM_CM23_NTZ/portasm.d ./ThirdParty/FreeRTOS/portable/ARMv8M/non_secure/portable/IAR/ARM_CM23_NTZ/portasm.o

.PHONY: clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-ARMv8M-2f-non_secure-2f-portable-2f-IAR-2f-ARM_CM23_NTZ

