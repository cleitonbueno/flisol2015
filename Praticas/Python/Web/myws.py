#! /usr/bin/python


import BaseHTTPServer
import os, sys, re
from mimetypes import types_map
import urlparse



class HandlerWS( BaseHTTPServer.BaseHTTPRequestHandler ):
	server_version= "HandlerWSFLISOL2015/1.1"

	def do_GET( self ):
		output_page = ""
		self.log_message( "Command: %s Path: %s Headers: %r" % ( self.command, self.path, self.headers.items() ) )

		try:
			parsed_path = urlparse.urlparse(self.path)
			self.send_response(200)
			#self.end_headers()
			#self.wfile.write(message)
			


			if self.path == "/" or self.path == "/index.html":
				self.path = "index.html"
			elif parsed_path.path == "/gpio" or self.path == "/gpio.html":
				if parsed_path.query == "pin=17&dir=out&value=1":
					self.wfile.write("LED LIGADO")
					gpio_led("17","1")
					self.sendPage("text/html","LED LIGADO")
				elif parsed_path.query == "pin=17&dir=out&value=0":
					self.wfile.write("LED DESLIGADO")
					gpio_led("17","0")
					self.sendPage("text/html","LED DESLIGADO")
				else:
					self.path = "gpio.html"
			elif self.path == "/cpu" or self.path == "/cpu.html":
				cpu_output = get_cpu_info()
				for cpu_list in cpu_output:
					output_page += "<h3>%s => %s</h3><br>" % (cpu_list[0],cpu_list[1])
				output_page += "<a href=\"/\">voltar</a>"
				self.sendPage("text/html", output_page)			


			fname,ext = os.path.splitext(self.path)
			if ext in (".html", ".css34"):
				with open(os.path.join(os.getcwd(),self.path)) as f:
					self.send_response(200)
					self.send_header('Content-type', types_map[ext])
					self.end_headers()
					self.wfile.write(f.read())
			return
		except IOError:
			self.send_error(404)
	
	def do_POST( self ):
		self.log_message( "Command: %s Path: %s Headers: %r" % ( self.command, self.path, self.headers.items() ) )
		if self.headers.has_key('content-length'):
			length= int( self.headers['content-length'] )
			self.dumpReq( self.rfile.read( length ) )
		else:
			self.dumpReq( None )

	def dumpReq( self, formInput=None ):
		response = "<html><head></head><body>"
		response += "<p>HTTP Request</p>"
		response += "<p>self.command= <tt>%s</tt></p>" % ( self.command )
		response += "<p>self.path= <tt>%s</tt></p>" % ( self.path )
		response += "</body></html>"
		self.sendPage( "text/html", response )
	
	def sendPage( self, type, body ):
		self.send_response( 200 )
		self.send_header( "Content-type", type )
		self.send_header( "Content-length", str(len(body)) )
		self.end_headers()
		self.wfile.write( body )

"""
	Funcao para abrir o /proc/cpuinfo e baseado nas palavras-chaves
	em cpu_keywords[], apos filtrar e cortar a sauda split(":")[1]
	o resultado ira para a lista output_cpu_info
"""
def get_cpu_info():
	cpu_keywords = ["model name", "Features", "flags", "Hardware", "Revision"]
	output_cpu_info = []
	with open('/proc/cpuinfo', 'r') as fl_cpu:
		for line in fl_cpu.readlines():
			output_cpu_info += [[cpu_item,line.split(":")[1]] for cpu_item in cpu_keywords if cpu_item in line]
	return output_cpu_info



"""
	Configurando GPIO17 e piscando LED
"""
def gpio_led(_pin, _value):
	os.system("echo 17 > /sys/class/gpio/export")
	os.system("echo out > /sys/class/gpio/gpio17/direction")
	with open('/sys/class/gpio/gpio'+_pin+'/value', 'w') as my_fdpin:
		my_fdpin.write(_value)


def help_usage():
	print "\tsys.argv[0] - Guia de Ajuda"
	sys.exit(0)

	
def httpd(port):
	handler_class=HandlerWS
	server_address = ('', port)

	try:
		wserver = BaseHTTPServer.HTTPServer(server_address, handler_class)
		wserver.serve_forever()
	except Exception, err:
		print "Error:%s" %err
	except KeyboardInterrupt:
		print "\n\nServidor recebeu um sinal, interrompendo e desligando...\n"
		wserver.socket.close()


if __name__ == "__main__":

	ws_port=80

	if len(sys.argv) >= 2:
		ws_port=int(sys.argv[1])
		if isinstance(ws_port, (long, int)):
			print "Aplicacao "+sys.argv[0]+" subindo na porta "+str(ws_port)
			httpd(ws_port)
		else:
			print "Erro: Porta invalida "+sys.argv[1]
			sys.exit(1)
	else:
		print "Aplicacao "+sys.argv[0]+" subindo na porta "+str(ws_port)
		httpd(ws_port)
