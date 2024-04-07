################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (10.3-2021.10)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/FreeRTOS-openocd.c \
../ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/port.c \
../ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/port_common.c \
../ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/port_systick.c \
../ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_init.c \
../ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_overlay_os_hook.c 

S_UPPER_SRCS += \
../ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/portasm.S \
../ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_context.S \
../ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_loadstore_handler.S \
../ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_vector_defaults.S \
../ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_vectors.S 

OBJS += \
./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/FreeRTOS-openocd.o \
./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/port.o \
./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/port_common.o \
./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/port_systick.o \
./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/portasm.o \
./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_context.o \
./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_init.o \
./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_loadstore_handler.o \
./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_overlay_os_hook.o \
./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_vector_defaults.o \
./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_vectors.o 

S_UPPER_DEPS += \
./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/portasm.d \
./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_context.d \
./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_loadstore_handler.d \
./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_vector_defaults.d \
./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_vectors.d 

C_DEPS += \
./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/FreeRTOS-openocd.d \
./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/port.d \
./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/port_common.d \
./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/port_systick.d \
./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_init.d \
./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_overlay_os_hook.d 


# Each subdirectory must supply rules for building sources it contributes
ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/%.o ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/%.su: ../ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/%.c ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DNUCLEO_F411RE -DSTM32 -DSTM32F4 -DSTM32F411RETx -c -I../Inc -I"/home/miller/Documentos/GitHub/TestRobotics/FreeRTOS_Workspace/Base_FreeRTOS/ThirdParty/FreeRTOS/include" -I"/home/miller/Documentos/GitHub/TestRobotics/FreeRTOS_Workspace/Base_FreeRTOS/ThirdParty/FreeRTOS/portable/GCC/ARM_CM4F" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/%.o: ../ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/%.S ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/subdir.mk
	arm-none-eabi-gcc -mcpu=cortex-m4 -g3 -DDEBUG -c -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"

clean: clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-ThirdParty-2f-GCC-2f-Xtensa_ESP32

clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-ThirdParty-2f-GCC-2f-Xtensa_ESP32:
	-$(RM) ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/FreeRTOS-openocd.d ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/FreeRTOS-openocd.o ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/FreeRTOS-openocd.su ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/port.d ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/port.o ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/port.su ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/port_common.d ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/port_common.o ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/port_common.su ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/port_systick.d ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/port_systick.o ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/port_systick.su ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/portasm.d ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/portasm.o ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_context.d ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_context.o ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_init.d ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_init.o ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_init.su ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_loadstore_handler.d ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_loadstore_handler.o ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_overlay_os_hook.d ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_overlay_os_hook.o ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_overlay_os_hook.su ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_vector_defaults.d ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_vector_defaults.o ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_vectors.d ./ThirdParty/FreeRTOS/portable/ThirdParty/GCC/Xtensa_ESP32/xtensa_vectors.o

.PHONY: clean-ThirdParty-2f-FreeRTOS-2f-portable-2f-ThirdParty-2f-GCC-2f-Xtensa_ESP32

