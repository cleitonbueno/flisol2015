#! /bin/sh


PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export DISPLAY=':0.0'


PID_KIOSK=$(pidof epiphany-browser)
/bin/echo "PID -> ${PID_KIOSK}" >> /tmp/kiosk.log



# Captura sinal Ctrl+C e (INT e TERM) e encerra a aplicacao
trap ControlExit 2 15
ControlExit () {
	/bin/echo -en "\n## Sinal capturado, encerrando Epiphany e saindo... \n"
	/bin/kill -9 ${PID_KIOSK} >/dev/null
	exit 0
}


# Verifica se ja nao possui uma instancia rodando
if [ ! -z ${PID_KIOSK} ]; then
	/bin/echo "Processo Web Kiosk com Epiphany ja esta rodando. PID -> ${PID_KIOSK}" >> /tmp/kiosk.log
	exit 0
fi

/bin/echo "Epiphany nao esta rodando" >> /tmp/kiosk.log

if [ ! -x /usr/bin/xdotool ]; then
	/bin/echo -e "Utilitario xdotool nao encontrada!"
	exit 1
fi


if [ ! -x /usr/bin/unclutter ]; then
	/bin/echo -e "Utilitario uclutter nao encontrado!"
	exit 1
fi


/usr/bin/epiphany-browser --display=:0 http://www.cleitonbueno.com


/bin/echo "Iniciando Epiphany, aguarde..." >> /tmp/kiosk.log

sleep 5


# Enviando F11 para o Epiphany
/usr/bin/xdotool key F11


# Removendo o cursor da tela
/usr/bin/unclutter -display :0 -noevents -grab &
