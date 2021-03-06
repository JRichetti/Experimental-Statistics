dados <- read.table("ex3_dbc.txt", header = T)   ## lendo um conjunto de dados em txt, header = T tem nome das colunas na 1� linha ##
dados

attach(dados)

## AN�LISE DESCRITIVA ##

summary(resp)   ## resumo descritivo geral ##
sd(resp)        ## desvio padr�o geral ##
var(resp)        ## vari�ncia geral ##

(sd(resp)/mean(resp))*100

boxplot(resp ~ trat, xlab = "Marca", ylab = "")

boxplot(resp ~ blo, xlab = "Bloco", ylab = "")

## AN�LISE DA INTERA��O ENTRE TRATAMENTOS E BLOCO ##

interaction.plot(trat, blo, resp, xlab = "Tratamentos", ylab = "M�dia da var. resposta")
interaction.plot(blo, trat, resp, xlab = "Blocos", ylab = "M�dia da var. resp")

trat <- as.factor(trat)
blo <- as.factor(blo)

av <- aov(resp ~ trat + blo + trat*blo)     ## no lugar de * pode ser usado : ##

summary(av)

## AN�LISE DE VARI�NCIA E COMPARA��O DE M�DIAS ##
## instale o pacote "laercio" ##

## rbd(trat, bloco, resp, quali = TRUE, mcomp = "tukey", sigT = 0.05, sigF = 0.05)

require(ExpDes)
rbd(trat, blo, resp, quali = TRUE, mcomp='tukey', sigT = 0.05, sigF = 0.05)

