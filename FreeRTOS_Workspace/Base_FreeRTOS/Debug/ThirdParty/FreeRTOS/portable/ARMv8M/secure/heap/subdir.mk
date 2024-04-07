################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (10.3-2021.10)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../ThirdParty/FreeRTOS/portable/ARMv8M/secure/heap/secure_heap.c 

OBJS += \
./ThirdParty/FreeRTOS/portable/ARMv8M/secure/heap/secure_heap.o 

C_DEPS += \
./ThirdParty/FreeRTOS/portable/ARMv8M/secure/heap/secure_heap.d 


# Each subdirectory must supply rules for building sources it contributes
ThirdParty/FreeRTOS/portable/ARMv8M/secure/heap/%.o ThirdParty/FreeRTOS/portable/ARMv8M/secure/heap/%.su: ../ThirdParty/FreeRTOS/portable/ARMv8M/secure/heap/%.c ThirdParty/FreeRTOS/portable/ARMv8M/secure/heap/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DNUCLEO_F411RE -DSTM32 -DSTM32F4 -DSTM32F411RETx -c -I../Inc -I"/home/miller/Documentos/GitHub/TestRobotics/FreeRTOS_Workspace/Base_FreeRTOS/ThirdParty/FreeRTOS/include" -I"/home/miller/Documentos/GitHub/TestRobotics/FreeRTOS_Workspace/Base_FreeRTOS/ThirdParty/FreeRTOS/portable/GCC/ARM_CM4F" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-ARMv8M-2f-secure-2f-heap

clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-ARMv8M-2f-secure-2f-heap:
	-$(RM) ./ThirdParty/FreeRTOS/portable/ARMv8M/secure/heap/secure_heap.d ./ThirdParty/FreeRTOS/portable/ARMv8M/secure/heap/secure_heap.o ./ThirdParty/FreeRTOS/portable/ARMv8M/secure/heap/secure_heap.su

.PHONY: clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-ARMv8M-2f-secure-2f-heap

