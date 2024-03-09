################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (10.3-2021.10)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARC_v1/arc_support.s 

C_SRCS += \
../ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARC_v1/arc_freertos_exceptions.c \
../ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARC_v1/port.c 

OBJS += \
./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARC_v1/arc_freertos_exceptions.o \
./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARC_v1/arc_support.o \
./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARC_v1/port.o 

S_DEPS += \
./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARC_v1/arc_support.d 

C_DEPS += \
./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARC_v1/arc_freertos_exceptions.d \
./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARC_v1/port.d 


# Each subdirectory must supply rules for building sources it contributes
ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARC_v1/%.o ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARC_v1/%.su: ../ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARC_v1/%.c ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARC_v1/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DNUCLEO_F411RE -DSTM32 -DSTM32F4 -DSTM32F411RETx -c -I../Inc -I"/home/miller/Documentos/GitHub/TestRobotics/FreeRTOS_Workspace/Base_FreeRTOS/ThirdParty/FreeRTOS/include" -I"/home/miller/Documentos/GitHub/TestRobotics/FreeRTOS_Workspace/Base_FreeRTOS/ThirdParty/FreeRTOS/portable/GCC/ARM_CM4F" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARC_v1/%.o: ../ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARC_v1/%.s ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARC_v1/subdir.mk
	arm-none-eabi-gcc -mcpu=cortex-m4 -g3 -DDEBUG -c -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"

clean: clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-ThirdParty-2f-GCC-2f-ARC_v1

clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-ThirdParty-2f-GCC-2f-ARC_v1:
	-$(RM) ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARC_v1/arc_freertos_exceptions.d ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARC_v1/arc_freertos_exceptions.o ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARC_v1/arc_freertos_exceptions.su ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARC_v1/arc_support.d ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARC_v1/arc_support.o ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARC_v1/port.d ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARC_v1/port.o ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARC_v1/port.su

.PHONY: clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-ThirdParty-2f-GCC-2f-ARC_v1

