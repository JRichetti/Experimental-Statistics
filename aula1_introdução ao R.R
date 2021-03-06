## OPERA��ES MATEM�TICAS ##

2+3
2-6
8*7
20/10
100^3

sqrt(64)       ## ra�z quadrada ##
exp(1)         ## exponencial ##
log(2)         ## logaritmo natural ##

help(log)     ## Fazer pesquisa sobre um comando, ele apresenta como usar ##
?log          ## Mesmo que o anterior ##

log10(100)   ## logaritmo na base 10 ##

log2(8)      ## logaritmo na base 2 ##

log(27, base = 3) ## logaritmo com qualquer base, ou log(27,3) ##

help(sin)

sin(pi/2)           ## seno de um �ngulo, em radianos (n�o em graus) ##    
cos(pi/2)
tan(pi)


## OBJETOS ##

s <- 10   ## colocou-se n� 10 num objeto chamado de s, usando o operador <- ##
s

s-4

a <- 2*9
a

x <- banana   ## vai haver um erro, p/ armazenar palavras, devemos coloc�-las entre " ##
x

x <- "banana"
x

a + s    ## opera��es entre dois (ou mais) objetos ## 


## SEQUENCIAS DE VALORES: VETORES ##

a <- 1:10   ## sequ�ncia de valores inteiros, do 1 ao 10, variando de 1 em 1 ##
a
b <- -5:5
b
c <- 5:-5
c

## dimens�o (comprimento) de um vetor ##

length(c)

## podemos operacionalizar vetores com mesma dimens�o ##

b + (2*c)   

d <- seq(0,20, by = 2)        ## comando sequencia com espa�amento 2 ##
d

e <- seq(0,20, by = 0.5)     ## usa-se ponto para n� decimal ##
e

f <- seq(0,20, length.out = 8)   ## sequencia com 8 elementos ##
f

## vetor com elementos pr�-definidos ##

x <- c(1,0,-2,3,4,6,10)       ## que podem ser n�'s ##  
x

d <- c("Ana", "Carlos", "Juliana")    ## ou palavras ##
d

altura <- c(1.85, 1.6, 1.59, 1.3, 1.98)
peso <- c(56, 45, 85, 78, 100)

altura
peso

dados <- cbind(altura, peso)  ## junta em colunas ##
dados

dados1 <- rbind(altura, peso)  ## junta em linhas ##
dados1


## sele��o de elementos de um vetor, com uma determinada posi��o ##

x[2]                   ## qual � o 2� elemento do vetor x? ##
x[1:4]                 ## qual � o vetor de elementos do vetor x, do 1� ao 4�? ##
x[c(1,3,5)]

## REPETI��ES ##

## repeti��o do n� 2, 20 vezes ##

a <- rep(2,20) 
a

## repeti��o de 26 c�lulas, sem nenhum elemento ##

b <- rep(NA, 26)
b

## repeti��o da sequ�ncia de n�'s 1,2,3,4, cada n� sendo repetido 2 vezes ##

rep(1:4, each = 2)

## repeti��o da sequ�ncia de n�'s 1,2,3,4, duas vezes ##

rep(1:4, 2)

## repeti��o da sequ�ncia de n�'s 1,2,3,4, cada n� sendo repetido 2 vezes, ##
## e essa repeti��o, realizada 3 vezes ##

rep(1:4, each = 2, 3)


## MATRIZES ##

k <- seq(1:16)
k

## matriz com os elementos de k, com 4 colunas e linhas ##

z <- matrix(k, ncol = 4, nrow = 4)
z

## matriz com os elementos de k, com 4 colunas e linhas ##
## sendo que os elementos s�o distribu�dos por linhas ##

w <- matrix(k, ncol = 4, nrow = 4, byrow = T)
w

## sele��o de um elemento na matrix w ##

w[1,3]        ## na posi��o: 1� linha, 3� coluna ##
w[2,]         ## elementos da 2� linha ##
w[,4]         ## elementos da 4� coluna ##

## dimens�o de uma matriz ##

dim(w)

## determinante de uma matriz ##

c <- matrix(c(2,4,6,8), ncol = 2, nrow = 2)
c

det(c)

## matriz inversa ##

solve(c)

q <- matrix(c(0, 3, 7, 9), ncol = 2, nrow = 2)
q

c+q
c-q
2*c 

c%*%q ## produto das matrizes ##

## DATA FRAMES - TABELA DE DADOS OU BANCO DE DADOS ##

## banco de dados dispon�vel no R ##

data(iris)         ## "chama" o banco de dados ##

iris

help(iris)         ## informa��es sobre esse banco de dados ##

dados <- iris[1:10,]   ## parte de um banco de dados ##
dados

names(dados)           ## nome das vari�veis ##

## sele��o de uma vari�vel ##

dados[,3]

dados$Petal.Length     ## escolha de uma vari�vel ##

## sele��o de amostras com uma determinada condi��o ##

iris[iris$Sepal.Length > 6,]      ## amostras c/ tamanho de s�pala maior que 6 ##

iris[iris$Species == "virginica",]      ## amostras da esp�cie virginica ##

## criar um banco de dados em bloco de notas ##
## mude diret�rio em: Arquivo - Muda dir ##

## sem nome na 1� linha ##
dados1 <- read.table("Banco_Dados_dadosaula1.txt")   ## lendo um conjunto de dados em txt ##
dados1

nomes <- c("Aluno", "Nota", "Frequ�ncia", "Idade")
nomes

dados1 <- read.table("Banco_Dados_dadosaula1.txt", col.names = nomes)   ## atribui��o de nomes para as vari�veis no conjunto de dados ##
dados1

## com nome na 1� linha ##

dados2 <- read.table("Banco_Dados_dadosaula2.txt", header = T)   ## lendo um conjunto de dados em txt ##
dados2

## salvar uma tabela de dados num arquivo ##

c <- c(1,0,2,3)
d <- c(-1,-2,-3,-4)
e <- c(12,10,20,18)

dados <- c(c,d,e)
dados

write.table(dados,"dadosaula3.txt")
read.table("dadosaula3.txt")


dadoss <- cbind(c,d,e)
dadoss

write.table(dadoss,"dadosaula4.txt")
read.table("dadosaula4.txt")

