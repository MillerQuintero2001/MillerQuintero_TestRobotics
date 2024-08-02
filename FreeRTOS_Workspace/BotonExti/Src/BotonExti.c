/**
 ******************************************************************************
 * @file           : BotonExti.c
 * @author         : MillerQuintero2001
 * @brief          : Main program body
 ******************************************************************************
 * @attention
 *
 * Copyright (c) 2024 STMicroelectronics.
 * All rights reserved.
 *
 * This software is licensed under terms that can be found in the LICENSE file
 * in the root directory of this software component.
 * If no LICENSE file comes with this software, it is provided AS-IS.
 *
 ******************************************************************************
 */

#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include <stm32f4xx.h>

#include <stdint.h>
#include <stdio.h>

#include "GPIOxDriver.h"
#include "PLLDriver.h"
#include "ExtiDriver.h"

#define STACK_SIZE 200

/* Definición de variables del sistema */
uint32_t SystemCoreClock = 100000000;

/* Periféricos del sistema */
GPIO_Handler_t handlerBlinkyPin = {0};
GPIO_Handler_t handlerButton = {0};
EXTI_Config_t handlerExtiButton = {0};

TaskHandle_t xHandleTask_Led = NULL;
TaskHandle_t xHandleTask_Button = NULL;

/* Prototipos de funciones */
void initSystem(void);
void vTask_led_green_handler( void * pvParameters );
//void vTask_button_handler( void * pvParameters );

extern void SEGGER_UART_init(uint32_t);

int main(void)
{

	initSystem();

	/* Activamos la unidad de punto flotante (FPU) */
	SCB->CPACR    |= (0xF << 20);

	/* Activamos del contador de Ticks */
	DWT->CTRL    |= (1 << 0);

	/* Necesario para el SEGGER*/
	vInitPrioGroupValue();

	/* Configuramos el puerto serial para trabajar con SEGGER */
	SEGGER_UART_init(500000);

	/* Primero configuramos */
	SEGGER_SYSVIEW_Conf();

	/* Aquí no activamos el sistema porque usamos USART, debido a que el archivo hace esa inicialización */
	SEGGER_SYSVIEW_Start();

	BaseType_t xReturned;


    xReturned = xTaskCreate(
    				vTask_led_green_handler,      	/* Function that implements the task. */
                    "Task-Led",          			/* Text name for the task. */
                    STACK_SIZE,      				/* Stack size in words, not bytes. */
                    "Blinky Led",   				/* Parameter passed into the task. */
                    3, 								/* Priority at which the task is created. */
                    &xHandleTask_Led );      		/* Used to pass out the created task's handle. */

    configASSERT(xReturned == pdPASS);

//    xReturned = xTaskCreate(
//    				vTask_button_handler,       /* Function that implements the task. */
//                    "Task-Button",          	/* Text name for the task. */
//                    STACK_SIZE,      			/* Stack size in words, not bytes. */
//                    "Button",    				/* Parameter passed into the task. */
//                    4, 							/* Priority at which the task is created. */
//                    &xHandleTask_Button );      /* Used to pass out the created task's handle. */
//
//    configASSERT(xReturned == pdPASS);

    SEGGER_SYSVIEW_PrintfTarget("Starting the Scheduler");

    /* Start the created tasks running */
    vTaskStartScheduler();

    /* Loop forever */
	while(1){
		/* Si llegamos acá, es que algo salio mal...*/
	}
}

/** Función que inicia todo el sistema*/
void initSystem(void){
	configPLL(100);

	/* GPIO del Blinky Led de Estado PA5 */
	handlerBlinkyPin.pGPIOx								= GPIOA;
	handlerBlinkyPin.GPIO_PinConfig.GPIO_PinNumber 		= PIN_5;
	handlerBlinkyPin.GPIO_PinConfig.GPIO_PinMode		= GPIO_MODE_OUT;
	handlerBlinkyPin.GPIO_PinConfig.GPIO_PinSpeed 		= GPIO_OSPEED_FAST;
	handlerBlinkyPin.GPIO_PinConfig.GPIO_PinOPType 		= GPIO_OTYPE_PUSHPULL;
	// Cargo la configuración
	GPIO_Config(&handlerBlinkyPin);
	// Comienzo en estado bajo
	GPIO_WritePin(&handlerBlinkyPin, RESET);

	/* GPIO del User Button */
	handlerButton.pGPIOx								= GPIOC;
	handlerButton.GPIO_PinConfig.GPIO_PinNumber 		= PIN_13;
	handlerButton.GPIO_PinConfig.GPIO_PinMode			= GPIO_MODE_IN;
	handlerButton.GPIO_PinConfig.GPIO_PinPuPdControl	= GPIO_PUPDR_NOTHING;
	// Cargo la configuración
	GPIO_Config(&handlerButton);
	handlerExtiButton.pGPIOHandler		= &handlerButton;
	handlerExtiButton.edgeType 			= EXTERNAL_INTERRUPT_RISING_EDGE;
	// Importante, con menor número (mayor prioridad), va a tirar un error
	handlerExtiButton.priorityInterrupt	= 6;
	extInt_Config(&handlerExtiButton);

}

/** Función que gobierna la tarea 1 */
void vTask_led_green_handler( void * pvParameters )
{
	BaseType_t notify_status = {0};
	uint8_t ctrl_led = 0;


    while(1)
    {
        /* Task code goes here. */
    	if(ctrl_led){
    		SEGGER_SYSVIEW_PrintfTarget("Blinky");
    		GPIOxTooglePin(&handlerBlinkyPin);
    	}
    	else{
    		SEGGER_SYSVIEW_PrintfTarget("Stop");
    		GPIO_WritePin(&handlerBlinkyPin, RESET);
    	}

    	notify_status = xTaskNotifyWait(0,0,NULL,pdMS_TO_TICKS(250));


    	if(notify_status == pdTRUE){
    		// Para desactivar las interrupciones por un pequeño instante hacemos esto
    		portENTER_CRITICAL();

    		ctrl_led = !ctrl_led;

    		// Ahora las volvemos a activar
    		portEXIT_CRITICAL();
    	}

    	//vTaskDelay(pdMS_TO_TICKS(250));
    	//taskYIELD();
    }
}

/** Función que gobierna la tarea 2 */
void vTask_button_handler( void * pvParameters )
{

//	uint8_t button_state = 0;
//	uint8_t prev_button_state = 0;

    while(1)
    {
//        /* Task code goes here. */
//    	button_state = GPIO_ReadPin(&handlerButton);
//
//    	if(button_state){
//    		if(!prev_button_state){
//    			// Notificación
//    			xTaskNotify(xHandleTask_Led,0,eNoAction);
//    		}
//    	}
//
//    	// Actualizamos el estado anterior
//    	prev_button_state = button_state;

    	/* Hacemos la lectura del boton cada 10 ms */
    	vTaskDelay(pdMS_TO_TICKS(10));
    }
}

/* Interrupción lanzada por el User Button */
void callback_extInt13(void){

	BaseType_t pxHigherPriorityTaskWoken;
	pxHigherPriorityTaskWoken = pdFALSE;

	// Esta es una función para el SEGGER_SYSTEM_VIEW, para que el SEGGER "vea" o "reconozca" la interrupción
	traceISR_ENTER();
	// Notificamos a la función del LED desde una ISR
	xTaskNotifyFromISR(xHandleTask_Led, 0, eNoAction, &pxHigherPriorityTaskWoken);

	//portYIELD_FROM_ISR(pxHigherPriorityTaskWoken);
	//xTaskNotify(,eNoAction)
	traceISR_EXIT();
}


