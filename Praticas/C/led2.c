#include <wiringPi.h>

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>



/*
   PINO 11 -> GPIO0	[Outras Linguagens eh GPIO17]

 */
int main() {
	/* Verifica se WiringPiSetup esta OK */
	if (wiringPiSetup () == -1)
		exit (1) ;

	/* Configura GPIO0 como OUTPUT */
	pinMode(0, OUTPUT);

	printf("\nIniciando Aplicacao C com WiringPI\n");
	
	/* LOOP Pisca-Led */
	while(1) {
		digitalWrite(0, HIGH);
		printf("LED GPIO[0] LIGADO\n");
		sleep(3);
		digitalWrite(0, LOW);
		printf("LED GPIO[0] DESLIGADO\n");
		sleep(3);
	}

	return 0 ;
}
