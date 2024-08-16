/*
 * main.c
 *
 *  Created on: Jul 31, 2024
 *      Author: MillerQuintero2001
 */

#include <main.h>

#define STACK_SIZE 200

/* Definición de variables del sistema */
uint32_t SystemCoreClock = 100000000;
uint8_t usartData = 0;
BaseType_t xReturned;
state_t next_state = sMainMenu;

/* Periféricos del sistema */
GPIO_Handler_t handlerBlinkyPin = {0};
GPIO_Handler_t handlerButton = {0};
GPIO_Handler_t handlerRx = {0};
GPIO_Handler_t handlerTx = {0};
USART_Handler_t usartComm = {0};

/* Handle relacionado con las tareas */
TaskHandle_t xHandleTask_Menu = NULL;
TaskHandle_t xHandleTask_Print = NULL;
TaskHandle_t xHandleTask_Commands = NULL;

/* Colas */
QueueHandle_t xQueue_Print;
QueueHandle_t xQueue_InputData;

SemaphoreHandle_t xBinarySemaphore;

/* Temporizador */
TimerHandle_t handle_led_timer;

/* Prototipos de funciones */
void initSystem(void);
extern void vTask_Menu( void * pvParameters );
extern void vTask_Print( void * pvParameters );
extern void vTask_Commands( void * pvParameters);

int main(void)
{

	initSystem();

	/* Activamos la unidad de punto flotante (FPU) */
	SCB->CPACR	|= (0xF << 20);

	/* Activamos del contador de Ticks */
	DWT->CTRL	|= (1 << 0);

//	/* Necesario para el SEGGER*/
//	vInitPrioGroupValue();

//	/* Configuramos el puerto serial para trabajar con SEGGER */
//	SEGGER_UART_init(500000);
//
//	/* Primero configuramos */
//	SEGGER_SYSVIEW_Conf();
//
//	/* Aquí no activamos el sistema porque usamos USART, debido a que el archivo hace esa inicialización */
//	SEGGER_SYSVIEW_Start();

	/* Creando la Tarea Menu */
    xReturned = xTaskCreate(
    		vTask_Menu,      				/* Function that implements the task. */
            "Task-Menu",          			/* Text name for the task. */
			STACK_SIZE,      				/* Stack size in words, not bytes. */
            NULL,   						/* Parameter passed into the task. */
            3, 								/* Priority at which the task is created. */
            &xHandleTask_Menu );      		/* Used to pass out the created task's handle. */

    configASSERT(xReturned == pdPASS);

    /* Creando la Tarea Print */
    xReturned = xTaskCreate(
    		vTask_Print,       				/* Function that implements the task. */
            "Task-Print",          			/* Text name for the task. */
            STACK_SIZE,      				/* Stack size in words, not bytes. */
            NULL,    						/* Parameter passed into the task. */
            2, 								/* Priority at which the task is created. */
            &xHandleTask_Print );      		/* Used to pass out the created task's handle. */

    configASSERT(xReturned == pdPASS);

    /* Creando la Tarea Commands */
    xReturned = xTaskCreate(
    		vTask_Commands,       /* Function that implements the task. */
            "Task-Commands",          	/* Text name for the task. */
             STACK_SIZE,     			/* Stack size in words, not bytes. */
             NULL,    				/* Parameter passed into the task. */
             3, 							/* Priority at which the task is created. */
             &xHandleTask_Commands );      /* Used to pass out the created task's handle. */

    configASSERT(xReturned == pdPASS);

//    SEGGER_SYSVIEW_PrintfTarget("Starting the Scheduler");

    /* Creando las 2 colas */
    xQueue_InputData = xQueueCreate(10, sizeof(char));
    configASSERT(xQueue_InputData != NULL);		// Verificamos que se ha creado la queue

    //xQueue_Print = xQueueCreate(10, sizeof(struct AMessage *));
    xQueue_Print = xQueueCreate(10, sizeof(size_t));
    configASSERT(xQueue_Print != NULL);		// Verificamos que se ha creado la queue

    /* Creando el timer */
    handle_led_timer = xTimerCreate("led_timer", pdMS_TO_TICKS(500), pdTRUE, (void*)(1), led_state_callback);

    xTimerStart(handle_led_timer, portMAX_DELAY);

    /* Creando el semáforo */
    xBinarySemaphore = xSemaphoreCreateBinary();
    configASSERT(xBinarySemaphore != NULL);


    /* Start the created tasks running */
    vTaskStartScheduler();

    /* Loop forever */
	while(1){
		/* Si llegamos acá, es que algo salió mal...*/
	}
}

