dados <- read.table("ex3_dbc.txt", header = T)   ## lendo um conjunto de dados em txt, header = T tem nome das colunas na 1ª linha ##
dados

attach(dados)

## ANÁLISE DESCRITIVA ##

summary(resp)   ## resumo descritivo geral ##
sd(resp)        ## desvio padrão geral ##
var(resp)        ## variância geral ##

(sd(resp)/mean(resp))*100

boxplot(resp ~ trat, xlab = "Marca", ylab = "")

boxplot(resp ~ blo, xlab = "Bloco", ylab = "")

## ANÁLISE DA INTERAÇÃO ENTRE TRATAMENTOS E BLOCO ##

interaction.plot(trat, blo, resp, xlab = "Tratamentos", ylab = "Média da var. resposta")
interaction.plot(blo, trat, resp, xlab = "Blocos", ylab = "Média da var. resp")

trat <- as.factor(trat)
blo <- as.factor(blo)

av <- aov(resp ~ trat + blo + trat*blo)     ## no lugar de * pode ser usado : ##

summary(av)

## ANÁLISE DE VARIÂNCIA E COMPARAÇÃO DE MÉDIAS ##
## instale o pacote "laercio" ##

## rbd(trat, bloco, resp, quali = TRUE, mcomp = "tukey", sigT = 0.05, sigF = 0.05)

require(ExpDes)
rbd(trat, blo, resp, quali = TRUE, mcomp='tukey', sigT = 0.05, sigF = 0.05)

