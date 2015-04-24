// START SNIPPET: gpioin

/*
 * #%L
 * **********************************************************************
 * ORGANIZATION  :  Pi4J
 * PROJECT       :  Pi4J :: Java Examples - FLISOL 2015
 * FILENAME      :  GpioIn.java  
 * 
 * This file is part of the Pi4J project. More information about 
 * this project can be found here:  http://www.pi4j.com/
 * **********************************************************************
 * %%
 * Copyright (C) 2012 - 2015 Pi4J
 * %%
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Lesser Public License for more details.
 * 
 * You should have received a copy of the GNU General Lesser Public
 * License along with this program.  If not, see
 * <http://www.gnu.org/licenses/lgpl-3.0.html>.
 * #L%
 */

import com.pi4j.io.gpio.GpioController;
import com.pi4j.io.gpio.GpioFactory;
import com.pi4j.io.gpio.GpioPinDigitalInput;
import com.pi4j.io.gpio.PinState;
import com.pi4j.io.gpio.RaspiPin;

/**
 * This example code demonstrates how to perform simple state
 * control of a GPIO pin on the Raspberry Pi.  
 * 
 * @author Robert Savage adapter to Cleiton Bueno
 */
public class GpioIn {

	public static void main(String[] args) throws InterruptedException {

		System.out.println("<--Pi4J--> GPIO Control Mode INPUT with button started.");


        	// create gpio controller
	        final GpioController gpio = GpioFactory.getInstance();


		// provision gpio pin #02 as an input pin with its internal pull down resistor enabled
		// GpioPinDigitalInput inputPin = gpio.provisionDigitalInputPin(RaspiPin.GPIO_01, "MyButton", PinPullResistance.PULL_DOWN);
		GpioPinDigitalInput inputPin = gpio.provisionDigitalInputPin(RaspiPin.GPIO_01, "MyButton");


		while (true) {
			// Lendo o valor do PINO 2 (GPIO18)
			boolean input_value = inputPin.isHigh();

			if (! input_value) {
				System.out.println("Botao Acionado");
			}

			Thread.sleep(1000);
		}
		//gpio.shutdown();
	}
}
//END SNIPPET: gpioin
