################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (10.3-2021.10)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../ThirdParty/FreeRTOS/portable/MPLAB/PIC32MEC14xx/port.c 

S_UPPER_SRCS += \
../ThirdParty/FreeRTOS/portable/MPLAB/PIC32MEC14xx/port_asm.S 

OBJS += \
./ThirdParty/FreeRTOS/portable/MPLAB/PIC32MEC14xx/port.o \
./ThirdParty/FreeRTOS/portable/MPLAB/PIC32MEC14xx/port_asm.o 

S_UPPER_DEPS += \
./ThirdParty/FreeRTOS/portable/MPLAB/PIC32MEC14xx/port_asm.d 

C_DEPS += \
./ThirdParty/FreeRTOS/portable/MPLAB/PIC32MEC14xx/port.d 


# Each subdirectory must supply rules for building sources it contributes
ThirdParty/FreeRTOS/portable/MPLAB/PIC32MEC14xx/%.o ThirdParty/FreeRTOS/portable/MPLAB/PIC32MEC14xx/%.su: ../ThirdParty/FreeRTOS/portable/MPLAB/PIC32MEC14xx/%.c ThirdParty/FreeRTOS/portable/MPLAB/PIC32MEC14xx/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DNUCLEO_F411RE -DSTM32 -DSTM32F4 -DSTM32F411RETx -c -I../Inc -I"/home/miller/Documentos/GitHub/TestRobotics/FreeRTOS_Workspace/Base_FreeRTOS/ThirdParty/FreeRTOS/include" -I"/home/miller/Documentos/GitHub/TestRobotics/FreeRTOS_Workspace/Base_FreeRTOS/ThirdParty/FreeRTOS/portable/GCC/ARM_CM4F" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
ThirdParty/FreeRTOS/portable/MPLAB/PIC32MEC14xx/%.o: ../ThirdParty/FreeRTOS/portable/MPLAB/PIC32MEC14xx/%.S ThirdParty/FreeRTOS/portable/MPLAB/PIC32MEC14xx/subdir.mk
	arm-none-eabi-gcc -mcpu=cortex-m4 -g3 -DDEBUG -c -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"

clean: clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-MPLAB-2f-PIC32MEC14xx

clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-MPLAB-2f-PIC32MEC14xx:
	-$(RM) ./ThirdParty/FreeRTOS/portable/MPLAB/PIC32MEC14xx/port.d ./ThirdParty/FreeRTOS/portable/MPLAB/PIC32MEC14xx/port.o ./ThirdParty/FreeRTOS/portable/MPLAB/PIC32MEC14xx/port.su ./ThirdParty/FreeRTOS/portable/MPLAB/PIC32MEC14xx/port_asm.d ./ThirdParty/FreeRTOS/portable/MPLAB/PIC32MEC14xx/port_asm.o

.PHONY: clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-MPLAB-2f-PIC32MEC14xx

