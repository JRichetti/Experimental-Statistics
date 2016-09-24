# obter endereço do caminho da pasta #
getwd() 

# setar diretorio de trabalho #
setwd("C:/Users/Willyan Becker/Dropbox/1. 2. Mestrado Becker/Estatística Experimental/Rotinas") 

# obter endereço do caminho da pasta #
getwd() 

# lendo um conjunto de dados em txt, header = T tem nome das colunas na 1ª linha #
dados <- read.table("exemplo_dic.txt", header = T)   
dados

# Contrastes # 
# CapimA + CapimB - CapimC - CapimD #
# CapimA - CapimB #
# CapimC - CapimD #

# Fixar Dados #
attach(dados)

# Colocando todos os contrastes juntos #
con1 <- matrix(c(1,1,-1,-1,1,-1,0,0,0,0,1,-1), nrow = 4, ncol = 3)
con1

esp <- as.factor(esp)       ## informação de que a espécie é um fator #

contrasts(esp) <- con1
contrasts(esp)

anv <- aov(prod ~ esp)  ## cálculo da análise de variância ##
anova(anv) 

# Sumario anova #
summary.aov(anv, split=list("esp"=list("c1" = 1, "c2" = 2, "c3" = 3)))

# teste t - contraste #
require(gregmisc)
(C = rbind("(A+B) vs (C+D)" = c(1, 1, -1, -1),
           "A vs B"  = c(1, -1,  0, 0),
           "C vs D"          = c(0, 0, 1, -1)))
fit.contrast(anv, "esp", C, conf=0.95 )


# Teste de Scheffé - só implementado "duas a duas" #

require(agricolae)
teste.scheffe=scheffe.test(anv, "esp", main="")
teste.scheffe

