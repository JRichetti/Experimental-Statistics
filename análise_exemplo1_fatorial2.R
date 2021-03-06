# obter endere�o do caminho da pasta #
getwd() 
#
# setar diretorio de trabalho #
setwd("C:/Users/Willyan Becker/Dropbox/1. 2. Mestrado Becker/Estat�stica Experimental/Rotinas") 
#
# obter endere�o do caminho da pasta #
getwd()
#
dados <- read.table("dados1_fatorial.txt", header = T)   ## lendo um conjunto de dados em txt, header = T tem nome das colunas na 1� linha ##
dados
#
# Fixar dados #
attach(dados)
#
#
# AN�LISE DESCRITIVA #
# Resumno Descritivo Geral #
summary(etanol)
#
# Desvio padr�o Geral #
sd(etanol)
#
# Variancia Geral #
var(etanol)
#
# Informa��o de que a quantidade de a��car � um fator #
a�ucar <- as.factor(a�ucar)      
#
# Informa��o de que a adi��o de nutriente � um fator #
nutriente <- as.factor(nutriente) 
#
# Resumo descritivo do etanol, pelo fator nutriente #
tapply(etanol, nutriente, summary)  
#
# Resumo descritivo do etanol, pelo fator a��car #
tapply(etanol, a�ucar, summary)
#
# M�dia do etanol, para cada tratamento #
mean1 <- tapply(etanol, list(a�ucar,nutriente), mean)
mean1
#
# Gr�fico em colunas para an�lise da intera��o #
barplot(mean1, beside=T, leg = T)
barplot(mean1, beside=T, leg = T, ylim = c(0,45))
barplot(mean1, beside=T, leg = T, ylim = c(0,45), xlab = "Adi��o de nutriente")
#
# M�dia do etanol, para cada tratamento #
mean2 <- tapply(etanol, list(nutriente,a�ucar), mean)
mean2
#
# Gr�fico em colunas para an�lise da intera��o #
barplot(mean2, beside=T, leg = T, ylim = c(0,45), xlab = "Porcentagem de A��car")
#
#
# Abre uma janela gr�fica com espa�o para 2 gr�ficos #
par(mfrow = c(1,2))     
barplot(mean1, beside=T, leg = T, ylim = c(0,45), xlab = "Adi��o de nutriente")
barplot(mean2, beside=T, leg = T, ylim = c(0,45), xlab = "Porcentagem de A��car")
#
#
# Boxplot #
boxplot(etanol ~ a�ucar, xlab = "Quantidade de A��car", ylab = "Concentra��o de Etanol")
boxplot(etanol ~ nutriente, xlab = "Adi��o de Nutriente", ylab = "Concentra��o de Etanol")
#
# GR�FICOS DE INTERA��O #
interaction.plot(a�ucar, nutriente, etanol)
interaction.plot(nutriente, a�ucar, etanol)
#
# AN�LISE DE VARI�NCIA E COMPARA��O DE M�DIAS #
# Instale o pacote "laercio" #
#
# Informa��o de que a quantidade de a��car � um fator #
a�ucar <- as.factor(a�ucar) 
# Informa��o de que a adi��o de nutriente � um fator #
nutriente <- as.factor(nutriente) 
#
# C�lculo da an�lise de vari�ncia #
anv <- aov(etanol ~ a�ucar + nutriente + a�ucar:nutriente)  
summary(anv)
anova(anv)
#
# Calcula as m�dias por fator e por tratamento #
model.tables(anv, type = "means")       
#
# Elementos que podem ser explorados em aov #
names(anv)       
#
anv$coef
#
# Chamar pacote laercio #
require(laercio)
# Teste Tukey, default = 5%, com pacote "laercio" #
LTukey(anv)                         
# Teste Tukey, alfa = 1% #
LTukey(anv, conf.level = 0.99)      
#
par(mfrow=c(2,2))
#
# Tabelas das m�dias #
model.tables(anv, ty="means")    
#
#
# NO PACOTE ExpDes ##
# fat2.crd(fator1, fator2, resp, quali = c(TRUE, TRUE), mcomp = "tukey", fac.names = c("F1", "F2"), sigT = 0.05, sigF = 0.05)
#
require(ExpDes)
fat2.crd(a�ucar, nutriente, etanol, quali = c(TRUE, TRUE), mcomp = "tukey", fac.names = c("A�ucar", "Nutriente"), sigT = 0.05, sigF = 0.05)
#
# FIM #