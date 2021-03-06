# obter endere�o do caminho da pasta #
getwd() 
#
# setar diretorio de trabalho #
setwd("C:/Users/Willyan Becker/Dropbox/1. 2. Mestrado Becker/Estat�stica Experimental/Rotinas") 
#
# obter endere�o do caminho da pasta #
getwd()
#
dados <- read.table("dados2_fatorial.txt", header = T)   ## lendo um conjunto de dados em txt, header = T tem nome das colunas na 1� linha ##
dados
#
attach(dados)
# AN�LISE DESCRITIVA #
#
# Informa��o de que a quantidade de a��car � um fator #
Admine <- as.factor(Admine)
# Informa��o de que a adi��o de nutriente � um fator #
Adorg <- as.factor(Adorg) 
Bloco <- as.factor(Bloco)
#
# GR�FICOS DE INTERA��O #
interaction.plot(Admine, Adorg, Rend)
interaction.plot(Adorg, Admine, Rend)
#
# AN�LISE DE VARI�NCIA E COMPARA��O DE M�DIAS #
# Instale o pacote "laercio" #
#
# C�lculo da an�lise de vari�ncia #
anv <- aov(Rend ~ Admine + Adorg + Admine*Adorg + Bloco)  
summary(anv)
anova(anv)
#
require(ExpDes)
fat2.rbd(Admine, Adorg, Bloco, Rend, quali = c(TRUE, TRUE), mcomp = "tukey", 
fac.names = c("Mineral", "Organico"), sigT = 0.05, sigF = 0.05)
#
# Em ingl�s: fat2.rbd #

