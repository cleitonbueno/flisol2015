#! /bin/sh

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin


# /bin/bash
#trap ControlExit SIGINT SIGTERM
# /bin/sh
trap ControlExit 2 15


#Funcao para desfazer a configuracao do GPIO ao sair ou ser interrompido
# /bin/bash
# function ControlExit {
# /bin/sh
ControlExit () {
	/bin/echo -en "\n## Sinal capturado, desconfigurando GPIO[${PIN}] e saindo... \n"
	/bin/echo $PIN > /sys/class/gpio/unexport
	exit $?
}


# Verifica se voce passou o GPIO como parametro
if [ -z $1 ]; then
	/bin/echo -e "Voce deve passar o numero do GPIO!"
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


# Verifica se o Pino ja estava configurado no SysFS
if [ -d /sys/class/gpio/gpio${PIN} ]; then
	/bin/echo ${PIN} > /sys/class/gpio/unexport
fi


# Configurando o GPIO do LED via SysFS
/bin/echo ${PIN} > /sys/class/gpio/export
/bin/echo -e "\nGPIO[${PIN}]        -> OK"
/bin/echo "out" > /sys/class/gpio/gpio${PIN}/direction
/bin/echo -e "GPIO[${PIN}] OUTPUT -> OK\n"



# LOOP Pisca-Led
while true;
do
	/bin/echo 1 > /sys/class/gpio/gpio${PIN}/value
	/bin/echo "LED GPIO[${PIN}] -> LIGADO"
	sleep $INTERVAL
	/bin/echo 0 > /sys/class/gpio/gpio${PIN}/value
	/bin/echo "LED GPIO[${PIN}] -> DESLIGADO"
	sleep $INTERVAL
done



unset $PIN 
