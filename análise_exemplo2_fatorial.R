# obter endereço do caminho da pasta #
getwd() 
#
# setar diretorio de trabalho #
setwd("C:/Users/Willyan Becker/Dropbox/1. 2. Mestrado Becker/Estatística Experimental/Rotinas") 
#
# obter endereço do caminho da pasta #
getwd()
#
dados <- read.table("dados2_fatorial.txt", header = T)   ## lendo um conjunto de dados em txt, header = T tem nome das colunas na 1ª linha ##
dados
#
attach(dados)
# ANÁLISE DESCRITIVA #
#
# Informação de que a quantidade de açúcar é um fator #
Admine <- as.factor(Admine)
# Informação de que a adição de nutriente é um fator #
Adorg <- as.factor(Adorg) 
Bloco <- as.factor(Bloco)
#
# GRÁFICOS DE INTERAÇÃO #
interaction.plot(Admine, Adorg, Rend)
interaction.plot(Adorg, Admine, Rend)
#
# ANÁLISE DE VARIÂNCIA E COMPARAÇÃO DE MÉDIAS #
# Instale o pacote "laercio" #
#
# Cálculo da análise de variância #
anv <- aov(Rend ~ Admine + Adorg + Admine*Adorg + Bloco)  
summary(anv)
anova(anv)
#
require(ExpDes)
fat2.rbd(Admine, Adorg, Bloco, Rend, quali = c(TRUE, TRUE), mcomp = "tukey", 
fac.names = c("Mineral", "Organico"), sigT = 0.05, sigF = 0.05)
#
# Em inglês: fat2.rbd #

