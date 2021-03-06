# Obter endere�o do caminho da pasta #
getwd() 

# Setar diretorio de trabalho #
setwd("C:/Users/Willyan Becker/Dropbox/1. 2. Mestrado Becker/Estat�stica Experimental/Rotinas") 

# Obter endere�o do caminho da pasta #
getwd() 


# Lendo um conjunto de dados em txt, header = T tem nome das colunas na 1� linha #
dados <- read.table("dados_dbc.txt", header = T)   
dados

# Fixar dados #
attach(dados)


# AN�LISE DESCRITIVA #
# Resumo descritivo geral #
summary(Nota)  

# Desvio padr�o geral #
sd(Nota) 

# Vari�ncia geral #
var(Nota)        

(sd(Nota)/mean(Nota))*100

boxplot(Nota ~ Marca, xlab = "Marca", ylab = "Nota (1 a 8)")

boxplot(Nota ~ Bloco, xlab = "Bloco", ylab = "Nota (1 a 8)")


# AN�LISE DE VARI�NCIA E COMPARA��O DE M�DIAS #
# instale o pacote "laercio" #

Marca <- as.factor(Marca)       # informa��o de que a marca � um fator #
Bloco <- as.factor(Bloco)       # informa��o de que a bloco � um fator #

anv <- aov(Nota ~ Marca + Bloco)  # c�lculo da an�lise de vari�ncia #
anova(anv)                        # demonstrativo da Tabela ANOVA #

anv1 <- aov(Nota ~ Marca)  # c�lculo da an�lise de vari�ncia #
anova(anv1)                # demonstrativo da Tabela ANOVA #


require(laercio)                            # pacote laercio #
LTukey(anv,"Marca")                         # teste Tukey, default = 5%, com pacote "laercio" #
LTukey(anv,"Marca", conf.level = 0.99)      # teste Tukey, alfa = 1% #


# AN�LISE COM O PACOTE "ExpDes" #
# rbd(trat, bloco, resp, quali = TRUE, mcomp = "tukey", sigT = 0.05, sigF = 0.05) #
require(ExpDes)
rbd(Marca, Bloco, Nota, quali = TRUE, mcomp='tukey', sigT = 0.05, sigF = 0.05)
rbd(Marca, Bloco, Nota, quali = TRUE, mcomp='tukey', sigT = 0.01, sigF = 0.01)

