################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (10.3-2021.10)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Src/AdcDriver.c \
../Src/BasicTimer.c \
../Src/ExtiDriver.c \
../Src/FontsSSD1306.c \
../Src/GPIOxDriver.c \
../Src/I2CDriver.c \
../Src/LcdDriver.c \
../Src/MPE280Driver.c \
../Src/PLLDriver.c \
../Src/PwmDriver.c \
../Src/RGBCxDriver.c \
../Src/RtcDriver.c \
../Src/SSD1306.c \
../Src/SpiDriver.c \
../Src/SysTickDriver.c \
../Src/USARTxDriver.c 

OBJS += \
./Src/AdcDriver.o \
./Src/BasicTimer.o \
./Src/ExtiDriver.o \
./Src/FontsSSD1306.o \
./Src/GPIOxDriver.o \
./Src/I2CDriver.o \
./Src/LcdDriver.o \
./Src/MPE280Driver.o \
./Src/PLLDriver.o \
./Src/PwmDriver.o \
./Src/RGBCxDriver.o \
./Src/RtcDriver.o \
./Src/SSD1306.o \
./Src/SpiDriver.o \
./Src/SysTickDriver.o \
./Src/USARTxDriver.o 

C_DEPS += \
./Src/AdcDriver.d \
./Src/BasicTimer.d \
./Src/ExtiDriver.d \
./Src/FontsSSD1306.d \
./Src/GPIOxDriver.d \
./Src/I2CDriver.d \
./Src/LcdDriver.d \
./Src/MPE280Driver.d \
./Src/PLLDriver.d \
./Src/PwmDriver.d \
./Src/RGBCxDriver.d \
./Src/RtcDriver.d \
./Src/SSD1306.d \
./Src/SpiDriver.d \
./Src/SysTickDriver.d \
./Src/USARTxDriver.d 


# Each subdirectory must supply rules for building sources it contributes
Src/%.o Src/%.su: ../Src/%.c Src/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -DNUCLEO_F411RE -DSTM32 -DSTM32F4 -DSTM32F411RETx -c -I../Inc -Os -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Src

clean-Src:
	-$(RM) ./Src/AdcDriver.d ./Src/AdcDriver.o ./Src/AdcDriver.su ./Src/BasicTimer.d ./Src/BasicTimer.o ./Src/BasicTimer.su ./Src/ExtiDriver.d ./Src/ExtiDriver.o ./Src/ExtiDriver.su ./Src/FontsSSD1306.d ./Src/FontsSSD1306.o ./Src/FontsSSD1306.su ./Src/GPIOxDriver.d ./Src/GPIOxDriver.o ./Src/GPIOxDriver.su ./Src/I2CDriver.d ./Src/I2CDriver.o ./Src/I2CDriver.su ./Src/LcdDriver.d ./Src/LcdDriver.o ./Src/LcdDriver.su ./Src/MPE280Driver.d ./Src/MPE280Driver.o ./Src/MPE280Driver.su ./Src/PLLDriver.d ./Src/PLLDriver.o ./Src/PLLDriver.su ./Src/PwmDriver.d ./Src/PwmDriver.o ./Src/PwmDriver.su ./Src/RGBCxDriver.d ./Src/RGBCxDriver.o ./Src/RGBCxDriver.su ./Src/RtcDriver.d ./Src/RtcDriver.o ./Src/RtcDriver.su ./Src/SSD1306.d ./Src/SSD1306.o ./Src/SSD1306.su ./Src/SpiDriver.d ./Src/SpiDriver.o ./Src/SpiDriver.su ./Src/SysTickDriver.d ./Src/SysTickDriver.o ./Src/SysTickDriver.su ./Src/USARTxDriver.d ./Src/USARTxDriver.o ./Src/USARTxDriver.su

.PHONY: clean-Src

