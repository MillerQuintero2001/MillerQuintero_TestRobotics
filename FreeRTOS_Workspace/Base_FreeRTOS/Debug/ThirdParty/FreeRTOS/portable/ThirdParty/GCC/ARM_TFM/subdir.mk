################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (10.3-2021.10)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARM_TFM/os_wrapper_freertos.c 

OBJS += \
./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARM_TFM/os_wrapper_freertos.o 

C_DEPS += \
./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARM_TFM/os_wrapper_freertos.d 


# Each subdirectory must supply rules for building sources it contributes
ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARM_TFM/%.o ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARM_TFM/%.su: ../ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARM_TFM/%.c ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARM_TFM/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DNUCLEO_F411RE -DSTM32 -DSTM32F4 -DSTM32F411RETx -c -I../Inc -I"/home/miller/Documentos/GitHub/TestRobotics/FreeRTOS_Workspace/Base_FreeRTOS/ThirdParty/FreeRTOS/include" -I"/home/miller/Documentos/GitHub/TestRobotics/FreeRTOS_Workspace/Base_FreeRTOS/ThirdParty/FreeRTOS/portable/GCC/ARM_CM4F" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-ThirdParty-2f-GCC-2f-ARM_TFM

clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-ThirdParty-2f-GCC-2f-ARM_TFM:
	-$(RM) ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARM_TFM/os_wrapper_freertos.d ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARM_TFM/os_wrapper_freertos.o ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/ARM_TFM/os_wrapper_freertos.su

.PHONY: clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-ThirdParty-2f-GCC-2f-ARM_TFM

