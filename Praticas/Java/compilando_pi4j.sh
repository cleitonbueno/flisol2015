#! /bin/sh

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

if [ -z $1 ]; then
	/bin/echo -e "Faltou o parametro codigo.java\nEx: $0 gpio.java"
	exit 1
fi

COD_JAVA=$1

/bin/echo -e "Compilando..."

javac -classpath .:classes:/opt/pi4j/lib/'*' -d . $COD_JAVA

if [ "$?" = "0" ]; then
	/bin/echo -e "$1 compilando com sucesso!"
else
	/bin/echo -e "ERRO ao compilar $1"
	exit 1
fi

exit 0
