## OPERAÇÕES MATEMÁTICAS ##

2+3
2-6
8*7
20/10
100^3

sqrt(64)       ## raíz quadrada ##
exp(1)         ## exponencial ##
log(2)         ## logaritmo natural ##

help(log)     ## Fazer pesquisa sobre um comando, ele apresenta como usar ##
?log          ## Mesmo que o anterior ##

log10(100)   ## logaritmo na base 10 ##

log2(8)      ## logaritmo na base 2 ##

log(27, base = 3) ## logaritmo com qualquer base, ou log(27,3) ##

help(sin)

sin(pi/2)           ## seno de um ângulo, em radianos (não em graus) ##    
cos(pi/2)
tan(pi)


## OBJETOS ##

s <- 10   ## colocou-se nº 10 num objeto chamado de s, usando o operador <- ##
s

s-4

a <- 2*9
a

x <- banana   ## vai haver um erro, p/ armazenar palavras, devemos colocá-las entre " ##
x

x <- "banana"
x

a + s    ## operações entre dois (ou mais) objetos ## 


## SEQUENCIAS DE VALORES: VETORES ##

a <- 1:10   ## sequência de valores inteiros, do 1 ao 10, variando de 1 em 1 ##
a
b <- -5:5
b
c <- 5:-5
c

## dimensão (comprimento) de um vetor ##

length(c)

## podemos operacionalizar vetores com mesma dimensão ##

b + (2*c)   

d <- seq(0,20, by = 2)        ## comando sequencia com espaçamento 2 ##
d

e <- seq(0,20, by = 0.5)     ## usa-se ponto para nº decimal ##
e

f <- seq(0,20, length.out = 8)   ## sequencia com 8 elementos ##
f

## vetor com elementos pré-definidos ##

x <- c(1,0,-2,3,4,6,10)       ## que podem ser nº's ##  
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


## seleção de elementos de um vetor, com uma determinada posição ##

x[2]                   ## qual é o 2º elemento do vetor x? ##
x[1:4]                 ## qual é o vetor de elementos do vetor x, do 1º ao 4º? ##
x[c(1,3,5)]

## REPETIÇÕES ##

## repetição do nº 2, 20 vezes ##

a <- rep(2,20) 
a

## repetição de 26 células, sem nenhum elemento ##

b <- rep(NA, 26)
b

## repetição da sequência de nº's 1,2,3,4, cada nº sendo repetido 2 vezes ##

rep(1:4, each = 2)

## repetição da sequência de nº's 1,2,3,4, duas vezes ##

rep(1:4, 2)

## repetição da sequência de nº's 1,2,3,4, cada nº sendo repetido 2 vezes, ##
## e essa repetição, realizada 3 vezes ##

rep(1:4, each = 2, 3)


## MATRIZES ##

k <- seq(1:16)
k

## matriz com os elementos de k, com 4 colunas e linhas ##

z <- matrix(k, ncol = 4, nrow = 4)
z

## matriz com os elementos de k, com 4 colunas e linhas ##
## sendo que os elementos são distribuídos por linhas ##

w <- matrix(k, ncol = 4, nrow = 4, byrow = T)
w

## seleção de um elemento na matrix w ##

w[1,3]        ## na posição: 1ª linha, 3ª coluna ##
w[2,]         ## elementos da 2ª linha ##
w[,4]         ## elementos da 4ª coluna ##

## dimensão de uma matriz ##

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

## banco de dados disponível no R ##

data(iris)         ## "chama" o banco de dados ##

iris

help(iris)         ## informações sobre esse banco de dados ##

dados <- iris[1:10,]   ## parte de um banco de dados ##
dados

names(dados)           ## nome das variáveis ##

## seleção de uma variável ##

dados[,3]

dados$Petal.Length     ## escolha de uma variável ##

## seleção de amostras com uma determinada condição ##

iris[iris$Sepal.Length > 6,]      ## amostras c/ tamanho de sépala maior que 6 ##

iris[iris$Species == "virginica",]      ## amostras da espécie virginica ##

## criar um banco de dados em bloco de notas ##
## mude diretório em: Arquivo - Muda dir ##

## sem nome na 1ª linha ##
dados1 <- read.table("Banco_Dados_dadosaula1.txt")   ## lendo um conjunto de dados em txt ##
dados1

nomes <- c("Aluno", "Nota", "Frequência", "Idade")
nomes

dados1 <- read.table("Banco_Dados_dadosaula1.txt", col.names = nomes)   ## atribuição de nomes para as variáveis no conjunto de dados ##
dados1

## com nome na 1ª linha ##

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

