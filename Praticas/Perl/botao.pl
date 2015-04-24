#! /usr/bin/perl

use strict;
use warnings;

$SIG{INT}  = \&control_signal;
$SIG{TERM} = \&control_signal;


my $fh; 

# Exportando o GPIO18
open($fh, '>', '/sys/class/gpio/export');
print $fh "18";
close $fh;


# Setando a direcao do GPIO18 como INPUT
open($fh, '>', '/sys/class/gpio/gpio18/direction');
print $fh "in";
close $fh;


print "LENDO BOTAO GPIO18 COM PERL\n\n";



my $valor_botao;

# LOOP LEITURA BOTAO
while (1){
	open FDIN, "</sys/class/gpio/gpio18/value" or die $!;
	$valor_botao = <FDIN>;
	if($valor_botao == "0") {
		print "BOTAO ACIONADO\n";
	}
	close FDIN;
	sleep(1);
}



# EVENTO QUE CAPTURA SINGAL DE CTRL+C E ENCERRA APLICACAO
sub control_signal {
	print "Sinal recebido, aguarde...";

	open($fh, '>', '/sys/class/gpio/unexport');
	print $fh "18";
	close $fh;
	exit 0;

}
