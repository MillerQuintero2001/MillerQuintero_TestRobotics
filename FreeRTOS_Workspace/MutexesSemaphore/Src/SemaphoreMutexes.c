/**
 ******************************************************************************
 * @file           : SemaphoreMutexes.c.c
 * @author         : MillerQuintero2001 - miquinterog@unal.edu.co
 * @brief          : Basic Example of Semaphores Mutexes
 ******************************************************************************
 * Este programa utiliza a un mutex para recibir solicitudes
 * de ejecución de varias tareas.
 *
 * Se utiliza el mutex para lograr que las 2 tareas que emplean el recurso
 * lo logren hacer de forma mutuamente exclusiva
 ******************************************************************************
 */

#include <stm32f4xx.h>

/* Librerías de FreeRTOS */
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "timers.h"
#include "semphr.h"

/* Librerías estándar de C */
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

/* Drivers necesarios */
#include "PLLDriver.h"
#include "GPIOxDriver.h"
#include "USARTxDriver.h"
#include "ExtiDriver.h"

/* Tamaño del Stack */
#define STACK_SIZE 200

/* Definición de variables del sistema */
uint32_t SystemCoreClock = 100000000;

/* Definición de Periféricos de nuestras librerías */
GPIO_Handler_t handlerBlinkyPin = {0};;

GPIO_Handler_t handlerButton = {0};
EXTI_Config_t handlerExtiButton = {0};

GPIO_Handler_t handlerRx = {0};
GPIO_Handler_t handlerTx = {0};
USART_Handler_t usartComm = {0};

/* Variable auxiliar para la recepción serial*/
uint8_t usartData = 0;

/* Variable que recibe el resultado de la creación de elementos FreeRTOS */
BaseType_t xReturned;

/* Software timer para el led de estado (1)*/
TimerHandle_t handle_led_timer;

/* Definición del Mutex como semáforo, se usará para garantizar el acceso
 * mutuamente exclusivo al recurso, que en este caso es el puerto serial */
xSemaphoreHandle xMutex;

TaskHandle_t xHandleTask_Print1 = NULL;
TaskHandle_t xHandleTask_Print2 = NULL;
TaskHandle_t xHandleTask_Print3 = NULL;

/* Cabeceras de las funciones del FreeRTOS */
void vTask_Print( void * pvParameters );

const char *msg_working = "\n - - Working - - \n";
char auxMsg[64] = {0};

volatile uint8_t printOneTime = 0;
volatile uint16_t randomNumber = 0;


/* Cabeceras de otras funciones, como el initSystem, la función para generar el número random
 * y el callback para el led de estado (3)*/
void initSystem(void);
uint16_t getRandomNumber(void);
void led_state_callback( TimerHandle_t xTimer );
void prv_PrintString( const portCHAR *pcString );

