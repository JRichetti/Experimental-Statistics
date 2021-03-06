# obter endere�o do caminho da pasta #
getwd() 
#
# setar diretorio de trabalho #
setwd("C:/Users/Willyan Becker/Dropbox/1. 2. Mestrado Becker/Estat�stica Experimental/Rotinas") 
#
# obter endere�o do caminho da pasta #
getwd()
#
dados <- read.table("dados_trifatorial.txt", header = T)   ## lendo um conjunto de dados em txt, header = T tem nome das colunas na 1� linha ##
dados
#
attach(dados)
# AN�LISE DESCRITIVA #
#
adub <- as.factor(adubacao)       
var <- as.factor(variedade)  
esp <- as.factor(espacamento)

## resumo descritivo para cada fator ##
tapply(acidez, adub, summary)  
tapply(acidez, var, summary)  
tapply(acidez, esp, summary)  


## m�dia do etanol, para cada tratamento ##
mean1 <- tapply(acidez, list(var,adub,esp), mean)
mean1

## m�dia do etanol, para cada tratamento ##
mean2 <- tapply(acidez, list(adub,var,esp), mean)
mean2

## m�dia do etanol, para cada tratamento ##
mean3 <- tapply(acidez, list(esp,var,adub), mean)
mean3


## boxplot ##
par(mfrow = c(1,3))  
boxplot(acidez ~ var, xlab = "Variedade", ylab = "Acidez") 
boxplot(acidez ~ esp, xlab = "Espa�amento", ylab = "Acidez") 
boxplot(acidez ~ adub, xlab = "Aduba��o", ylab = "Acidez") 

## GR�FICOS DE INTERA��O ##

interaction.plot(adub, esp, acidez)
interaction.plot(esp, adub, acidez)

interaction.plot(adub, var, acidez)
interaction.plot(var, adub, acidez)

interaction.plot(var, esp, acidez)
interaction.plot(esp, var, acidez)


## AN�LISE DE VARI�NCIA E COMPARA��O DE M�DIAS ##
## instale o pacote "laercio" ##

anv <- aov(acidez ~ var + esp + adub + var:esp + var:adub + esp:adub + esp:var:adub)  ## c�lculo da an�lise de vari�ncia ##
summary(anv)


## NO PACOTE ExpDes ##

require(ExpDes)
fat3.crd(var, esp, adub, acidez, quali = c(TRUE, TRUE, TRUE), mcomp = "tukey", fac.names = c("Variedade", "Espa�amento", "Aduba��o"), sigT = 0.05, sigF = 0.05)



## 2� EXEMPLO ##

dados1 <- read.table("dados2_fatorial.txt", header = T)   ## lendo um conjunto de dados em txt, header = T tem nome das colunas na 1� linha ##
dados1

attach(dados1)

require(ExpDes)
fat2.rbd(Admine, Adorg, Bloco, Rend, quali = c(TRUE, TRUE), mcomp = "tukey", 
fac.names = c("Mineral", "Organico"), sigT = 0.05, sigF = 0.05)

