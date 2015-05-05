#! /bin/sh

if [ ! -x /usr/bin/fbi ]; then
	/bin/echo -e "Utilitario fbi nao encontrado, é uma dependencia para continuar!"
	exit 1
fi

PID_FBI=$(pidof fbi)
if [ "${PID_FBI}" != "" ]; then
	/usr/bin/killall fbi >/dev/null 2>&1
fi

PATH_IMAGES="/home/pi/images"

/usr/bin/fbi -noverbose -d /dev/fb0 -T 1 -t 5 -a ${PATH_IMAGES}/*.*
