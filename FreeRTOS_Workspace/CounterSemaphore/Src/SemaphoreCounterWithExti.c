/**
 ******************************************************************************
 * @file           : SemaphoreCounterWithExti.c
 * @author         : MillerQuintero2001 - miquinterog@unal.edu.co
 * @brief          : Counter Semaphore
 ******************************************************************************
 * Este programa utiliza a los semáforos contadores para recibir varias solicitudes
 * de ejecución de una tarea, lanzadas desde la interrupción de un botón.
 *
 * Se utiliza una función random para generar un número X de peticiones de ejecución
 * de la tarea, de forma que por cada pulsación del boton se generan varias (y no solo
 * una) solicitud de ejecución.
 *
 ******************************************************************************
 */
#include <stm32f4xx.h>

/* Incluir las librerías de FreeRTOS que sean necesarias (5)*/
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "timers.h"
#include "semphr.h"

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

/* Incluir los drivers que sean necesarios (4)*/
#include "PLLDriver.h"
#include "GPIOxDriver.h"
#include "USARTxDriver.h"
#include "ExtiDriver.h"

/* Tamaño del Stack */
#define STACK_SIZE 200

/* Definición de variables del sistema */
uint32_t SystemCoreClock = 100000000;

/* Definición de Periféricos de nuestras librerías para controlar un LED (1)*/
GPIO_Handler_t handlerBlinkyPin = {0};;

/* Definición de Periféricos de nuestras librerías para recibir una interrupción EXTI (2)*/
GPIO_Handler_t handlerButton = {0};
EXTI_Config_t handlerExtiButton = {0};

/* Definición de Periféricos de nuestras librerías para recibir el manejo del USART (3)*/
GPIO_Handler_t handlerRx = {0};
GPIO_Handler_t handlerTx = {0};
USART_Handler_t usartComm = {0};

/* Definición de Variable auxiliar para la recepción serial*/
uint8_t usartData = 0;

/* Elemento del FreeRTOS con el que se recibe el resultado de la creación de
 * tareas, y otros elementos del kernel del freeRTOS (1)*/
BaseType_t xReturned;

/* Definición de un semáforo binario y un semáforo contador (2)*/
SemaphoreHandle_t xBinarySemaphore;
SemaphoreHandle_t xCounterSemaphore;

/*  Definición de Software timer para el led de estado (1)*/
TimerHandle_t handle_led_timer;

TaskHandle_t xHandleTask_Counting = NULL;
TaskHandle_t xHandleTask_Print = NULL;

QueueHandle_t xQueue_Print;

const char *msg_working = "\n - - Working - - \n";
char auxMsg[64] = {0};

volatile uint8_t printOneTime = 0;

volatile uint16_t randomNumber = 0;

/* Cabeceras de las funciones que representan las tareas que ejecuta el FreeRTOS (2)*/
void vTask_Test_counting( void * pvParameters );
void vTask_Print( void * pvParameters );

/* Cabeceras de otras funciones, como el initSystem, la función para generar el número random
 * y el callback para el led de estado (3)*/
void initSystem(void);
uint16_t getRandomNumber(void);
void led_state_callback( TimerHandle_t xTimer );

