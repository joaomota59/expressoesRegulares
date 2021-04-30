#Site que pode testar expressoes regulares em um texto: https://regex101.com/
use strict;

#my $arquivo = '2020.2-poesias_machado_de_assis.txt';
my $arquivo = '2020.2-poesias_machado_de_assis.txt'; #diretorio do arquivo txt

open(my $fh, "<" ,$arquivo) #abrir o arquivo txt no modo leitura '<'
  or die "Nao foi possivel abrir o arquivo!\n";

my $texto="";
while (my $linha = <$fh>){
    $texto="$texto$linha";#quarda todo texto do arquivo em uma variavel 
}

#print $texto; #mostra o texto do arquivo lido

close ($arquivo);#Fecha arquivo txt


my @matches = ($texto =~ /[\w][\n]{3}[\w]/g); #pega todas ocorrencias da expressao regular no texto
my $countPoemas = () = $texto =~ /[\w][\n]{3}[\w]/g;


print @matches; #mostra todas as ocorrencias da expressao regular encontrada no texto

my $string_len = length(@matches);

print "Numero total de poemas: $countPoemas";