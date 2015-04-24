#include <wiringPi.h>

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>



/*
   PINO 12 -> GPIO1	[Outras Linguagens eh GPIO18]

 */
int main() {
	/* Verifica se WiringPiSetup esta OK */
	if (wiringPiSetup () == -1)
		exit (1) ;

	/* Configura GPIO1 como INPUT */
	pinMode(1, INPUT);


	printf("\nIniciando Aplicacao C com WiringPI\n");

	/* LOOP Leitura Botao */
	while(1) {
		if( ! digitalRead(1) ) {
			printf("BOTAO GPIO[1] ACIONADO\n");
		}
		sleep(1);
	}

	return 0 ;
}
