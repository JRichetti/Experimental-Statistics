# obter endereço do caminho da pasta #
getwd() 

# setar diretorio de trabalho #
setwd("C:/Users/Willyan Becker/Dropbox/1. 2. Mestrado Becker/Estatística Experimental/Rotinas") 

# lendo um conjunto de dados em txt, header = T tem nome das colunas na 1ª linha #
dados <- read.table("Exemplo_Dic.txt", header = T)   

# Mostrar dados #
dados

# Fixar a tabela "dados" , para poder chamar as variaveis apenas pelos nomes #
attach(dados)      
 
# ANÁLISE DESCRITIVA #

# resumo descritivo geral #
summary(prod) 

# variância geral #
var(prod) 

# desvio padrão geral #
sd(prod) 

# coeficiente de variação #
((sd(prod))/(mean(prod)))*100             


# ASSIMETRIA (AS) #
# AS = 0 distribuição simétrica; #
# AS > 0 distribuição assimétrica positiva; # 
# AS < 0 distribuição assimétrica negativa. #

# CURTOSE (CUR) #
# CUR = 3 distribuição com caudas neutras (normais - mesocúrtica); 
# CUR > 3 distribuição com caudas longas ou pesadas (leptocúrtica); 
# CUR < 3 distribuição com caudas curtas ou leves (platicúrtica). 

# Chamando o pacote MOMENTS para analise de Assimetria e Curtose #
require(moments)

# Assimetria #
skewness(prod)

# Curtose #
kurtosis(prod)

# Criar histograma #
hist(prod, main = "", xlab = "Produção", ylab = "Frequência")   

# boxplot #
boxplot(prod, ylab = "Produção")                  

## Por tratamento ##

tapply(prod, esp, sum)
tapply(prod, esp, summary)
tapply(prod, esp, mean)
tapply(prod, esp, var)
tapply(prod, esp, sd)

boxplot(prod ~ esp, xlab = "Espécie", ylab = "Produção")

boxplot(prod ~ esp, xlab = "Espécie", ylab = "Produção", names = 
c("Tobiatã","Elefante","Napier","Cameron"))

## gráficos boxplot dos tratamentos com as médias ##

(médias = tapply(prod, esp, mean))
boxplot(prod~esp, xlab='Espécie de Capim',
        ylab='Produtividade',names = 
c("Tobiatã","Elefante","Napier","Cameron"))
points(médias, pch='+', cex=1.5, col='red')


# ANÁLISE DE VARIÂNCIA #

esp <- as.factor(esp)       ## informação de que a esp é um fator ##
anv <- aov(prod ~ esp)  ## cálculo da análise de variância ##
anova(anv)                                ## demonstrativo da Tabela ANOVA ##


model.tables(anv,"means")                ## médias geral e por tratamento ##

# Estimativas em anv #

names(anv)

anv$model                       ## conjunto de dados ##
anv$coef                        ## modelo com intercepto, sem coef de esp1 ##
anv$fi                           ## valores ajustados pelo modelo ##
prod - anv$fi                   ## resíduos ##
anv$residuals                   ## resíduos ##
cbind(dados,anv$residuals)

## ANOVA E DEMAIS ANÁLISES PELO PACOTE ExpDes ##

require(ExpDes)

crd(esp, prod, quali = T, sigF = 0.05, sigT = 0.05)
crd(esp, prod, quali = T, sigF = 0.01, sigT = 0.01)

##########################################################################
# por default em mcomp = "tukey", existem as opções: duncan "Duncan", 
# lsd "t-Student", lsdb 'Bonferroni", tukey "Tukey" (default),
# snk "Student-Newman-Keuls", sk "Scott-knott"
##########################################################################

## TESTE DE COMPARAÇÃO MÚLTIPLAS DE MÉDIAS ##

qtukey(0.95,4,16)                           ## valor da tabela de Tukey ##

## teste tukey ##
TukeyHSD(anv)                               ## teste Tukey, sem pacote "laercio" ##

## gráfico do intervalo de confiança para as diferenças médias ##
plot(TukeyHSD(anv,wich='esp',ordered=TRUE,conf.level=0.95))


## instalar o pacote do R chamado de laercio: Pacote; Instalar pacote (no windows)##
## no linux: install.packages("laercio") ##

require(laercio)                            ## pacote laercio ##
LTukey(anv,"esp")                         ## teste Tukey, default = 5%, com pacote "laercio" ##
LTukey(anv,"esp", conf.level = 0.99)      ## teste Tukey, alfa = 1% ##

## gráfico em colunas com a comparação de médias ##
## link: http://www.r-bloggers.com/lang/portuguese/210 ##

espe <- c("Tobiatã","Elefante","Napier","Cameron")
espe <- as.factor(espe)
medi <- c(14.2,16.62,15.32,18.46)
medi

let <- c("c","b","bc","a")
let <- as.vector(let)
max(medi)

