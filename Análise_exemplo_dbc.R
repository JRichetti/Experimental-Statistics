# Obter endereço do caminho da pasta #
getwd() 

# Setar diretorio de trabalho #
setwd("C:/Users/Willyan Becker/Dropbox/1. 2. Mestrado Becker/Estatística Experimental/Rotinas") 

# Obter endereço do caminho da pasta #
getwd() 


# Lendo um conjunto de dados em txt, header = T tem nome das colunas na 1ª linha #
dados <- read.table("dados_dbc.txt", header = T)   
dados

# Fixar dados #
attach(dados)


# ANÁLISE DESCRITIVA #
# Resumo descritivo geral #
summary(Nota)  

# Desvio padrão geral #
sd(Nota) 

# Variância geral #
var(Nota)        

(sd(Nota)/mean(Nota))*100

boxplot(Nota ~ Marca, xlab = "Marca", ylab = "Nota (1 a 8)")

boxplot(Nota ~ Bloco, xlab = "Bloco", ylab = "Nota (1 a 8)")


# ANÁLISE DE VARIÂNCIA E COMPARAÇÃO DE MÉDIAS #
# instale o pacote "laercio" #

Marca <- as.factor(Marca)       # informação de que a marca é um fator #
Bloco <- as.factor(Bloco)       # informação de que a bloco é um fator #

anv <- aov(Nota ~ Marca + Bloco)  # cálculo da análise de variância #
anova(anv)                        # demonstrativo da Tabela ANOVA #

anv1 <- aov(Nota ~ Marca)  # cálculo da análise de variância #
anova(anv1)                # demonstrativo da Tabela ANOVA #


require(laercio)                            # pacote laercio #
LTukey(anv,"Marca")                         # teste Tukey, default = 5%, com pacote "laercio" #
LTukey(anv,"Marca", conf.level = 0.99)      # teste Tukey, alfa = 1% #


# ANÁLISE COM O PACOTE "ExpDes" #
# rbd(trat, bloco, resp, quali = TRUE, mcomp = "tukey", sigT = 0.05, sigF = 0.05) #
require(ExpDes)
rbd(Marca, Bloco, Nota, quali = TRUE, mcomp='tukey', sigT = 0.05, sigF = 0.05)
rbd(Marca, Bloco, Nota, quali = TRUE, mcomp='tukey', sigT = 0.01, sigF = 0.01)