/* ¡Función principal, acá es donde sucede todo! */
int main(void){

	/* Activamos la unidad de punto flotante (FPU) */
	SCB->CPACR	|= (0xF << 20);

	/* Activamos del contador de Ticks */
	DWT->CTRL	|= (1 << 0);

	/* Configuramos el reloj principal a 100 MHz*/
	configPLL(100);

	/* Iniciamos los periféricos para trabajar */
	initSystem();

	/* Creando la Tarea Print 1 */
    xReturned = xTaskCreate(
    		vTask_Print,      				/* Function that implements the task. */
            "Task-Print_1",          		/* Text name for the task. */
			STACK_SIZE,      				/* Stack size in words, not bytes. */
            "---- Task_Print_1 ----\n",   	/* Parameter passed into the task. */
            2, 								/* Priority at which the task is created. */
            &xHandleTask_Print1 );      	/* Used to pass out the created task's handle. */

    configASSERT(xReturned == pdPASS);

	/* Creando la Tarea Print 2 */
    xReturned = xTaskCreate(
    		vTask_Print,      				/* Function that implements the task. */
            "Task-Print_2",          		/* Text name for the task. */
			STACK_SIZE,      				/* Stack size in words, not bytes. */
            "---- Task_Print_2 ----\n",   	/* Parameter passed into the task. */
            3, 								/* Priority at which the task is created. */
            &xHandleTask_Print2 );      	/* Used to pass out the created task's handle. */

    configASSERT(xReturned == pdPASS);

	/* Creando la Tarea Print 3 */
    xReturned = xTaskCreate(
    		vTask_Print,      				/* Function that implements the task. */
            "Task-Print_3",          		/* Text name for the task. */
			STACK_SIZE,      				/* Stack size in words, not bytes. */
            "---- Task_Print_3 ----\n",   	/* Parameter passed into the task. */
            4, 								/* Priority at which the task is created. */
            &xHandleTask_Print3 );      	/* Used to pass out the created task's handle. */

    configASSERT(xReturned == pdPASS);

    /* Creando el semáforo mutex */
    xMutex = xSemaphoreCreateMutex();
    configASSERT(xMutex != NULL);		// Verificamos que se ha creado el Mutex

    /* Creando el timer que controla el blinky del led de estado */
    handle_led_timer = xTimerCreate("led_timer", pdMS_TO_TICKS(200), pdTRUE, (void*)(1), led_state_callback);

   	/* Activar el Timer que controla el led */
   	xTimerStart(handle_led_timer, portMAX_DELAY);

    /* Ejecutamos el programador de inicio de tareas */
    vTaskStartScheduler();


    /* Loop forever */
	while(1){
		/*Si llegamos acá, es que algo salió mal...*/
	}
}


/* Función que gobierna a la tarea Print */
void vTask_Print( void * pvParameters ){

	char *pcStringToPrint;

	/* Two instances of this task are created, so the string that task will send
	 * to prvNewPrintString() is passed in the task parameter. Cast this to the
	 * required type. */

	pcStringToPrint = (char*) pvParameters;


    while(1)
    {
        /* Print out the string using the newly defined function */
    	prv_PrintString(pcStringToPrint);

    	/* Wait a pseudo random time. Note that rand() is not necessarily
    	 * re-entrant, but in this case, it does not really matter as the code does
    	 * not care what value is returned. In a more secure application a version
    	 * of rand() that is known to be re-entrant should be used - or call to
    	 * rand() should be protected using a critical section */
    	vTaskDelay(getRandomNumber() & 0xFF);
    }
}


void prv_PrintString(const portCHAR *pcString){

	char cBuffer[60];

	/* The semaphore is created before the scheduler is started, so already
	 exists by the time this task executes.

	 Attemp to take the semaphore, blocking indefinitely if the mutex is not
	 available immediately. The call to xSemaphoreTake() will only return when
	 the semaphore has been successfully obtained, so there is no need to check the
	 return value. If any other delay period was used then the code must check
	 that xSemaphoreTake() returns pdTRUE bedore accessing the resource (in this
	 case standard out. */
	 xSemaphoreTake(xMutex, portMAX_DELAY);
	 {
		 /* The following line will only execute once the semaphore has been
		  successfully obtained - so standard out can be accessed freely. */
		 sprintf(cBuffer, "%s", pcString);
		 writeMsg(&usartComm, (char*) cBuffer);
	 }
	 xSemaphoreGive(xMutex);
}

/* Función para inicializar el hardware del equipo (PeripheralDrivers) */
void initSystem(void){
	/* Configurando el LED_STATE, GPIOA PIN5 */
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

/* Interrupcion lanzada por el User Button */
void callback_extInt13(void){

	/* Activar la variable printOneTime*/
	printOneTime = 1;;

	randomNumber = getRandomNumber();

	BaseType_t pxHigherPriorityTaskWoken;
	pxHigherPriorityTaskWoken = pdFALSE;
	(void)pxHigherPriorityTaskWoken;
}

/* Interrupcion debida al puerto serial */
void usart2Rx_Callback(void){
	/* Recibir un dato en el serial y no hacer nada más */
	usartData = getRxData();
}
