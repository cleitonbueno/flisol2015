#! /bin/sh

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin



# Verifica se voce passou o GPIO como parametro
if [ -z $1 ]; then
	/bin/echo -e "Voce deve passar o numero do GPIO!"
	exit 1
fi


# Verifica se o WiringPI esta instalado
if [ ! -x /usr/local/bin/gpio1 ]; then
	/bin/echo -e "WiringPI nao esta instalado!\n"
	exit 1
fi


# Verifica se voce possui permissao de root (Obrigatorio)
if [ "$(id -u)" != "0" ]; then
	/bin/echo -e "Voce precisa ser root ou permissoes de root para continuar..." 1>&2
	exit 1
fi


# PINO e INTERVALO
PIN=$1
INTERVAL=3


/usr/local/bin/gpio mode ${PIN} out

while true;
do
        /usr/local/bin/gpio write ${PIN} 1
	/bin/echo -e "LED GPIO[${PIN}] LIGADO"
	sleep ${INTERVAL}
        /usr/local/bin/gpio write ${PIN} 0
	/bin/echo -e "LED GPIO[${PIN} DESLIGADO"
	sleep ${INTERVAL}
done


unset $PIN 