/* ¡Función principal, acá es donde sucede todo! */
int main(void)
{
	/*Inicialización del sistema:
	 * - Encender la FPU
	 * - Activar el contador de Ticks para debuging
	 * - Configurar adecuadamente el reloj principal del equipo para 100 MHz
	 * - Llamar a la función que inicializa nuestros periféricos (initSystem)
	 * */

	/* Activamos la unidad de punto flotante (FPU) */
	SCB->CPACR	|= (0xF << 20);

	/* Activamos del contador de Ticks */
	DWT->CTRL	|= (1 << 0);

	/* Configuramos el reloj principal a 100 MHz*/
	configPLL(100);

	/* Iniciamos los periféricos para trabajar */
	initSystem();

	/* Crear las tareas que necesita el programa*/

	/* Creando la Tarea Counter */
    xReturned = xTaskCreate(
    		vTask_Test_counting,      		/* Function that implements the task. */
            "Task-Test_Counting",          	/* Text name for the task. */
			STACK_SIZE,      				/* Stack size in words, not bytes. */
            NULL,   						/* Parameter passed into the task. */
            2, 								/* Priority at which the task is created. */
            &xHandleTask_Counting );      	/* Used to pass out the created task's handle. */

    configASSERT(xReturned == pdPASS);

    /* Creando la Tarea Print */
    xReturned = xTaskCreate(
    		vTask_Print,       				/* Function that implements the task. */
            "Task-Print",          			/* Text name for the task. */
            STACK_SIZE,      				/* Stack size in words, not bytes. */
            NULL,    						/* Parameter passed into the task. */
            3, 								/* Priority at which the task is created. */
            &xHandleTask_Print );      		/* Used to pass out the created task's handle. */

    configASSERT(xReturned == pdPASS);

    /* Crear la cola para la tarea de impresión */
    xQueue_Print = xQueueCreate(10, sizeof(size_t));
    configASSERT(xQueue_Print != NULL);			// Verificamos que se ha creado

    /* Creando el semáforo binario (1)*/
    xBinarySemaphore = xSemaphoreCreateBinary();
    configASSERT(xBinarySemaphore != NULL);		// Verificamos que se ha creado

   	/* Creando el semáforo counter de 10 elementos, que inicia en 0 (1)*/
   	xCounterSemaphore = xSemaphoreCreateCounting(10,0);
   	configASSERT(xCounterSemaphore != NULL);	// Verificamos que se ha creado

    /* Creando el timer que controla el blinky del led de estado, con un periodo de 350ms (1)*/
    handle_led_timer = xTimerCreate("led_timer", pdMS_TO_TICKS(200), pdTRUE, (void*)(1), led_state_callback);

   	/* Activar el Timer que controla el led (1)*/
   	xTimerStart(handle_led_timer, portMAX_DELAY);

    /* Ejecutamos el programador de inicio de tareas */
    vTaskStartScheduler();


    /* Loop forever */
	while(1){
		/*Si llegamos acá, es que algo salió mal...*/
	}
}


/* Función que gobierna a la tarea que muestra como funciona un semáforo contador */
void vTask_Test_counting( void * pvParameters ){

	const TickType_t xMaxExpectedBlockTime = pdMS_TO_TICKS( 1000 );

    while(1)
    {
    	/* En este if() el sistema espera que se tenga un elemento disponible en el semáforo
    	 * cuando esta disponible actual -> imprime un mensaje que dice "working"*/
    	if (xSemaphoreTake(xCounterSemaphore, xMaxExpectedBlockTime) == pdPASS) {

    		/* Este bloque es para imprimir solo 1 vez el valor del número aleatorio*/
    		if(printOneTime == 1){
    			sprintf(auxMsg, "\nCounter i = %d\n", randomNumber);
    			char *dummy = auxMsg;
    			xQueueSend(xQueue_Print, &dummy, portMAX_DELAY);
    			printOneTime = 0;
    		}
    		/* Imprime las peticiones de trabajo que genera el número aleatorio en la interrupción*/
    		writeMsg(&usartComm, (char*)msg_working);
    	}
    }
}

/* Función que gobierna a la tarea Print */
void vTask_Print( void * pvParameters ){

	uint32_t *msg;
    while(1)
    {
        /* Task code goes here. */
    	xQueueReceive(xQueue_Print, &msg, portMAX_DELAY);
    	writeMsg(&usartComm, (char*)msg);

    }
}

