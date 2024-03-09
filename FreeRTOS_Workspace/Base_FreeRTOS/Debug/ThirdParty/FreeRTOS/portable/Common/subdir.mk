################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (10.3-2021.10)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../ThirdParty/FreeRTOS/portable/Common/mpu_wrappers.c 

OBJS += \
./ThirdParty/FreeRTOS/portable/Common/mpu_wrappers.o 

C_DEPS += \
./ThirdParty/FreeRTOS/portable/Common/mpu_wrappers.d 


# Each subdirectory must supply rules for building sources it contributes
ThirdParty/FreeRTOS/portable/Common/%.o ThirdParty/FreeRTOS/portable/Common/%.su: ../ThirdParty/FreeRTOS/portable/Common/%.c ThirdParty/FreeRTOS/portable/Common/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DNUCLEO_F411RE -DSTM32 -DSTM32F4 -DSTM32F411RETx -c -I../Inc -I"/home/miller/Documentos/GitHub/TestRobotics/FreeRTOS_Workspace/Base_FreeRTOS/ThirdParty/FreeRTOS/include" -I"/home/miller/Documentos/GitHub/TestRobotics/FreeRTOS_Workspace/Base_FreeRTOS/ThirdParty/FreeRTOS/portable/GCC/ARM_CM4F" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-Common

clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-Common:
	-$(RM) ./ThirdParty/FreeRTOS/portable/Common/mpu_wrappers.d ./ThirdParty/FreeRTOS/portable/Common/mpu_wrappers.o ./ThirdParty/FreeRTOS/portable/Common/mpu_wrappers.su

.PHONY: clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-Common