die <- data.frame(espe, medi, let)

require(lattice)

barchart(medi~espe, data=die, horiz=FALSE,
         ylab="Média da Produção", ylim=c(10,20),
         xlab="Espécie de Capim",col = "gray",
         panel=function(x, y, subscripts, ...){
           panel.barchart(x, y, subscripts=subscripts, ...)
           panel.text(x, y, label=die[subscripts,"let"], pos=3, cex = 1)
})




## ANÁLISE DAS PRESSUPOSIÇÕES DO MODELO ##

## normalidade ##

## histograma com a curva normal, usando a média e s de prod ##

x <- seq(14, 20, length.out = 101)           ## o intervalo de valores foi verificado no histograma ##
d <- dnorm(x, mean = mean(prod), sd = sd(prod))

hist(prod, xlab = "Produção", ylab = "Frequência", main = "", prob = T)
lines(x,d, col = "blue")


shapiro.test(prod)    ## teste de normalidade de Shapiro Wilk ##
shapiro.test(anv$residuals)    ## teste de normalidade de Shapiro Wilk ##


require(mvsf)

ad.test(prod)       ## teste de Anderson-Darling ##
ad.test(anv$residuals)

lillie.test(prod)   ## teste de Kolmogorov-Smirnov ##
lillie.test(anv$residuals)


par(family = "serif")
par(mfrow = c(1,2))     ## abre uma janela gráfica com espaço para 2 gráficos ##
qqnorm(prod, main = "QQ-plot para a produção")
qqline(prod, col = "blue")           ## qq-plot
qqnorm(anv$residuals, main = "QQ-plot para o resíduo")
qqline(anv$residuals, col = "blue")           ## qq-plot

## homogeneidade das variâncias ##

bartlett.test(prod ~ esp)   ## teste de Bartlett: homogeneidade das variâncias ##

require(car)
leveneTest(prod ~ esp)   ## teste de Levene: homogeneidade das variâncias ##


residuos <- anv$residuals
residuos
var.res <- tapply(residuos,esp,var) 
var.res

# Teste F-máxino de Hartley: assume normalidade e mesmo nº de repetições
Fmaximo<-max(var.res)/min(var.res)            
Fmaximo # Consulte a tabela do Fmax com nº de trat (1ª linha), r-1 (1ª coluna)


n <- length(prod)                         # nº total de parcelas #
I <- length(levels(esp))                  # nº de tratamentos #
r <- n/I                                  # nº de repetições #


repmean <- rep(tapply(prod, esp, mean), each = r)
plot(repmean,anv$residuals, xlab = "Médias dos tratamentos", ylab = "Resíduos")


# Independência #
plot(1:n, anv$residuals, xlab = "Ordem da coleta", ylab = "Resíduos")


# Análise dos resíduos padronizados: avaliação de outliers #

plot(anv)                             # Gera 4 gráficos, aperte enter para visualizar cada um deles # 

res <- resid(anv) 
res


# Resíduos padronizados #
respad <- res/sqrt(sum(res^2)/anv$df.res)   
respad

plot(fitted(anv), respad, xlab = "Valores ajustados", ylab = "Resíduos padronizados") 
boxplot(respad, ylab = "Resíduos padronizados") 
hist(respad, main = "Histograma dos Resíduos padronizados") 


# ANÁLISE DA TRANSFORMAÇÃO BOX COX - SE PRECISAR DE TRANSFORMAÇÃO #
require(MASS)
boxcox(prod ~ esp)
boxcox(prod ~ esp, lam=seq(-6, -4, 1/50))

prod1 <- ((prod^-4.6)-1)/-4.6
prod1


# Teste de normalidade de Shapiro Wilk #
shapiro.test(prod1)    


# Teste de Bartlett: homogeneidade das variâncias #
bartlett.test(prod1 ~ esp)   

# Anova e Teste Tukey #
# Cálculo da análise de variância #
anv1 <- aov(prod1 ~ esp)  
anova(anv1)   

crd(esp, prod1, quali = T, sigF = 0.05, sigT = 0.05)
crd(esp, prod1, quali = T, sigF = 0.01, sigT = 0.01)

# Demais análises das suposições #
shapiro.test(anv1$residuals)                  # Teste de normalidade de Shapiro Wilk #

par(mfrow = c(1,2))                           # Abre uma janela gráfica com espaço para 2 gráficos #
qqnorm(prod1, main = "produção transformada")
qqline(prod1, col = "blue")                                             # qq-plot #
qqnorm(anv1$residuals, main = "resíduo dados transformados")
qqline(anv1$residuals, col = "blue")                                    # qq-plot #

repmean <- rep(tapply(prod1, esp, mean), each = r)
plot(repmean,anv1$residuals, xlab = "Médias dos tratamentos", ylab = "Resíduos")

# Independência #
plot(1:n, anv1$residuals, xlab = "Ordem da coleta", ylab = "Resíduos")