/** Función que inicia todo el sistema */
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
	GPIO_WritePin(&handlerBlinkyPin, SET);

	handlerButton.pGPIOx								= GPIOC;
	handlerButton.GPIO_PinConfig.GPIO_PinNumber			= PIN_13;
	handlerButton.GPIO_PinConfig.GPIO_PinMode			= GPIO_MODE_IN;
	handlerButton.GPIO_PinConfig.GPIO_PinPuPdControl	= GPIO_PUPDR_NOTHING;
	GPIO_Config(&handlerButton);

	/* Configuración de pines para el USART1 */
	handlerTx.pGPIOx								= GPIOA;
	handlerTx.GPIO_PinConfig.GPIO_PinNumber 		= PIN_2;
	handlerTx.GPIO_PinConfig.GPIO_PinMode			= GPIO_MODE_ALTFN;
	handlerTx.GPIO_PinConfig.GPIO_PinSpeed			= GPIO_OSPEED_HIGH;
	handlerTx.GPIO_PinConfig.GPIO_PinAltFunMode		= AF7;
	GPIO_Config(&handlerTx);

	handlerRx.pGPIOx								= GPIOA;
	handlerRx.GPIO_PinConfig.GPIO_PinNumber 		= PIN_3;
	handlerRx.GPIO_PinConfig.GPIO_PinMode			= GPIO_MODE_ALTFN;
	handlerRx.GPIO_PinConfig.GPIO_PinSpeed			= GPIO_OSPEED_HIGH;
	handlerRx.GPIO_PinConfig.GPIO_PinAltFunMode		= AF7;
	GPIO_Config(&handlerRx);

	/* Configuración de la comunicación serial */
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


/** Interrupción debida al puerto serial */
void usart2Rx_Callback(void){
	usartData = getRxData();

	BaseType_t xHigherPriorityTaskWoken;
	(void) xHigherPriorityTaskWoken;
	/* We have not woken a task at the start of the ISR */
	xHigherPriorityTaskWoken = pdFALSE;

	// Verificamos si la cola aún no está llena
	xReturned = xQueueIsQueueFullFromISR(xQueue_InputData);

	/* Si NO es true, entonces aún hay espacio */
	if(xReturned != pdTRUE){
		//xReturned = xQueueSendToBackFromISR(xQueue_InputData, (void*)&usartData, NULL);
		xQueueSendToBackFromISR(xQueue_InputData, (void*)&usartData, NULL);
	}
	else{
		// Queue is full (la cola está llena)
		if(usartData == '#'){
			xQueueReceiveFromISR(xQueue_InputData, (void*)&usartData, NULL);
			xQueueSendToBackFromISR(xQueue_InputData, (void*)&usartData, NULL);
		}
	}
	/* Send notification to command task -> command received : usartData == '#'*/
	if(usartData == '#'){
		/* Send Notification */
		//xTaskNotifyFromISR(xHandleTask_Commands, 0, eNoAction, NULL);
		xSemaphoreGiveFromISR(xBinarySemaphore, &xHigherPriorityTaskWoken);
	}
}

void led_state_callback(TimerHandle_t xTimer){
	GPIOxTooglePin(&handlerBlinkyPin);
}
