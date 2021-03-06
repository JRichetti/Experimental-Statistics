# obter endere�o do caminho da pasta #
getwd() 

# setar diretorio de trabalho #
setwd("C:/Users/Willyan Becker/Dropbox/1. 2. Mestrado Becker/Estat�stica Experimental/Rotinas") 

# lendo um conjunto de dados em txt, header = T tem nome das colunas na 1� linha #
dados <- read.table("Exemplo_Dic.txt", header = T)   

# Mostrar dados #
dados

# Fixar a tabela "dados" , para poder chamar as variaveis apenas pelos nomes #
attach(dados)      
 
# AN�LISE DESCRITIVA #

# resumo descritivo geral #
summary(prod) 

# vari�ncia geral #
var(prod) 

# desvio padr�o geral #
sd(prod) 

# coeficiente de varia��o #
((sd(prod))/(mean(prod)))*100             


# ASSIMETRIA (AS) #
# AS = 0 distribui��o sim�trica; #
# AS > 0 distribui��o assim�trica positiva; # 
# AS < 0 distribui��o assim�trica negativa. #

# CURTOSE (CUR) #
# CUR = 3 distribui��o com caudas neutras (normais - mesoc�rtica); 
# CUR > 3 distribui��o com caudas longas ou pesadas (leptoc�rtica); 
# CUR < 3 distribui��o com caudas curtas ou leves (platic�rtica). 

# Chamando o pacote MOMENTS para analise de Assimetria e Curtose #
require(moments)

# Assimetria #
skewness(prod)

# Curtose #
kurtosis(prod)

# Criar histograma #
hist(prod, main = "", xlab = "Produ��o", ylab = "Frequ�ncia")   

# boxplot #
boxplot(prod, ylab = "Produ��o")                  

## Por tratamento ##

tapply(prod, esp, sum)
tapply(prod, esp, summary)
tapply(prod, esp, mean)
tapply(prod, esp, var)
tapply(prod, esp, sd)

boxplot(prod ~ esp, xlab = "Esp�cie", ylab = "Produ��o")

boxplot(prod ~ esp, xlab = "Esp�cie", ylab = "Produ��o", names = 
c("Tobiat�","Elefante","Napier","Cameron"))

## gr�ficos boxplot dos tratamentos com as m�dias ##

(m�dias = tapply(prod, esp, mean))
boxplot(prod~esp, xlab='Esp�cie de Capim',
        ylab='Produtividade',names = 
c("Tobiat�","Elefante","Napier","Cameron"))
points(m�dias, pch='+', cex=1.5, col='red')


# AN�LISE DE VARI�NCIA #

esp <- as.factor(esp)       ## informa��o de que a esp � um fator ##
anv <- aov(prod ~ esp)  ## c�lculo da an�lise de vari�ncia ##
anova(anv)                                ## demonstrativo da Tabela ANOVA ##


model.tables(anv,"means")                ## m�dias geral e por tratamento ##

# Estimativas em anv #

names(anv)

anv$model                       ## conjunto de dados ##
anv$coef                        ## modelo com intercepto, sem coef de esp1 ##
anv$fi                           ## valores ajustados pelo modelo ##
prod - anv$fi                   ## res�duos ##
anv$residuals                   ## res�duos ##
cbind(dados,anv$residuals)

## ANOVA E DEMAIS AN�LISES PELO PACOTE ExpDes ##

require(ExpDes)

crd(esp, prod, quali = T, sigF = 0.05, sigT = 0.05)
crd(esp, prod, quali = T, sigF = 0.01, sigT = 0.01)

##########################################################################
# por default em mcomp = "tukey", existem as op��es: duncan "Duncan", 
# lsd "t-Student", lsdb 'Bonferroni", tukey "Tukey" (default),
# snk "Student-Newman-Keuls", sk "Scott-knott"
##########################################################################

## TESTE DE COMPARA��O M�LTIPLAS DE M�DIAS ##

qtukey(0.95,4,16)                           ## valor da tabela de Tukey ##

## teste tukey ##
TukeyHSD(anv)                               ## teste Tukey, sem pacote "laercio" ##

## gr�fico do intervalo de confian�a para as diferen�as m�dias ##
plot(TukeyHSD(anv,wich='esp',ordered=TRUE,conf.level=0.95))


## instalar o pacote do R chamado de laercio: Pacote; Instalar pacote (no windows)##
## no linux: install.packages("laercio") ##

require(laercio)                            ## pacote laercio ##
LTukey(anv,"esp")                         ## teste Tukey, default = 5%, com pacote "laercio" ##
LTukey(anv,"esp", conf.level = 0.99)      ## teste Tukey, alfa = 1% ##

## gr�fico em colunas com a compara��o de m�dias ##
## link: http://www.r-bloggers.com/lang/portuguese/210 ##

espe <- c("Tobiat�","Elefante","Napier","Cameron")
espe <- as.factor(espe)
medi <- c(14.2,16.62,15.32,18.46)
medi

let <- c("c","b","bc","a")
let <- as.vector(let)
max(medi)

