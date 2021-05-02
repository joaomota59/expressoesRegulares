#Site que pode testar expressoes regulares em um texto: https://regex101.com/
use strict;

#my $arquivo = '2020.2-poesias_machado_de_assis.txt';
my $arquivo = '2020.2-poesias_machado_de_assis.txt'; #diretorio do arquivo txt

open(my $fh, "<" ,$arquivo) #abrir o arquivo txt no modo leitura '<'
  or die "Nao foi possivel abrir o arquivo!\n";

my $texto="";
my $tamanhoTotalDoTexto = 0;#tamanho total do Texto com titulo, linhas em braco e versos
my $linhasEmBranco = 0;#numero de linhas me branco no texto
my $somaVersos = 0;#guarda a soma de todos os tamanhos dos versos
my $estrofes="";#guarda somente as estrofes
while (my $linha = <$fh>){
    $texto="$texto$linha";#quarda todo texto do arquivo em uma variavel
    $tamanhoTotalDoTexto++;
    if ($linha eq "\n"){#se a linha for estiver em branco
      $linhasEmBranco++;
    }
    elsif (!($linha eq (uc $linha) || $linha eq "A ARTHUR DE OLIVEIRA, Enfermo\n")){ #se for diferente de algum titulo, entao é verso
      my $tamanhoVerso = length($linha);#tamanho do verso
      $somaVersos += $tamanhoVerso - 1;# -1 pq nao conta com o \n de cada verso
    } 

    if ($linha eq "\n" || !($linha eq (uc $linha) || $linha eq "A ARTHUR DE OLIVEIRA, Enfermo\n")){#pode ser verso ou linha em branco
      $estrofes = "$estrofes$linha";
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

###############


###ESTROFE-SEXTILHA###

my $countEstrofesSextilha = () = $texto =~ /(?=(\n\n[^\n]+\n[^\n]+\n[^\n]+\n[^\n]+\n[^\n]+\n[^\n]+\n\n))/g;#uso do lookaround ?= para pegar elementos com interseção de matches 

print "Numero de estrofes sextilha: $countEstrofesSextilha\n";

######################


######SONETOS########

my $countSonetos = () = $texto =~ /\n\n\n[^\n]+\n[^\n]+\n[^\n]+\n[^\n]+\n\n[^\n]+\n[^\n]+\n[^\n]+\n[^\n]+\n\n[^\n]+\n[^\n]+\n[^\n]+\n\n[^\n]+\n[^\n]+\n[^\n]+\n\n\n/g;

print "Numero de sonetos: $countSonetos\n";

####################


#####TamanhoMédioDosVersos###

my $tamMedioDeVersos = $somaVersos/$countVersos;

print "Tamanho medio dos versos: $tamMedioDeVersos\n";

#############################


###TamanhoMédioDasEstrofes###


#my @matchesEstrofes = ($texto =~ /(\n\n((([^\n]+\n)+\n)+\n\n\n))/g);


#print @vetorTexto;

my @splEstrofesPorPoema = split('\n\n\n\n\n\n', $estrofes);#coloca cada estrofe em uma posição do vetor // será usado no tam medio dos poemas!!!


$estrofes =~ s/\n\n\n\n\n\n/\n/g;#replace onde tem 6 \n seguidos troca p apenas um \n
#agora o espaçamento entre cada estrofe se diferencia apenas por \n\n


my @spl = split('\n\n', $estrofes);#coloca cada estrofe em uma posição do vetor


my $somatorioDeEstrofes = -1; #Guarda a quantidade total do tamanho de cada estrofe, -1 pq na primeira linha do vetor tem um \n que não é uma estrofe
foreach my $i (@spl)#percorre o vetor de estrofes 
{

    my $c = () = $i =~ /(?=(\n))/g;#quantidade de versos em cada estrofe, conta toda vez que ocorre quebra de linha
    $c++;#soma mais 1 pq o ultimo verso da estrofe n tem\n devio ao split q foi feito antes
    $somatorioDeEstrofes+=$c;
    #print "$c\n";#printa o tamanho de cada estrofe no arquivo
}

my $tamMedioDeEstrofes = $somatorioDeEstrofes/$countEstrofes;
print "Tamanho medio das estrofes: $tamMedioDeEstrofes\n";
#############################




######TamanhoMédioDosPoemas######

my $tamMedioDasPoesias = $countVersos/$countPoemas;

print "Tamanho medio das poesias: $tamMedioDasPoesias";

################################