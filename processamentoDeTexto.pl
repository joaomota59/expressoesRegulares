use strict;

my $arquivo = '2020.2-poesias_machado_de_assis.txt';

open(my $fh, '<:encoding(UTF-8)', $arquivo) 
|| die "Não foi possível abrir o arquivo '$arquivo' $!";

while (my $linha = <$fh>){
    chomp $linha;
    print "$linha\n";
}