die <- data.frame(espe, medi, let)

require(lattice)

barchart(medi~espe, data=die, horiz=FALSE,
         ylab="M�dia da Produ��o", ylim=c(10,20),
         xlab="Esp�cie de Capim",col = "gray",
         panel=function(x, y, subscripts, ...){
           panel.barchart(x, y, subscripts=subscripts, ...)
           panel.text(x, y, label=die[subscripts,"let"], pos=3, cex = 1)
})




## AN�LISE DAS PRESSUPOSI��ES DO MODELO ##

## normalidade ##

## histograma com a curva normal, usando a m�dia e s de prod ##

x <- seq(14, 20, length.out = 101)           ## o intervalo de valores foi verificado no histograma ##
d <- dnorm(x, mean = mean(prod), sd = sd(prod))

hist(prod, xlab = "Produ��o", ylab = "Frequ�ncia", main = "", prob = T)
lines(x,d, col = "blue")


shapiro.test(prod)    ## teste de normalidade de Shapiro Wilk ##
shapiro.test(anv$residuals)    ## teste de normalidade de Shapiro Wilk ##


require(mvsf)

ad.test(prod)       ## teste de Anderson-Darling ##
ad.test(anv$residuals)

lillie.test(prod)   ## teste de Kolmogorov-Smirnov ##
lillie.test(anv$residuals)


par(family = "serif")
par(mfrow = c(1,2))     ## abre uma janela gr�fica com espa�o para 2 gr�ficos ##
qqnorm(prod, main = "QQ-plot para a produ��o")
qqline(prod, col = "blue")           ## qq-plot
qqnorm(anv$residuals, main = "QQ-plot para o res�duo")
qqline(anv$residuals, col = "blue")           ## qq-plot

## homogeneidade das vari�ncias ##

bartlett.test(prod ~ esp)   ## teste de Bartlett: homogeneidade das vari�ncias ##

require(car)
leveneTest(prod ~ esp)   ## teste de Levene: homogeneidade das vari�ncias ##


residuos <- anv$residuals
residuos
var.res <- tapply(residuos,esp,var) 
var.res

# Teste F-m�xino de Hartley: assume normalidade e mesmo n� de repeti��es
Fmaximo<-max(var.res)/min(var.res)            
Fmaximo # Consulte a tabela do Fmax com n� de trat (1� linha), r-1 (1� coluna)


n <- length(prod)                         # n� total de parcelas #
I <- length(levels(esp))                  # n� de tratamentos #
r <- n/I                                  # n� de repeti��es #


repmean <- rep(tapply(prod, esp, mean), each = r)
plot(repmean,anv$residuals, xlab = "M�dias dos tratamentos", ylab = "Res�duos")


# Independ�ncia #
plot(1:n, anv$residuals, xlab = "Ordem da coleta", ylab = "Res�duos")


# An�lise dos res�duos padronizados: avalia��o de outliers #

plot(anv)                             # Gera 4 gr�ficos, aperte enter para visualizar cada um deles # 

res <- resid(anv) 
res


# Res�duos padronizados #
respad <- res/sqrt(sum(res^2)/anv$df.res)   
respad

plot(fitted(anv), respad, xlab = "Valores ajustados", ylab = "Res�duos padronizados") 
boxplot(respad, ylab = "Res�duos padronizados") 
hist(respad, main = "Histograma dos Res�duos padronizados") 


# AN�LISE DA TRANSFORMA��O BOX COX - SE PRECISAR DE TRANSFORMA��O #
require(MASS)
boxcox(prod ~ esp)
boxcox(prod ~ esp, lam=seq(-6, -4, 1/50))

prod1 <- ((prod^-4.6)-1)/-4.6
prod1


# Teste de normalidade de Shapiro Wilk #
shapiro.test(prod1)    


# Teste de Bartlett: homogeneidade das vari�ncias #
bartlett.test(prod1 ~ esp)   

# Anova e Teste Tukey #
# C�lculo da an�lise de vari�ncia #
anv1 <- aov(prod1 ~ esp)  
anova(anv1)   

crd(esp, prod1, quali = T, sigF = 0.05, sigT = 0.05)
crd(esp, prod1, quali = T, sigF = 0.01, sigT = 0.01)

# Demais an�lises das suposi��es #
shapiro.test(anv1$residuals)                  # Teste de normalidade de Shapiro Wilk #

par(mfrow = c(1,2))                           # Abre uma janela gr�fica com espa�o para 2 gr�ficos #
qqnorm(prod1, main = "produ��o transformada")
qqline(prod1, col = "blue")                                             # qq-plot #
qqnorm(anv1$residuals, main = "res�duo dados transformados")
qqline(anv1$residuals, col = "blue")                                    # qq-plot #

repmean <- rep(tapply(prod1, esp, mean), each = r)
plot(repmean,anv1$residuals, xlab = "M�dias dos tratamentos", ylab = "Res�duos")

# Independ�ncia #
plot(1:n, anv1$residuals, xlab = "Ordem da coleta", ylab = "Res�duos")


