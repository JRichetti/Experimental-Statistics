###########################################################################
EXEMPLO DE  ZIMMERMMAN (2004) sem repeti��o
###########################################################################

idade <- c(16,23,30,36,43,57,64,71)
indice <- c(0.16, 0.39, 0.71, 1.17, 2.06, 2.2, 1.97, 1.87)

plot(idade,indice, xlab = "Idade", ylab = "�ndice")
cor(idade,indice)

## estimativa do modelo
linear <- lm(indice ~ idade)
linear

coef(linear)

summary.lm(linear)      ## INFER�NCIA PAR�METROS E R2 ##
anv <- anova(linear)    ## ANOVA REGRESS�O ##
anv

confint(linear)   ## IC PARA OS PAR�METROS ESTIMADOS ##

plot(idade,indice, xlab = "Idade", ylab = "�ndice")
abline(linear, col="blue")              ## GR�FICO COM A REGRESS�O ##

names(linear)

linear$res               ## RES�DUOS ##

linear$fi                ## VALORES ESTIMADOS ##


############################################################################
# EXEMPLO DE BANZATTO E KRONKA (1989) SOBRE UM EXPERIMENTO QUE ANALISA O
# EFEITO DE DOSES DE GESSO NA CULTURA DO FEIJOEIRO, MONTADO NUM DIC COM
# 4 REPETI��ES, SENDO A VARI�VEL RESPOSTA O PESO DE 1000 SEMENTES EM GRAMAS
############################################################################

x <- c(rep(0,4), rep(50,4), rep(100,4), rep(150,4), rep(200,4), rep(250,4), rep(300,4))
y <- c(134.8, 139.7, 147.6, 132.3, 161.7, 157.7, 150.3, 144.7, 160.7, 172.7,
163.4, 161.3, 169.8, 168.2, 160.7, 161, 165.7, 160, 158.2, 151, 171.8, 157.3,
150.4, 160.4, 154.5, 160.4, 148.8, 154)

dados <- cbind(x,y)
dados

plot(x,y, xlab = "Doses de gesso (kg/ha)", ylab = "Peso de 1000 sementes (gramas)")
cor(x,y)

## CONSIDERANDO x COMO VARI�VEL QUALITATIVA ##
x1 <- as.factor(x)
anv <- aov(y ~ x1)
summary(anv)

## ESTIMANDO A EQUA��O PELO M�TODO DE M�NIMOS QUADRADOS MATRICIALMENTE ##

## 1� GRAU ##
n <- length(x)
xx <- cbind(rep(1,n),x)

betalin <- solve(t(xx)%*%xx)%*%(t(xx)%*%y)
betalin

## 2� GRAU ##
xx <- cbind(rep(1,n),x, x^2)

betaqua <- solve(t(xx)%*%xx)%*%(t(xx)%*%y)
betaqua

## 3� grau ##
xx <- cbind(rep(1,n),x, x^2, x^3)

betacu <- solve(t(xx)%*%xx)%*%(t(xx)%*%y)
betacu


## CONSIDERANDO x COMO VARI�VEL QUANTITATIVA ##
## 6 n�veis  = regress�o de at� 6� grau, mas geralmente n�o se tem interesse
## pr�tico em regress�es maiores que de 3� grau

## LINEAR ##

## estimativa do modelo
lin <- lm(y ~ x)
lin

## curva do modelo estimado
plot(x,y)
lines(x,lin$fi)

## anova
m <- mean(y)
fi <- lin$fi

sqtotal <- sum((y - m)^2)
sqtotal

sqreg <- sum((fi-m)^2)
sqreg

sqres <- sum((y-fi)^2)
sqres

anova(lin)
summary.lm(lin)

## QUADR�TICA ##

## estimativa do modelo
x2 <- x^2

qua <- lm(y ~ x + x2)
qua

## gr�fico da curva do modelo estimado
plot(x,y)
lines(x,qua$fi)

## anova
fi <- qua$fi

sqtotal <- sum((y - m)^2)
sqtotal

sqreg <- sum((fi-m)^2)
sqreg

sqx1 <- 423.15

sqx2 <- sqreg - 423.15
sqx2

sqres <- sum((y-fi)^2)
sqres

summary.lm(qua)
anova(qua)

## gr�fico com a curva ajustada ##
cf <- summary.lm(qua) 
plot(x,y, xlab = "Dose de gesso", ylab = "Peso de 1000 sementes") 
## complete de acordo com o grau do polinomio 
B0 <-cf$coefficients[1]
B1 <-cf$coefficients[2]
B2 <-cf$coefficients[3]    # �� 
curve(B0+B1*x+B2*x^2, col="red",add=T) 

## C�BICA ##

## estimativa do modelo
x3 <- x^3

cub <- lm(y ~ x + x2 + x3)
cub


## gr�fico com a curva ajustada ##
cf <- summary.lm(cub) 
plot(x,y, xlab = "Dose de gesso", ylab = "Peso de 1000 sementes") 
## complete de acordo com o grau do polinomio 
B0 <-cf$coefficients[1]
B1 <-cf$coefficients[2]
B2 <-cf$coefficients[3]
B3 <-cf$coefficients[4]

curve(B0+B1*x+B2*x^2+B3*x^3 , col="red",add=T) 

## anova
fi <- cub$fi

sqtotal <- sum((y - m)^2)
sqtotal

sqreg <- sum((fi-m)^2)
sqreg

sqx1 <- 423.15
sqx2 <- 1285.848

sqx3 <- sqreg - 423.15 - 1285.848
sqx3

sqres <- sum((y-fi)^2)
sqres

anova(cub)

## COM PACOTE EXPDES ##

require(ExpDes)

## considerando x como vari�vel qualitativa ##
crd(x, y, quali = T, sigF = 0.05, sigT = 0.05)  

## considerando x como vari�vel quantitativa ##
## R2 = SQReg/SQTrat ##
## SQ lack of fit(falta de ajuste) = SQTrat - SQReg ##

crd(x, y, quali = F, sigF = 0.05, sigT = 0.05)  ## s� est� implementada at� grau 3 ##