/* Función para inicializar el hardware del equipo (PeripheralDrivers) */
void initSystem(void){
	/* Configurando el LED_STATE, GPIOA PIN5 (6)*/
	handlerBlinkyPin.pGPIOx									= GPIOA;
	handlerBlinkyPin.GPIO_PinConfig.GPIO_PinNumber 			= PIN_5;
	handlerBlinkyPin.GPIO_PinConfig.GPIO_PinMode			= GPIO_MODE_OUT;
	handlerBlinkyPin.GPIO_PinConfig.GPIO_PinSpeed 			= GPIO_OSPEED_FAST;
	handlerBlinkyPin.GPIO_PinConfig.GPIO_PinOPType 			= GPIO_OTYPE_PUSHPULL;
	handlerBlinkyPin.GPIO_PinConfig.GPIO_PinPuPdControl		= GPIO_PUPDR_NOTHING;
	GPIO_Config(&handlerBlinkyPin);
	GPIO_WritePin(&handlerBlinkyPin, RESET);

	/* Configurando el UserButton, GPIOC PIN-13 */
	handlerButton.pGPIOx								= GPIOC;
	handlerButton.GPIO_PinConfig.GPIO_PinNumber 		= PIN_13;
	handlerButton.GPIO_PinConfig.GPIO_PinMode			= GPIO_MODE_IN;
	handlerButton.GPIO_PinConfig.GPIO_PinPuPdControl	= GPIO_PUPDR_NOTHING;

	/* Matriculando el PINC3 en los elementos del EXTI, ademas de configurar la
	 * prioridad de la interrupcion (4) */
	handlerExtiButton.pGPIOHandler		= &handlerButton;
	handlerExtiButton.edgeType 			= EXTERNAL_INTERRUPT_RISING_EDGE;
	handlerExtiButton.priorityInterrupt	= 6;
	extInt_Config(&handlerExtiButton);

	/* configuramos primero los pines que corresponden al USART2 */
	/* Config Rx (6)*/
	handlerRx.pGPIOx								= GPIOA;
	handlerRx.GPIO_PinConfig.GPIO_PinNumber 		= PIN_3;
	handlerRx.GPIO_PinConfig.GPIO_PinMode			= GPIO_MODE_ALTFN;
	handlerRx.GPIO_PinConfig.GPIO_PinSpeed			= GPIO_OSPEED_HIGH;
	handlerRx.GPIO_PinConfig.GPIO_PinPuPdControl	= GPIO_PUPDR_NOTHING;
	handlerRx.GPIO_PinConfig.GPIO_PinAltFunMode		= AF7;
	GPIO_Config(&handlerRx);

	/* Config Tx (6)*/
	handlerTx.pGPIOx								= GPIOA;
	handlerTx.GPIO_PinConfig.GPIO_PinNumber 		= PIN_2;
	handlerTx.GPIO_PinConfig.GPIO_PinMode			= GPIO_MODE_ALTFN;
	handlerTx.GPIO_PinConfig.GPIO_PinSpeed			= GPIO_OSPEED_HIGH;
	handlerTx.GPIO_PinConfig.GPIO_PinPuPdControl	= GPIO_PUPDR_NOTHING;
	handlerTx.GPIO_PinConfig.GPIO_PinAltFunMode		= AF7;
	GPIO_Config(&handlerTx);

	/* Configurando el puerto serial (7)*/
	usartComm.ptrUSARTx								= USART2;
	usartComm.USART_Config.USART_baudrate 			= USART_BAUDRATE_115200;
	usartComm.USART_Config.USART_datasize			= USART_DATASIZE_8BIT;
	usartComm.USART_Config.USART_parity				= USART_PARITY_NONE;
	usartComm.USART_Config.USART_stopbits			= USART_STOPBIT_1;
	usartComm.USART_Config.USART_mode				= USART_MODE_RXTX;
	usartComm.USART_Config.USART_enableIntRX		= USART_RX_INTERRUP_ENABLE;
	usartComm.USART_Config.USART_enableIntTX		= USART_TX_INTERRUP_DISABLE;
	usartComm.USART_Config.USART_priorityInterrupt	= 6;
	USART_Config(&usartComm);
}

/*
 * Generar un número aleatorio entre 1 y 10
 * la funcion sran(number), es para generar una semilla, de forma
 * que rand() genere un número diferente siempre.
 * La funcion srand(number) requiere siempre un numero diferente, para
 * generar siempre un número diferente...
 * */
uint16_t getRandomNumber(void){
	int randomnumber;
	srand(xTaskGetTickCount());
	randomnumber = (rand() % 10) +1;
	return (uint16_t)randomnumber;
}

/*Controla el estado del Led */
void led_state_callback( TimerHandle_t xTimer ){
	GPIOxTooglePin(&handlerBlinkyPin);
}

/* Interrupcion lanzada por el encider del BlueMotor. */
void callback_extInt13(void){
	/* Activar la variable printOneTime*/
	printOneTime = 1;;
	/* Generar un numero aleatorio */
	randomNumber = getRandomNumber();

	BaseType_t pxHigherPriorityTaskWoken;
	pxHigherPriorityTaskWoken = pdFALSE;
	(void)pxHigherPriorityTaskWoken;

	/* Hacer un for que se ejecute tantas veces como el número aleatorio lo indica
	 * y allí cargar el semáforo (ejemplo binario y ejemplo counter)*/
   	for (uint16_t ii = 0; ii < randomNumber; ii++) {
   		/* Cargar el semáforo e indicar que hay un cambio en las funciones.*/
   		xSemaphoreGiveFromISR(xCounterSemaphore, &pxHigherPriorityTaskWoken);
	}
}

/* Interrupcion debida al puerto serial */
void usart2Rx_Callback(void){
	/* Recibir un dato en el serial y no hacer nada más */
	usartData = getRxData();
}
