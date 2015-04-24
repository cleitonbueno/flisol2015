#! /bin/sh

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

if [ -z $2 ]; then
	/bin/echo -e "Voce deve passar dois parametros o arquivo .c e o nome do binario a ser gerado"
	exit 1
fi


COD_C=$1
BIN_C=$2


/bin/echo -e "Compilando..."
/usr/bin/gcc ${COD_C} -lwiringPi -o ${BIN_C}
