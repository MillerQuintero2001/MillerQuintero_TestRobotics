/*
 * main.h
 *
 *  Created on: Jul 31. 2024
 *      Author: MillerQuintero2001
 */

#ifndef MAIN_H_
#define MAIN_H_

#include <stm32f4xx.h>

#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "timers.h"

#include <stdint.h>
#include <stdio.h>
#include <string.h>

#include "PLLDriver.h"
#include "GPIOxDriver.h"
#include "USARTxDriver.h"

typedef struct{
	uint8_t payload[10];	/* Información recibida por el serial */
	uint32_t len;			/* Length -> Tamaño de los datos recibidos*/
}command_t;

typedef enum{
	sMainMenu = 0,
	sLedEffect,
	sRtcMenu,
}state_t;

/* Handle relacionada con las tareas */
extern TaskHandle_t xHandleTask_Menu;
extern TaskHandle_t xHandleTask_Print;
extern TaskHandle_t xHandleTask_Commands;

/* Prototipos de funciones de FreeRTOS */
void vTask_Menu( void * pvParameters );
void vTask_Print( void * pvParameters );
void vTask_Commands( void * pvParamters);

void led_state_callback(TimerHandle_t xTimer);

extern QueueHandle_t xQueue_InputData;
extern QueueHandle_t xQueue_Print;

extern state_t next_state;

extern USART_Handler_t commTerm_Handler;

#endif /* MAIN_H_ */
