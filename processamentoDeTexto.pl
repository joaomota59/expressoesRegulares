#Site que pode testar expressoes regulares em um texto: https://regex101.com/
use strict;

#my $arquivo = '2020.2-poesias_machado_de_assis.txt';
my $arquivo = '2020.2-poesias_machado_de_assis.txt'; #diretorio do arquivo txt

open(my $fh, "<" ,$arquivo) #abrir o arquivo txt no modo leitura '<'
  or die "Nao foi possivel abrir o arquivo!\n";

my $texto="";
my $tamanhoTotalDoTexto = 0;
my $linhasEmBranco = 0;
while (my $linha = <$fh>){
    $texto="$texto$linha";#quarda todo texto do arquivo em uma variavel
    $tamanhoTotalDoTexto++;
    if ($linha eq "\n"){#se a linha for estiver em branco
      $linhasEmBranco++;

    } 

}

#print $texto; #mostra o texto do arquivo lido

close ($arquivo);#Fecha arquivo txt

###Informações do arquivo###
#print "Tamanho total: $tamanhoTotalDoTexto\n";
#print "Linhas em Branco: $linhasEmBranco\n";
###########################

#####POEMAS#####

#my @matchesPoemas = ($texto =~ /(]|[\w])[\n]{3}[\w]/g); #pega todas ocorrencias da expressao regular no texto
my $countPoemas = () = $texto =~ /(]|[A-zÀ-ú)0-9])[\n]{3}[A-ZÀ-Ú]/g;
#print @matchesPoemas; #mostra todas as ocorrencias da expressao regular encontrada no texto
print "Numero total de poemas: $countPoemas\n";

################


#####VERSOS####

#my $countVersos = () = $texto =~ /([a-z\W]\[\d{2}\]|[,?.!a-z:;_»)-])[\n]/g; #errado
my $countVersos = $tamanhoTotalDoTexto - $linhasEmBranco - $countPoemas - 1;
#o -1 no final é a linha do poema Antônio José (21 DE OUTUBRO DE 1739) que está separada do titulo, porém não
#é um verso!!!
print "Numero total de versos: $countVersos\n";

##############



####ESTROFES###

my $countEstrofes = () = $texto =~ /([a-z.,;:?!»_]\[\d{2}\]|[a-z.,;:?!»_])[\n][\n]/g;

$countEstrofes = $countEstrofes -1 + 1;#retira da busca o titulo: A ARTHUR DE OLIVEIRA, Enfermo e acrescenta a ultima esfrofe que n foi contada

print "Numero total de estrofes: $countEstrofes\n";