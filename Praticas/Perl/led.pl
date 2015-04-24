#! /usr/bin/perl

use strict;
use warnings;

$SIG{INT}  = \&control_signal;
$SIG{TERM} = \&control_signal;


my $fh; 

# Exportando o GPIO17
open($fh, '>', '/sys/class/gpio/export');
print $fh "17";
close $fh;


# Setando a direcao do GPIO17 como OUTPUT
open($fh, '>', '/sys/class/gpio/gpio17/direction');
print $fh "out";
close $fh;


print "PISCA-LED GPIO17 OUTPUT COM PERL\n";


# LOOP PISCA-LED
my $led;
while (1){
	open($led, '>', '/sys/class/gpio/gpio17/value');
	print $led "1";
	close $led;
	print "LED LIGADO\n";
	sleep(2);
	open($led, '>', '/sys/class/gpio/gpio17/value');
	print $led "0";
	close $led;
	print "LED DESLIGADO\n";
	sleep(2);
}


# EVENTO QUE CAPTURA SINGAL DE CTRL+C E ENCERRA APLICACAO
sub control_signal {
	print "Sinal recebido, aguarde...";

	open($fh, '>', '/sys/class/gpio/unexport');
	print $fh "17";
	close $fh;
	exit 0;

}
