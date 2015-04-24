#! /usr/bin/python
# -*- coding: utf-8 -*-
 
import RPi.GPIO as gpio
import time
 
gpio.setmode(gpio.BCM)
 
#gpio.setup(18, gpio.IN, pull_up_down = gpio.PUD_DOWN)
gpio.setup(18, gpio.IN)

# Desabilitando warnings na tela
gpio.setwarnings(False)

 
while True:
	try:
		if(gpio.input(18) == 0):
			print("Botão pressionao")
		time.sleep(1)
	except KeyboardInterrupt:
 		gpio.cleanup()
		exit()
