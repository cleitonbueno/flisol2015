#! /bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Intervalo em segundos [terceiro parametro]
INTERVAL=5

if [ -z $3 ]; then
	/bin/echo -e "\nFaltou o parametro codigo.class\nCorreto: $0 class pino direcao interval"
	/bin/echo -e "\nEx: $0 gpio 01 output 3"
	/bin/echo -e "\nSera executado a class gpio utilizando o pino GPIO1 como output[saida]"
	/bin/echo -e "intervalo eh 5s caso nao especificade"
	exit 1
fi


if [ ! -z $4 ]; then
	INTERVAL=$4
fi


# Setando variaveis com os parametros informados
EXEC_JAVA=$1
PIN=$2
DIRECTION=$3


/bin/echo -e "Executando..."
/bin/echo -e "\nCLASSE   = $EXEC_JAVA" 
/bin/echo -e "GPIO     = $PIN" 
/bin/echo -e "DIRECAO  = $DIRECTION" 
/bin/echo -e "INTERVAL = $INTERVAL"
/bin/echo -e "\n"
 

# Executando aplicacao Java
sudo java -classpath .:classes:/opt/pi4j/lib/'*' $EXEC_JAVA $PIN $DIRECTION $INTERVAL



# 
unset EXEC_JAVA
unset INTERVAL
unset PIN
unset DIRECTION

exit 0
