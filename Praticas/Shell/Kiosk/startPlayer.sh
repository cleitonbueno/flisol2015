#! /bin/sh


PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

PATH_VIDEOS="/home/pi/videos"
LIST_VIDEOS=$(ls -1 ${PATH_VIDEOS}/)


if [ ! -x /usr/bin/omxplayer ]; then
	/bin/echo -e "Utilitario omxplayer nao encontrada!"
	exit 1
fi
/bin/echo -e "[omxplayer]\t=> OK"



for files in ${LIST_VIDEOS}; do
	/bin/echo "Reproduzindo $PATH_VIDEOS/$files"
	#/usr/bin/mplayer -vo fbdev2:/dev/fb0 $PATH_VIDEOS/$files
	/usr/bin/omxplayer -b -o hdmi $PATH_VIDEOS/$files >/dev/null 
done
