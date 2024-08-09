/*
 * TaskHandler.c
 *
 *  Created on: Jul 31, 2024
 *      Author: MillerQuintero2001
 */

#include <main.h>

/* Prototipos */
void process_command(command_t *cmd);
int extract_command(command_t *cmd);

const char *msg_invalid = "\n//// Invalid Option ////\n";
const char *msg_option_0 = "\n---- Selected option - 0 ----\n";
const char *msg_option_1 = "\n---- Selected option - 1 ----\n";
const char *msg_option_2 = "\n---- Selected option - 2 ----\n";
const char *msg_option_n = "\n---- Option out of range ----\n";


/** Función que gobierna a la tarea Menu*/
void vTask_Menu(void * pvParameters){

	uint32_t cmd_addr;
	command_t *cmd;
	int option;

	const char* msg_menu =	"===========================\n"
							"|			Menu			|\n"
							"LED effect		---> 0\n"
							"Date and Time	---> 1\n"
							"Exit			---> 2\n"
							"Enter your choice here : ";
	while(1){
		/* Envia a imprimir en la consola lo que se debe mostrar en el menu */
		xQueueSend(xQueue_Print, &msg_menu, portMAX_DELAY);

		/* Se queda esperando a recibir el comando que se debe ejecutar */
		xTaskNotifyWait(0,0, &cmd_addr, portMAX_DELAY);
		cmd = (command_t*)cmd_addr;

		/* El comando recibido solo tiene el largo de un carácter */
		if(cmd->len == 1){
			/* Transformando un ASCII a un número */
			option = cmd->payload[0] - 48;

			switch(option){
			case 0:
				/* Envia a imprimir en la consola lo que se debe mostrar en el menú */
				xQueueSend(xQueue_Print,&msg_option_0, portMAX_DELAY);

				/* Acá se debería notificar, cambiar la variable next_state y notificar */
				next_state = sMainMenu;
				xTaskNotify(xHandleTask_Menu, 0, eNoAction);
				break;

			case 1:
				/* Envia a imprimir en la consola lo que se debe mostrar en el menú */
				xQueueSend(xQueue_Print,&msg_option_1, portMAX_DELAY);

				/* Acá se debería notificar cambiar la variable next_state y notificar */
				next_state = sMainMenu;
				xTaskNotify(xHandleTask_Menu, 0, eNoAction);
				break;

			case 2:
				/* Envia a imprimir en la consola lo que se debe mostrar en el menú*/
				xQueueSend(xQueue_Print,&msg_option_2, portMAX_DELAY);

				/* Acá se debería notificar cambiar la variable next_state y notificar */
				next_state = sMainMenu;
				xTaskNotify(xHandleTask_Menu, 0, eNoAction);
				break;

			default:
				xQueueSend(xQueue_Print, &msg_option_n, portMAX_DELAY);
				// Esta instruccion de 'continue' envia al sistema de nuevo a esperar un comando
				continue;
			}
		}
		else{
			xQueueSend(xQueue_Print, &msg_invalid, portMAX_DELAY);
			/* Acá se debería notificar cambiar la variable next_state y notificar */
			next_state = sMainMenu;
			xTaskNotify(xHandleTask_Menu, 0, eNoAction);
		}

		/* La tarea vuelve a quedar en un estado de espera por un tiempo indefinido */
		xTaskNotifyWait(0, 0, NULL, portMAX_DELAY);

	}// End of while Task_related-loop
}

/** Función que gobierna la tarea Print */
void vTask_Print(void * pvParameters){

	uint32_t *msg;

	while(1){
		/* Task code goes here */
		xQueueReceive(xQueue_Print, &msg, portMAX_DELAY);
		writeMsg(&usartComm, (char*)msg);
	}
}

/** Función que gobierna la tarea Commands*/
void vTask_Commands(void * pvParameters){

	BaseType_t notify_status = {0};
	command_t cmd = {0};

	while(1){
		/* Task code goes here */
		/* Esperamos la notificación desde la interrupción */
		notify_status = xTaskNotifyWait(0,0,NULL,portMAX_DELAY);

		/* Cuando es verdadero significa que se recibio una notificación */
		if(notify_status == pdTRUE){
			/* Process the user data (command) -> recibido por el serial y guardado */
			/* Notificar a la tarea que debe continuar */
			process_command(&cmd);
		}
	}
}

/** Función que ayuda a procesar el comando */
void process_command(command_t *cmd){
	extract_command(cmd);

	switch(next_state){
		case sMainMenu:
			/* Notificamos a la tarea respectiva */
			xTaskNotify(xHandleTask_Menu, (uint32_t)cmd, eSetValueWithOverwrite);
			break;

		case sLedEffect:
			//xTaskNotify(xHandleTask_Leds, (uint32_t)cmd, eSetValueWithOverwrite);
			break;

		case sRtcMenu:
			//xTaskNotify(xHandleTask_Rtc, (uint32_t)cmd, eSetValueWithOverwrite);
			break;

		default:
			__NOP();
			break;
	}
}

/** Función que extrae información del comando */
int extract_command(command_t *cmd){
	uint8_t item;
	uint8_t counter_j = 0;
	BaseType_t status;

	status = uxQueueMessagesWaiting(xQueue_InputData);
	if(status == 0){
		return -1;
	}

	do{
		/* Recibimos un elemento y lo montamos en 'item', además no deseamos bloquear */
		status = xQueueReceive(xQueue_InputData, &item, 0);
		if(status == pdTRUE){
			/* Vamos llenando el arreglo del comando */
			cmd->payload[counter_j++] = item;
		}

	}while(item != '#');

	cmd->payload[counter_j - 1] = '\0';
	cmd->len = counter_j - 1; // Longitud de los carácteres del comando sin contar el último

	return 0;
}
