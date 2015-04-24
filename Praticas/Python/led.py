#! /usr/bin/python
# -*- coding: utf-8 -*-

import RPi.GPIO as gpio
import time
 

# Configurando o GPIO
gpio.setmode(gpio.BCM)
 
# Configurando PINO e sua DIRECAO
gpio.setup(17, gpio.OUT) 

# Desabilitando warnings na tela
gpio.setwarnings(False)

while True:
	try:
		gpio.output(17, gpio.HIGH)
		print("LED GPIO[17] LIGADO")
		time.sleep(2)
		gpio.output(17, gpio.LOW)
		print("LED GPIO[17] APAGADO")
		time.sleep(2)
	except KeyboardInterrupt:
		print("Limpando configuracoes e saindo...")
		gpio.cleanup()
