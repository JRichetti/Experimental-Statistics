# obter endereço do caminho da pasta #
getwd() 
#
# setar diretorio de trabalho #
setwd("C:/Users/Willyan Becker/Dropbox/1. 2. Mestrado Becker/Estatística Experimental/Rotinas") 
#
# obter endereço do caminho da pasta #
getwd()
#
dados <- read.table("dados1_fatorial.txt", header = T)   ## lendo um conjunto de dados em txt, header = T tem nome das colunas na 1ª linha ##
dados
#
# Fixar dados #
attach(dados)
#
#
# ANÁLISE DESCRITIVA #
# Resumno Descritivo Geral #
summary(etanol)
#
# Desvio padrão Geral #
sd(etanol)
#
# Variancia Geral #
var(etanol)
#
# Informação de que a quantidade de açúcar é um fator #
açucar <- as.factor(açucar)      
#
# Informação de que a adição de nutriente é um fator #
nutriente <- as.factor(nutriente) 
#
# Resumo descritivo do etanol, pelo fator nutriente #
tapply(etanol, nutriente, summary)  
#
# Resumo descritivo do etanol, pelo fator açúcar #
tapply(etanol, açucar, summary)
#
# Média do etanol, para cada tratamento #
mean1 <- tapply(etanol, list(açucar,nutriente), mean)
mean1
#
# Gráfico em colunas para análise da interação #
barplot(mean1, beside=T, leg = T)
barplot(mean1, beside=T, leg = T, ylim = c(0,45))
barplot(mean1, beside=T, leg = T, ylim = c(0,45), xlab = "Adição de nutriente")
#
# Média do etanol, para cada tratamento #
mean2 <- tapply(etanol, list(nutriente,açucar), mean)
mean2
#
# Gráfico em colunas para análise da interação #
barplot(mean2, beside=T, leg = T, ylim = c(0,45), xlab = "Porcentagem de Açúcar")
#
#
# Abre uma janela gráfica com espaço para 2 gráficos #
par(mfrow = c(1,2))     
barplot(mean1, beside=T, leg = T, ylim = c(0,45), xlab = "Adição de nutriente")
barplot(mean2, beside=T, leg = T, ylim = c(0,45), xlab = "Porcentagem de Açúcar")
#
#
# Boxplot #
boxplot(etanol ~ açucar, xlab = "Quantidade de Açúcar", ylab = "Concentração de Etanol")
boxplot(etanol ~ nutriente, xlab = "Adição de Nutriente", ylab = "Concentração de Etanol")
#
# GRÁFICOS DE INTERAÇÃO #
interaction.plot(açucar, nutriente, etanol)
interaction.plot(nutriente, açucar, etanol)
#
# ANÁLISE DE VARIÂNCIA E COMPARAÇÃO DE MÉDIAS #
# Instale o pacote "laercio" #
#
# Informação de que a quantidade de açúcar é um fator #
açucar <- as.factor(açucar) 
# Informação de que a adição de nutriente é um fator #
nutriente <- as.factor(nutriente) 
#
# Cálculo da análise de variância #
anv <- aov(etanol ~ açucar + nutriente + açucar:nutriente)  
summary(anv)
anova(anv)
#
# Calcula as médias por fator e por tratamento #
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
# Tabelas das médias #
model.tables(anv, ty="means")    
#
#
# NO PACOTE ExpDes ##
# fat2.crd(fator1, fator2, resp, quali = c(TRUE, TRUE), mcomp = "tukey", fac.names = c("F1", "F2"), sigT = 0.05, sigF = 0.05)
#
require(ExpDes)
fat2.crd(açucar, nutriente, etanol, quali = c(TRUE, TRUE), mcomp = "tukey", fac.names = c("Açucar", "Nutriente"), sigT = 0.05, sigF = 0.05)
#
# FIM #