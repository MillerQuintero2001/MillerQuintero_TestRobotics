################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (10.3-2021.10)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/port.c \
../ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/portclib.c \
../ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_init.c \
../ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_intr.c \
../ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_overlay_os_hook.c 

S_UPPER_SRCS += \
../ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/portasm.S \
../ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_context.S \
../ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_intr_asm.S \
../ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_vectors.S 

OBJS += \
./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/port.o \
./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/portasm.o \
./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/portclib.o \
./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_context.o \
./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_init.o \
./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_intr.o \
./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_intr_asm.o \
./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_overlay_os_hook.o \
./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_vectors.o 

S_UPPER_DEPS += \
./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/portasm.d \
./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_context.d \
./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_intr_asm.d \
./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_vectors.d 

C_DEPS += \
./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/port.d \
./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/portclib.d \
./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_init.d \
./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_intr.d \
./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_overlay_os_hook.d 


# Each subdirectory must supply rules for building sources it contributes
ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/%.o ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/%.su: ../ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/%.c ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DNUCLEO_F411RE -DSTM32 -DSTM32F4 -DSTM32F411RETx -c -I../Inc -I"/home/miller/Documentos/GitHub/TestRobotics/FreeRTOS_Workspace/Base_FreeRTOS/ThirdParty/FreeRTOS/include" -I"/home/miller/Documentos/GitHub/TestRobotics/FreeRTOS_Workspace/Base_FreeRTOS/ThirdParty/FreeRTOS/portable/GCC/ARM_CM4F" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/%.o: ../ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/%.S ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/subdir.mk
	arm-none-eabi-gcc -mcpu=cortex-m4 -g3 -DDEBUG -c -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"

clean: clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-ThirdParty-2f-XCC-2f-Xtensa

clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-ThirdParty-2f-XCC-2f-Xtensa:
	-$(RM) ./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/port.d ./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/port.o ./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/port.su ./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/portasm.d ./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/portasm.o ./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/portclib.d ./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/portclib.o ./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/portclib.su ./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_context.d ./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_context.o ./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_init.d ./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_init.o ./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_init.su ./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_intr.d ./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_intr.o ./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_intr.su ./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_intr_asm.d ./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_intr_asm.o ./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_overlay_os_hook.d ./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_overlay_os_hook.o ./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_overlay_os_hook.su ./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_vectors.d ./ThirdParty/FreeRTOS/portable/ThirdParty/XCC/Xtensa/xtensa_vectors.o

.PHONY: clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-ThirdParty-2f-XCC-2f-Xtensa

