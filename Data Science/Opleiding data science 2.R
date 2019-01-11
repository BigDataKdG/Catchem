###########################################################
#        _       _                   _                    #
#      | |     | |                 (_)                    #
#   __| | __ _| |_ __ _   ___  ___ _  ___ _ __   ___ ___  #
# / _` |/ _` | __/ _` | / __|/ __| |/ _ \ '_ \ / __/ _ \  #
#| (_| | (_| | || (_| | \__ \ (__| |  __/ | | | (_|  __/  #
#\__,_|\__,_|\__\__,_| |___/\___|_|\___|_| |_|\___\___|   #
###########################################################

library(MASS)
library(car)
signif(X,4)
options(scipen = 999)

setwd("C:/Users/overvelj/Dropbox/Data Analyse/2017-2018/7 forecasting (Kris)/oefeningen")

#Les 1.1: kansen
{
  
  #Productregel
    #P(A en B) = P(A) * P(B|A)
  #Som regel
    #P(A of B) = P(A) + P(B) – P(A | B)
  #Bayes
    #P(A|B) = P(B|A) * P(A) / P(B)
 # Totale Kans
    #P(A) = P(G1) * P(A|G1) + P(G2) * P(A|G2) + … 
  
  
  # 11
  f = c(1368, 1642, 1642, 159, 1480, 1574, 947, 1642, 1608, 1576, 156, 1387, 1589, 176)
  fi = c(40, 46, 46, 1, 24, 38, 11, 35, 46, 39, 2, 46, 14, 1)
  f = f/1642
  fi = fi/46
  prod(fi)*(46/1642)/prod(f)
}

#Les 1.2: kansverdelingen
{

  #voorBinorm/pois (Probability of having a value *lower* than or equal to  X)
    # meer dan X =  X
    # X of meer/ ten minste X =  X-1
    # minder dan X = X-1
    # minder of X = X
  #voor pnorm (Given an x value, it returns the probability (AUC) of having a value lower than x.)
    # meer dan X =  X
    # minder dan X = X
  
##binom verdeling
#vragen over repetitieve experimenten

dbinom(x,n,p)
  dbinom(1,10,0.02)
  dbinom(1,10,0.002)
  dbinom(1,4,1/6)
  dbinom(3,4,5/6)
  dbinom(1,4,2/6)
  dbinom(1,4,4/6)
  
#x= aantal keer de uitkomst (exact!) voor 
#n= aantal keer herhaling
#p= de kans 

<<<<<<< HEAD
# voor ranges (check this again)
pbinom(x,n,p)#minder dan
pbinom(20,100,2/5)
1-pbinom(x,n,p) #meer dan
1-pbinom(2,6,0.4) #meer dan 2 = 2 invullen, niet 3!
=======
# voor ranges 
pbinom(x,n,p) #minder dan
1- pbinom(x,n,p) #meer dan

>>>>>>> d397cb781259a90f5b51d8f249a10a408d8d1ad9

#gemiddelde aantal gebeurtenis, gegeven kans
# mu = n*p

##Poissionverdeling
# hoevaak zal iets gebeuren, gegeven een gemiddelde kans/tijd

dpois(x,mu)
<<<<<<< HEAD
dpois(55,8)
#x = antal keren dat het voorkomt
#mu = aantal keren het gemiddeld voorkomt

#voor ranges
ppois(x,mu) #minder dan
1-ppois(x,mu) # meer dan
1-ppois(2,3.5)
=======
#x = antal keren dat het voorkomt
#mu = aantal keren het gemiddeld voorkomt

#voor ranges 
1-ppois(x,mu)
ppois(x,mu)
>>>>>>> d397cb781259a90f5b51d8f249a10a408d8d1ad9


#formules
mu = n*p #verwachte waarden binom
sqrt(n*p*(1-p)) # verwachte standaard afwijking binom
sqrt(40*.85*(1-.85)) 
sigma = sqrt(mean) #verwachte standaard afwijking Pois

#normaal verdeling
dnorm(x, mean=, sd=) #specifieke waarde

pnorm(x, mean=, sd=)# < minder dan waarde
pnorm(16, mean=20, sd=4)
1- pnorm(x, mean=, sd=) # > meer dan waarde
1- pnorm(400, mean=500, sd=100)

pnorm(x, mean=0, sd=1)-pnorm(x, mean=0,sd=1)#tussen 2 waarden < < (geen minwaarden!)
pnorm(0.92, mean=0, sd=1)-pnorm(0.45, mean=0,sd=1)

#van kans naar waarde
qnorm(0.16,mean=100, sd=15 )
qnorm(0.95,mean=100, sd=18 ) #meer dan 1-kans!



}

#Les 2 toetsen

{
data <- read.csv(file="haarkleurbrussel.csv")
data
#CHI?? testing
#h0= er van uitgaan dat de verdeling evenredig/ niet afwijkt/hetzelfde is
#data <- rep(c('IO', 'OP', 'MF', 'GC'), c(8,10,10,12))
observerd  <-table(data) # (fo)
expected <- c(5,17,8,10)#in frequencie, maar werkt ook met percenten! (fe)
X = chisq.test(x=observerd, p=expected, rescale.p=T)
X$statistic #wat is de X²
X$p.value #kans dat een extremere waarden wordt gevonden (onder de 0.05% = significant, H0= verworpen)

# alternatief voor chisq.test 
critValue = signif(qchisq(0.99, 3),4)
chiKwadraat = signif(sum((fo-fe)^2/fe),4)
pValue = signif(1-pchisq(14.61,3),3)


b = 0.99
m = length(data)
# m - 1 = vrijheidsgraden (df), ook wel t genoemd. Spreiding van de t-verdeling
criticalvalue<- qchisq(b,m-1) # qchisq = quantile function, vind de x waarde die bij percentiel b ligt, critical value voor dit percentiel
criticalvalue


#intervals met normale verdeling
##als sigma gekend is of grote steekproef --> Z TEST
#op basis van een steekproef iets zeggen over de populatie
# b = gewenste betrouwbaarheid
b= 0.99 
f = qnorm((1+b)/2) #factor op basis van zekerheid
mo = 11.9#mean(x)
s = 1 #sd(x)
n = 100
links = mo - f * s / sqrt(n) 
rechts = mo + f * s / sqrt(n)
links
rechts
#dan nakijken of m erin zit of niet

#of
a <- 1-b
m + c(-1,1)*qnorm(1-a/2)*s/sqrt(n) #zekerheid dat populatie gemiddelde tussen deze twee grenzen ligt


#testen normaal (standaard afwijking niet gekend)
#kunnen we een bewering over de populatie weerleggen adhv steekproef?
n <- 100
m <- 12
mo <- 11.9
s <- 1
z = (mo-m) / (s/sqrt(n)) #z = (mo-m) / s * sqrt(n)
p <- pnorm(abs(z))  
(1-p)*2

#of
p <- pnorm(mo, mean = m, sd= s/sqrt(n),lower.tail=T)
p*2
  #je test met SIGMA2(de standaardFOUT)

#kritische grens (waarde tot waar het gemiddelde kan gaan voor het verworpen kan worden)
c <- qnorm(0.1, mean= -0.545, sd=s/sqrt(n), lower.tail=T) #vinden van kritieke waarde (alles wat boven/onder ligt )
c

#of
rnorm2 <- function(n,mean,sd) { mean+sd*scale(rnorm(n)) }
r <- rnorm2(100,11.9,1)

z.test1 = function(x,mu,sd){
  one.tail.p <- NULL
  z.score <- round((mean(x)-mu)/(sd/sqrt(length(x))),3)
  one.tail.p <- round(pnorm(abs(z.score),lower.tail = FALSE),3)
  cat(" z =",z.score,"\n",
      "one-tailed probability =", one.tail.p,"\n",
      "two-tailed probability =", 2*one.tail.p )}

z.test1(r,12,1)

#check with
install.packages("BSDA")
library("BSDA")
z.test(r,alternative= "greater", mu = 12, sigma.x = 1, conf.level = 0.99)

#Z-test eenzijdig
m <- -0.545
mo <-  -0.539 
s <- 0.008
n <- 5
z <- (mo-m)/(s/sqrt(n)) #Z-score die hoort bij deze specifieke waarde
z<- pnorm(abs(z))
1-z 

#of
p <- pnorm(mo, mean = m, sd= s/sqrt(n),lower.tail=F)#lower.tail=false= rechts

#kritische grens (waarde tot waar het gemiddelde kan gaan voor het verworpen kan worden)
c <- qnorm(0.1, mean= -0.545, sd=s/sqrt(n), lower.tail=FALSE) #vinden van kritieke waarde (alles wat boven/onder ligt )
c

r <- rnorm2(5,-0.539,0.008)

z.test1(r,-0.545,0.008)


# T intervallen

#f =factor
#m = mean
# n= sample
# b = betrouwbaarheid
<<<<<<< HEAD
# s = standaar afwijking
m <- 107.3
b <- 0.95
=======
# s = standaard afwijking
m <- 11.9
b <- 0.99
>>>>>>> d397cb781259a90f5b51d8f249a10a408d8d1ad9
a <- 0.01
n <- 16
f <- qt((1+b)/2, n-1)#qt(1-a/2, n-1)
s <- 8
links = m - f * s / sqrt(n) 
rechts = m + f * s / sqrt(n)
links
rechts

#testen t TOETS
n <- 16
m <- 100
mo <- 107.3
s <- 8
t1 = (mo-m) / (s/sqrt(n)) #t = (mo-m) / s *sqrt(n)
p <- pt(-abs(t), n-1) *2
p

<<<<<<< HEAD
#kritische grens (waarde tot waar het gemiddelde kan gaan voor het verworpen kan worden)
c <- qt(0.95,15) #vinden van kritieke waarde (alles wat boven/onder ligt )
c

#of
rnorm2 <- function(n,mean,sd) { mean+sd*scale(rnorm(n)) }
r <- rnorm2(16,107.3,8)


t.test(r, alternative="two.sided", mu=100, conf.level=0.95)


#↔t-test eenzijdig
=======
#???t-test eenzijdig
>>>>>>> d397cb781259a90f5b51d8f249a10a408d8d1ad9
n <- 5
m <- -0.545
mo <- -0.539
s <- 0.008
t = (mo-m) / (s/sqrt(n)) #t = (mo-m) / s *sqrt(n)
p <- pt(t, n-1)
1-p #1-P voor linke




#
t = t.test(laptops, conf.level=0.95, mu=50)
t$p.value
#Merk op dat je in onderstaande code de waarde van alternative op greater zet als de hypothese
#zegt dat de waarde kleiner is. Dat is misschien een beetje verwarrend.
t=t.test(laptops, conf.level=0.95, mu=32, alternative="greater")
t$p.value
as.vector(t$conf.int)
t=t.test(laptops, conf.level=0.95, mu=32, alternative="less")
t$p.value
as.vector(t$conf.int)
t=t.test(laptops, conf.level=0.95, mu=47, alternative="less")
t$p.value

# code for a dataset
error <- qt(0.975,df=length(w1$vals)-1)*sd(w1$vals)/sqrt(length(w1$vals))
error
left <- mean(w1$vals)-error
right <- mean(w1$vals)+error
left
right


#oefening
d=scan("dataRandom.txt")
table(d)
fe=rep(100,11)
fo=as.vector(table(d))
chisq.test(fo, p=fe, rescale.p = T)
signif(qchisq(0.95, 10),4)

}

#Les 3: genetische Algoritmen

##### INFO #####

# GenSA (sim anealing) -> waarde minimaliseren, GA -> waarde optimaliseren
# Bij GenSA moet je in de return dus (altijd??) een - teken zetten om de laagste waarde te returnen

# TYPE GA kiezen (uit docs):
# the type of genetic algorithm to be run depending on the nature of decision variables. Possible values are:
  
#  "binary" for binary representations of decision variables.

# "real-valued" for optimization problems where the decision variables are floating-point representations of real numbers.

# "permutation" for problems that involves reordering of a list of objects.
################

{
##### INFO #####

# GenSA (sim anealing) -> waarde minimaliseren, GA -> waarde optimaliseren
# Bij GenSA moet je in de return dus (altijd??) een - teken zetten om de laagste waarde te returnen

# TYPE GA kiezen (uit docs):
# the type of genetic algorithm to be run depending on the nature of decision variables. Possible values are:
  
#  "binary" for binary representations of decision variables.

# "real-valued" for optimization problems where the decision variables are floating-point representations of real numbers.

# "permutation" for problems that involves reordering of a list of objects.
################

{
library("GA") #genetic algorithm
library("GenSA") #simulated annealing

#knapsack problem 
  {
  #with SA
data <- read.csv(file="Knapsack Items.csv", sep=";")

# Define data 
<<<<<<< HEAD
p <- data$gewichten.gr. # Profits 
w <- data$waarde # Weights 
v <- 750 # Knapsack ’s capacity 
=======
p <- data$waarde # Profits 
w <- data$gewichten # Weights 
W <- 750 # Knapsack ???s capacity 
>>>>>>> d397cb781259a90f5b51d8f249a10a408d8d1ad9
n <- length(p) # Number of items

# Define fitness function 
knapsack <- function(x) { 
  f <- sum(x * p) 
  penalty <- sum(w) * abs(sum(x * w) - v) 
  f - penalty 
}
# Run SGA
SGA <- ga(type="binary", 
          fitness=knapsack , 
          nBits=n, 
          maxiter=1000, # Maximum number of generations 
          run=2000,     # Stop if the best-so-far fitness
          # hasn't improved for 'run' generations 
          popSize=1000, 
          seed=202554)

x.star <- SGA@solution # Final solution: c(1, 0, 0, 1, 0, 0, 0)
sum(x.star)     # Total number of selected items:4 
sum(x.star * p) # Total profit of selected items: 393
sum(x.star * w) # Total weight of selected items: 749


#knapsack problem with GENSA

p <- data$gewichten.gr. # Profits 
w <- data$waarde # Weights 
W <- 750 # Knapsack ???s capacity 
n <- length(p) # Number of items


x = sample(c(0,1),size = n, replace = T) #set a first at random to be optimized 

knapsack <- function(x) { 
  x=round(x)
  f <- sum(x * p) 
  penalty <- sum(w) * abs(sum(x * w) - W) 
  -(f - penalty )
}

# Run GenSA
SA = GenSA(par = x, fn = knapsack, lower = rep(0,n), upper = rep(1,n))
x.star = round(SA$par)

print(x.star)
print(sum(x.star)) # Total number of selected items
print(sum(x.star * p)) # Total profit of selected items
print(sum(x.star * w)) # Total weight of selected items
}

###the traveling salesman problem
  {
    
steden = read.csv("steden.csv", sep=";")
row.names(steden) = colnames(steden)
n = length(steden)

# Define data 
p <- data$gewichten.gr. # Profits 
w <- data$waarde # Weights 
W <- 750 # Knapsack ???s capacity 
n <- length(p) # Number of items

objective.function = function(x) {
  # create indices from x
  s1 = x[seq(1,n-1)]
  s2 = x[seq(2,n)]
  indices = matrix(c(s1,s1[1],s2,s2[length(s2)]),nrow = length(s1)+1)
  totaal = 0
  for(i in 1:n){
    totaal = totaal + steden[indices[i,1],indices[i,2]]
  }
  return(-totaal)
}


# Run SGA

SGA = ga(type="permutation", # we werken met binaire chromsomen
         fitness=objective.function , # geef onze fitness functie mee
         nBits=n, # aantal bits in een chromosoom
         maxiter=500, # Maximaal aantal iteraties
         run=100,
         lower = 1,
         upper = n,
         popSize=100, # Populatiegrootte,
         monitor = T, #
         names = colnames(steden) # namen voor de genen
)

summary(SGA)

x.star = SGA@solution[1,]

stadsnamen = colnames(steden)[x.star]

print(paste0(paste0(stadsnamen, sep = " -> ", collapse = ""),stadsnamen[1],sep="",collapse = ""))


#simulated annealing

steden = read.csv("steden.csv", sep=";")
row.names(steden) = colnames(steden)
n = length(steden)

x = sample(c(1:5),size = n, replace = F) #set a first at random to be optimized 

objective.function = function(x) {
  # create indices from x
  s1 = x[seq(1,n-1)]
  s2 = x[seq(2,n)]
  indices = matrix(c(s1,s1[1],s2,s2[length(s2)]),nrow = length(s1)+1)
  totaal = 0
  for(i in 1:n){
    totaal = totaal + steden[indices[i,1],indices[i,2]]
  }
  return(round(-totaal))
}

# Run GenSA
lower = as.numeric(rep(1,5))
upper = as.numeric(rep(5,5))
SA = GenSA(par = as.numeric(x), fn = objective.function, lower, upper)
x.star = round(SA$par)

print(x.star)
print(sum(x.star)) # Total number of selected items
print(sum(x.star * p)) # Total profit of selected items
print(sum(x.star * w)) # Total weight of selected items
  }
  

 
solveDakgoot = function(widthConstraint) {
  constraint = widthConstraint    # de breedte van de plaat, nl. 100 (cm)
  n = 2             
  
  objFuncDakgoot = function(x){
    b = x
    h = (100 - b)/2
    opp = b*h
    return(opp)
  }
  SGA <- ga(type="real-valued",  # real-valued, want we werken met getallen, daarom ook min en max
            fitness=objFuncDakgoot, 
            lower = 0,
            upper = widthConstraint,
            maxiter=100, # Maximum number of generations 
            run=200, # Stop if the best-so-far fitness hasn't improved for 'run' generations 
            popSize=100, 
            seed=101)
  
  return(SGA) 
}
sga = solveDakgoot(100)
sga@solution # we stellen in de objective function x gelijk aan de breedte, dus de solution hier geeft ook de breedte (in cm) weer



# Define data 
W <- 400
n <- 2 # Number of items

objective.function = function(x) {
  omtrek = 2*(x[1] + x[2])
  print(x)
  if (omtrek > W) {
    return(0)
  }
  opp = x[1] * x[2]
  return(opp)
}

<<<<<<< HEAD
# Run SGA
SGA = ga(type="real-valued", 
         fitness=objective.function, # geef onze fitness functie mee
         nBits=n,     # aantal bits in een chromosoom
         maxiter=500, # Maximaal aantal iteraties
         run=100,     
         lower=0,
         upper=400,
         popSize=100, # Populatiegrootte,
         monitor = T
)

}
  
  monitor.function = function(obj) {
    curve(objective.function, 0, 100, main = paste("iteration = ", obj@iter), font.main = 1)
    points(obj@population, obj@fitness, pch = 20, col = 2)
    rug(obj@population, col = 2)
  }
}

#Les 4.1: discriminant analyse
=======
## monitor functie overgenomen uit les, maar werkt niet :/

monitor.function = function(obj) {
  curve(objective.function, 0, 100, main = paste("iteration = ", obj@iter), font.main = 1)
  points(obj@population, obj@fitness, pch = 20, col = 2)
  rug(obj@population, col = 2)
}

#Les 4: discriminant analyse

>>>>>>> d397cb781259a90f5b51d8f249a10a408d8d1ad9
{
library("MASS")

#aantal dimensies = 
 # - aantal categorie??n afhank - 1
 # - aantal indep 
 # = minimum van deze twee
#De afhankelijke variabele is minstens op nominale schaal gemeten, 
 #alle onafhankelijke variabelen zijn continue variabelen op minstens intervalschaal gemeten.
 #onaf: in principe mogen enkele continue, normaal verdeelde, lineaire, niet-gecorreleerde variabelen gebruikt worden
  
lda(groep ~ x1 +x2 + X3, data = data)
data("biopsy")
lda(class ~ V1 + V2 + V3, data=biopsy)
summary(glm(class ~ V1 + V2 + V4 ,family=binomial(link='logit'),data=biopsy))


#oef 1
library("DiscriMiner")
data("bordeaux")

m1 <- lda(quality ~ temperature + sun + heat + rain, data = bordeaux)
plot(m1)
ggbiplot(m1,  ellipse = T, obs.scale = T)

predict(m1)$Class

vergelijk <- table(bordeaux$quality, predict(m1)$class)
#2 dimensisies 
# de individuele waarden, op 2 dimensies, gebruik makend van de functies
confusion.matrix = table(predict(m1)$class,bordeaux$quality) 
accuracy = sum(diag(confusion.matrix))/sum(confusion.matrix) 
accuracy

#oef 2
data("birthwt")

str(birthwt)

m1 <- lda(low ~ age + lwt + bwt, data = birthwt)
#1
plot(m1)

c.m = table(predict(m1)$class,birthwt$low) 
accuracy = sum(diag(c.m)) / sum(c.m)

#oef3
data("Cars93")

str(Cars93)
data1 <- Cars93[1:90,]
data2 <- Cars93[91:93,]

 m1 <- lda(Type ~ Price + MPG.city + MPG.highway  + EngineSize + Horsepower + 
             RPM + Rev.per.mile + Fuel.tank.capacity + Passengers + Length +Wheelbase + Width + Turn.circle + 
             Rear.seat.room + Luggage.room + Weight, data = Cars93)
 
 #would only take variables with type NUM as contious
 #should also check for correlation among the variables
 
m2 <- predict(m1,data2)

table <- as.data.frame(t(m2$posterior))

table[which.max(table$`91`),]
table[which.max(table$`92`),]
table[which.max(table$`93`),]

predict(m1)$Class

}

#les 4.2 PCA
{

# hoge correlatie nodig tussen variabelen
# variabelen moeten op het ratio niveau gemeten zijn 
# check for missings
   
 # les 4 PCA
 
 ##### INFO #####
 
 # Tips:
 ## verwijder niet-ratio variables
 ## verwijder NA's, prcomp kan hier niet mee om! na.omit(predictoren)
 
 ################
 
 data <- read.csv(file="Protein.csv")
 
 data1 <- data[, -(c(1,2,3,13)) ]
 rownames(data1) <- data[,1]
 
 cor(data1)
 mean(abs(cor(data1)))
 #ja goede corr
 
 result = prcomp(data1, scale.= TRUE, center = TRUE) #rank. = kan je ook ingeven hoeveel compon weer te geven
 summary(result)
 
 #extra: beslissen welke te behouden
 (result$sdev)^2# alles boven 1
 screeplot(result, type="lines")
 corr(data1)
 
 ## correlatie tussen de verschillende (originele) variabelen. Hoog = goed want betere kans op goeie reductie 
 mean(abs(cor(data1)))
 
 result$rotation #ceral weegt door
 s = summary(result)
 cumsum(s$importance[2,])
 
 biplot(result)
 
 library("ggbiplot")
 ggbiplot(result, groups = data$Comunist, ellipse = T, obs.scale = T)
 PCApredictoren = data.frame(predict(result)[,1:3])
 
 clusters <- hclust(dist(result$x[,1:3]))
 plot(clusters)
 

 #oef2
goblet <- read.csv(file="goblets.csv", sep=";")
goblet1 <- goblet[, -1 ]
rownames(goblet1) <- goblet[,1]
result = prcomp(goblet1, scale.= TRUE, center = TRUE)
summary(result)
plot(result)
biplot(result)
ggbiplot(result,  ellipse = T, obs.scale = T)

data <- goblet1

data$V1 = goblet$X2/goblet$X1
data$V2 = goblet$X2/goblet$X4
data$V3 = goblet$X1/goblet$X4
data$V4 = goblet$X2/goblet$X5
data$V5 = goblet$X1/goblet$X5
data$V6 = goblet$X4/goblet$X5
data$V7 = goblet$X3/goblet$X6

verhoudingen <- data[, -c(1:6)]

result = prcomp(verhoudingen, scale.= TRUE, center = TRUE)
ggbiplot(result,  ellipse = T, obs.scale = T)

cor(goblet) 
cor(verhoudingen)
mean(abs(cor(goblet)))
mean(abs(cor(verhoudingen)))

summary(result)
cor(verhoudingen)

#oef3
data("cpus")
data1 <- cpus[, -(c(1)) ] #wat met min & max?
rownames(data1) <- cpus[,1]
cor(data1)#syct mss niet?

result = prcomp(data1, scale.= TRUE, center = TRUE)
summary(result) #nee enkel 1 weegt door? of is minus ook doorwegen?

plot(result)
biplot(result)#3 pijlen naar dezelfde richting, dus 3? de results zeggen 4
ggbiplot(result,  ellipse = T, obs.scale = T)

PCApredictoren = data.frame(predict(result)[,1:6])
}

#Les 5: Neural networks
{
library("keras")
install_keras()

  #MNIST example
  {
  mnist <- dataset_mnist()
  x_train <- mnist$train$x
  y_train <- mnist$train$y
  x_test <- mnist$test$x
  y_test <- mnist$test$y
  
  dim(x_train) #60000 matrices van 28 op 28
  dim(y_train)
  
  # visualize first 4 digits
  par(mfcol=c(1,4))            	# plaats 4 afbeelding naast elkaar
  for(i in 1:4){
    im = x_train[i,,]           # selecteer het i-de 2D image
    im = t(apply(im, 2, rev))   # keer de kolommen om (ze staan op hun kop)
    image(im)		        	# plot
  }
  
  head(y_train)
  
  # reshape
  x_train <- array_reshape(x_train, c(nrow(x_train), 784))
  x_test <- array_reshape(x_test, c(nrow(x_test), 784))
  # rescale
  x_train <- x_train / 255
  x_test <- x_test / 255
  
  dim(x_test)
  dim(x_train)
  
  y_train <- to_categorical(y_train, 10)
  y_test <- to_categorical(y_test, 10)
  
  
  #4 layers, (1) input = 784 (28*28), (2) hidden 256, (3) 128, (4) 10
  model <- keras_model_sequential() 
  model %>% 
    layer_dense(units = 256, activation = 'relu', input_shape = c(784)) %>% 
    layer_dropout(rate = 0.4) %>% 
    layer_dense(units = 128, activation = 'relu') %>%
    layer_dropout(rate = 0.3) %>%
    layer_dense(units = 10, activation = 'softmax')
  
  summary(model)
  
  
  model %>% compile(
    loss = 'categorical_crossentropy', #kost functie
    optimizer = optimizer_rmsprop(),
    metrics = c('accuracy')
  )
  
  # 30 alles erdoor, per 128 de errors udaten, validation split = apart houden en niet aanbieden (om te testen voor overfit)
  history <- model %>% fit(
    x_train, y_train, 
    epochs = 30, batch_size = 128, 
    validation_split = 0.2
  )
  
  
  #BOVENAAN=>blauw= de training set, groen = de validatie set. Na 30 epochs zien we een discrepantie tussen de twee curves wat op over-fitting wijst
  #ONDERNAAN=>de accuracy (hier zie je ook de divergentie)
  plot(history)
  
  model %>% evaluate(x_test, y_test)
  
  model %>% predict_classes(x_test)
  
}

  #simpsons (logistisc)
  {
  data <- read.csv(file="simpsons_orig.csv", sep=";")
  
  #matrix maken van de dataframe met trainingsdata (enkel met de bruikbare data)
  x_train <-as.matrix(data[,3:5])
  
  #de target vector mag geen nominale data bevatten, dus omzetten
  y_train <- as.matrix(ifelse(data$Geslacht == "M", 0, 1))
  
  #normaliseer data met range 1-0
  x_train<- normalize(x_train)
  
  model <- keras_model_sequential() 
  model %>% 
    layer_dense(units = 64, activation = 'relu', input_shape = c(3)) %>% #64 is hier zeer arbitrair, gebruikelijk is een waarde kiezen tussen de input & output, maar waarschijnlijk is de input hier te klein voor
    layer_dense(units = 32, activation = 'relu') %>%
    layer_dense(units= 16, activation = 'relu') %>%
    layer_dense(units = 1, activation = 'sigmoid') #sigmoid voor 0/1 te bekomen
  
  summary(model)
  
  
  ###verschillende activatie functies
  #lineaire
  # sigmoid
  
  #Sigmoid functions and their combinations usually work better for classification 
  ##techniques ex. Binary Classification 0s and 1s.
  
  # relu
  
  ## most popular, but can only be used in the hidden layers
  
  
  # softmax
  
  #normalises output: the question than is, why have we normalised the data in the first place? And what is the difference between sigmoid and softmax?
  
  #sigmoid is used for two-class logistic regression, whilst softmax is used for multiclass (multinominal) logistic regression
  
  
  # leaky rely
  # tanh 
  # elu 
  
  
  model %>% compile(
    loss = 'binary_crossentropy',
    optimizer = optimizer_nadam(),
    metrics = c('accuracy')
  )
  
  ###verschillende soorten loss
  # binary_crossentropy
  # categorical_crossentropy
  
  ###verschillende soorten optizer
  #optimizer_rmsprop
  #optimizer_nadam
  
  history <- model %>% fit(
    x_train, y_train, 
    epochs = 100, batch_size = 3 
    #,validation_split = 0.2 #staat uit wegens kleine grote
  )
  
  model %>% predict(x_train)
  
  model %>% predict_classes(x_train) #maakt er classes van
  
}

  ##forecasting_demo (lineare data)
  {
  data <- read.csv(file="forcastdemo.csv", sep=",")
  
  x_train <- as.matrix(data$index) #blijkbaar moet de index erbij?
  y_train <- as.matrix(data[,3])
  
  #scale() uses Z-score standardisation (it would also be possible to test whether scaling it between 0-1 has an impact)
  x_train <- scale(x_train)
  y_train <- scale(y_train)
  
  
  model <- keras_model_sequential() 
  model %>% 
    layer_dense(units = 16, activation = 'relu', input_shape = c(1)) %>% #64 is hier zeer arbitrair, gebruikelijk is een waarde kiezen tussen de input & output, maar waarschijnlijk is de input hier te klein voor
    layer_dense(units = 1) #no activiation function because it is a regression and we want to predict num. values without transformation
  
  summary(model)
  
  #possible loss for linear regression:
    #mean_absolute_error
    #mean_squared_error
  #possible metrics
    #mean_absolute_error
    #mean_squared_error
  #possible optimizers
    #optimizer_rmsprop
    #optimizer_adam
  
  model %>% compile(
    loss = 'mean_squared_error', #this gives us an error-term which we understand directly (squared revenu)
    optimizer = optimizer_rmsprop(),
    metrics = c('mean_absolute_error')
  )
  
  
  history <- model %>% fit(
    x_train, y_train, 
    epochs = 5000, batch_size = 5 
    #,validation_split = 0.2 #staat uit wegens kleine grote
  )
  
  model %>% predict(x_train)
  plot(x_train, y_train, type="b")
  points(x_train, model %>% predict(x_train), type="b", col="red")
  
}

  ## IRIS (multinominal logistic)
  {
    data("iris")
    data <- iris
    
    data$Species<- recode(data$Species,"'setosa'= 0;'versicolor'= 1;'virginica'=2 ") #oppassen met 1. based!!!

    rows <- sample(1:nrow(data), 30 )
    test.data <- data[rows,]
    train.data <- data[-rows,]
    
    x_train <- normalize(as.matrix(train.data[,1:4]))
    y_train <- as.matrix(train.data[,5])
    
    x_test <- normalize(as.matrix(test.data[,1:4]))
    y_test <- as.matrix(test.data[,5])
    
    y_train <- to_categorical(y_train) 
    y_test <- to_categorical(y_test)
    
    model <- keras_model_sequential() 
    model %>% 
      layer_dense(units = 64, activation = 'relu', input_shape = c(4)) %>% 
      layer_dense(units= 32, activation = 'relu') %>%
      layer_dense(units = 3, activation = 'softmax') 
    
    summary(model)
    
    model %>% compile(
      loss = 'categorical_crossentropy',
      optimizer = optimizer_rmsprop(),
      metrics = c('accuracy')
    )
   
    early_stopping <- callback_early_stopping(monitor = 'val_loss', patience = 10)# het aantal epochs zonder verbetering
    history <- model %>% fit(
      x_train, y_train, 
      epochs = 200, batch_size = 5 
      ,validation_split = 0.2
      , callbacks = c(early_stopping)
    )
    
    
    model %>% evaluate(x_test, y_test)
    
    model %>% predict_classes(x_train)
    ##laatste vraag L nog doen! (is goede overgang)
  }

 #full example
{
 x <-  c(0.3,0.4,0.8,0.9, 0.2,0.2,0.5)
 y <- c(0,1, 0)
 
 a0=x
 W1= matrix(runif(7*5), ncol=7)
 Z1 = W1 %*% a0
 
 g <- function(Z){
   1/(1+exp(Z))
 }
 
 a1 = g(Z1)
 
 W2 = matrix(runif(5*3), ncol=5)
 Z2 = W2 %*% a1
 a2 = g(Z2)
 
 e <- (a2-y)
 
 g.p = function(z)
 {
   g(z)*(1-g(z))
 }
 
 d2 <- e* g.p(Z2)
 
 d1 <- (t(W2) %*% d2)*g.p(Z1)
 
 dw1 = a0 %o% d1
 dw2 = a2 %o% d2
 
 
 
}
}

#Les 6: Evaluatie Metrieken
{

  TP <- 100 # foutloos als positief
  TN <- 50 #  foutloos als negatief
  FP <- 10 # valselijk positief (Voorpeling = positief, maar is eig negatief)
  FN <- 5 # valselijk negatief (Voorspelling = negatief, maar is eig positief)
  
  TP <- 40 # foutloos als positief
  TN <- 30 #  foutloos als negatief
  FP <- 10 # valselijk positief (Voorpeling = positief, maar is eig negatief)
  FN <- 20 # valselijk negatief (Voorspelling = negatief, maar is eig positief)
  
  matrix <- matrix(c(50,10,5,100),2)
  matrix
  matrix <- matrix(c(40,20,10,30),2)
  matrix
  
  
    #accuracy 
    ACC <-  (TP+TN)/(TP+FP+TN+FN)
    ACC
  
    #precision, hoe goed is de classifier in het selecteren van TRUE Positives
    # Slechts 1 correcte positieve aanduiden zou 100% geven 1/1+99=100
    PRE <- TP/(TP+FP) 
    PR
    #RECALL, hoeveel positieve instanties (van alle positieve) kan de clasifier aanduiden
    # alles als positief categoriseren = hoogste recall 
    #RECALL = TPR= Sensitvity!
    RE <- TP/(TP+FN) #als FN naar beneden gaan, gaat Recall naar boven
    RE

    #F-measure
    R <- RE #TP/TP+FN
    P <- PR #TP/TP+FP
    a <- 0.5 # 0.5=evenwicht, a=1 of a > 1 (=b=0 of b<1) = meer precision, a=0 of a < 1 (=inf of =b>1) = recall
    b <- (1-a)/a # a <- 1/(b+1)
    F <- (b^2+ 1)*P*R/(b^2*P+R)
    F
    
    #rates
    FPR <- FP/(FP+TN)
    
    
    TPR <- TP/(TP+FN)
     
    
    #hoe hoger op de TPR curve, hoe meer er als TRUE word gezet (want er zijn minder FN), hoe MEER fouten er worden gemaakt
    50/(50+50) A
    45/(45+30) #B = Meer fouten (want minder classified als negatief)
 
    #hoe lager op de FPR curve
    # FPR = FP/FP+TP = 1-TNR (1-Specificty)
    #TNR = TN/TN+FP #alles inzetten op negative = hoogste false positive rate
    
  
     1/(1+99)
     99/(99+1)
     
     #specificity = durven in delen 
     #sensitivity = voorzichtig zijn, 
  
  
   #confusion matrix (multiclass)
  
  values <- c(2385,4,0,1,4,0,332,0,0,1,0,1,908,8,0,0,0,0,1084,9,12,0,0,6,2053)
  confusion.matrix <- matrix(values, byrow=T, ncol=5)
  colnames(confusion.matrix) <- c("Asfalt", "Beton", "Gras", "Boom", "Gebouw")
  rownames(confusion.matrix) <- colnames(confusion.matrix)
  confusion.matrix
  
  rowSums(confusion.matrix)
  colSums(confusion.matrix)
  diag(confusion.matrix)
  

  #FN etc. for a certain category (=number on the diago), T= no effect
    metrics <- function(cm,x)
  {
    TP <- cm[x,x]
    TN <- sum(cm)- cm[x,x] 
    FP <- sum(cm[x,])- cm[x,x] 
    FN <- sum(cm[,x])- cm[x,x] 
    
     r <- matrix(c(TP,TN,FP,FN))
     rownames(r) <- c("TP", "TN", "FP", "FN")
     return(r)
  }
  
  metrics(confusion.matrix, 5)

  
  #TP = confusion.matrix[3,3]
  #TN = sum(confusion.matrix)- confusion.matrix[3,3] 
  #FP = sum(confusion.matrix[3,])- confusion.matrix[3,3] 
  #FN = sum(confusion.matrix[,3])- confusion.matrix[3,3] 
  
  
 # (TP+TN)/(TP+FP+TN+FN)
  
  #accuracy function, T = no effect!
  accuracy <- function(cm, x, g=FALSE)
  {
    if(g & is.na(x))
    {
      return(sum(diag(cm)/sum(cm)))
      
    }
      else
      TP <- cm[x,x]
      TN <- sum(cm)- cm[x,x] 
      FP <- sum(cm[x,])- cm[x,x] 
      FN <- sum(cm[,x])- cm[x,x] 
      r <- (TP+TN)/(TP+FP+TN+FN)
      return(r)
        
  }
  
  accuracy(confusion.matrix, NA, g=T)
  accuracy(confusion.matrix, 3, g=F)

  
  #precision function ( PREDICTED IN ROWS!) with global
  precision <- function(cm, transpose= FALSE, g= FALSE)
  {
    if((g==T & transpose==F)|(g==T & transpose==T) ){
      ps <- diag(cm)/rowSums(cm)
      return(weighted.mean(ps, rowSums(cm)))
    }
    if(g==F & transpose==T)
    {
      return(diag(t(cm))/rowSums(t(cm)))
    }
    else
      return(diag(cm)/rowSums(cm))
  }
  
  precision(confusion.matrix, transpose= F,g= F )
  
  
  
  #recall function ( PREDICTED IN ROWS!) with global (sa)
  recall <- function(cm, transpose= FALSE, g= FALSE)
  {
    if((g==T & transpose==F)| (g==T & transpose==T)){
      ps <- diag(cm)/colSums(cm)
      return(weighted.mean(ps, colSums(cm)))
    }
    if(g==F & transpose==T)
    {
      return(diag(t(cm))/colSums(t(cm)))
    }
    else
      return(diag(matrix)/colSums(matrix))
  }
  
  recall(confusion.matrix, transpose= F,g= F )
  

  
  recall <- function(matrix, transpose= FALSE)
  {
   if(transpose)
   {
     return(diag(t(matrix))/colSums(t(matrix)))
   }
    else 
    return(diag(matrix)/colSums(matrix))
  }
  
  recall(confusion.matrix)
  
  
  #Fmeasure (T has no effect)
  fmeasure <- function(matrix, b, transpose = FALSE)
  {
      P <- diag(t(matrix))/rowSums(t(matrix))
      R <- diag(t(matrix))/colSums(t(matrix))
      F <- (b^2+ 1)*P*R/(b^2*P+R)
      return(F)
    }

  fmeasure(confusion.matrix,1)
  
 

  #ROC-curce 
  

  library("pROC")
  
  library("MASS")
   data("biopsy")
   model = lda(class~V1 + V2 + V3, data=biopsy)
   responses <- as.numeric(biopsy$class)-1 #-1 want 0&1 nodig
   predictors <- as.vector(predict(model)$x)
   
   ROC <- roc(responses, predictors, positive =0)
   plot.roc(ROC, auc.polygon=T, col="blue", identity.col="red", identity.lty=2, print.auc=T, print.thres=T)
  # -0.445 = t
  # 0.922 = TPR
  # 1-0.926 = FPR
   
   #simpsons
   
   data <- read.csv(file="simpsons_orig.csv", sep=";")
   x_train <-as.matrix(data[,3:5])

   y_train <- as.matrix(ifelse(data$Geslacht == "M", 0, 1))
   x_train<- normalize(x_train)
   
   model <- keras_model_sequential() 
   model %>% 
     layer_dense(units = 64, activation = 'relu', input_shape = c(3)) %>% #64 is hier zeer arbitrair, gebruikelijk is een waarde kiezen tussen de input & output, maar waarschijnlijk is de input hier te klein voor
     layer_dense(units = 32, activation = 'relu') %>%
     layer_dense(units= 16, activation = 'relu') %>%
     layer_dense(units = 1, activation = 'sigmoid') #sigmoid voor 0/1 te bekomen
   
   summary(model)
   
   model %>% compile(
     loss = 'binary_crossentropy',
     optimizer = optimizer_nadam(),
     metrics = c('accuracy')
   )
   
   history <- model %>% fit(
     x_train, y_train, 
     epochs = 100, batch_size = 3 
     #,validation_split = 0.2 #staat uit wegens kleine grote
   )
   model %>% predict(x_train)
   model %>% predict_classes(x_train)
   
   responses <- y_train #-1 want 0&1 nodig
   predictors <- model %>% predict(x_train)
   ROC <- roc(as.vector(responses), as.vector(predictors), positive =0)
   plot.roc(ROC, auc.polygon=T, col="blue", identity.col="red", identity.lty=2, print.auc=T, print.thres=T)
     #sensitivity= true positive rate =(recall), echte positive door alle positieve 
     # specificity = 1- false positive rate 
    
   
   predictWithCustomThreshold = function(pred, threshold) {
     ifelse(pred > threshold, 1, 0)
   }
   predictWithCustomThreshold(predictors, 0.409)
   
   #vraag 5
   require(MASS)

   data("infert")
   data <- infert
   
   infert.lda = infert
   infert.lda = infert.lda[!infert.lda$education == '0-5yrs',]
   
   infert.lda$education = droplevels(infert.lda$education)
   
   model1 = lda(education ~ ., data=infert.lda)
   model2 = lda(education ~ age + parity, data=infert.lda)
   
   responses = as.numeric(infert.lda$education)
   
   pred1 = as.vector(predict(model1)$x)
   pred2 = as.vector(predict(model2)$x)
   ROC1 = roc(responses, pred1)
   ROC2 = roc(responses, pred2)
   
   plot.roc(ROC1, print.thres = T, print.auc = T, col="red")
   plot.roc(ROC2, add = T, print.thres = T, print.auc = T, col="blue", print.auc.y = 0.2)
   
   
   # FPR=when the acctual classification is neg, how often does it incorrectly predict post
    #niets als negatief ingeven = laagste FPR 
   # TPR= when the actual classification is pos, how often does it predict pos
   
   #hoge threshold voor postief = zo laag mogelijke kans op TPR, +low FPR
   #lage threshold voor positief  = hoog kans op TRP + FPR(this needs to be close to 0)
   
}
<<<<<<< HEAD

#
{
# Define data 
p <- data$gewichten.gr. # Profits 
w <- data$waarde # Weights 
W <- 750 # Knapsack ’s capacity 
n <- length(p) # Number of items

# Define fitness function 
knapsack <- function(x) { 
  f <- sum(x * p) 
  penalty <- sum(w) * abs(sum(x * w) - W) 
  f - penalty 
}

# Run SGA
SGA <- ga(type="binary", 
          fitness=knapsack , 
          nBits=n, 
          maxiter=100, # Maximum number of generations 
          run=2000,     # Stop if the best-so-far fitness
          # hasn't improved for 'run' generations 
          popSize=100, 
          seed=202554)

x.star <- SGA@solution # Final solution: c(1, 0, 0, 1, 0, 0, 0)
sum(x.star)     # Total number of selected items: 2
sum(x.star * p) # Total profit of selected items: 15
sum(x.star * w)

b= runif(1,0,400)
objective.function = function(b) {
  l=(400-b* pi)/2
  return(-l*b)
}

sa = GenSA(par=b, 
           fn = objective.function,
           lower = 0,
           upper = 400) 

sa$par
}
=======
##################################
#####                        #####
##### LES 6 OPLOSSINGEN JENS #####
#####                        #####
##################################

## VRAAG 1

confusion.matrix = matrix(c(50, 10, 5, 100),nrow = 2, ncol = 2)
rownames(confusion.matrix) = c('Predicted NO', 'Predicted YES')
colnames(confusion.matrix) = c('Actual NO', 'Actual YES')
confusion.matrix
accuracy = function(cm, total = F) {
  sum(diag(cm)) / sum(rowSums(cm))
}
accuracy(confusion.matrix)

# precision = tp/(tp+fp)
precision = function(cm, total = F) {
  ps = diag(cm)/rowSums(cm)
  if (total == T) {
    return(weighted.mean(ps, rowSums(cm)))
  }
  return(ps)
}

precision(confusion.matrix)

# recall = tp / (tp + fn)
recall = function(cm, total = F) {
  rc = diag(cm)/colSums(cm)
  if (total == T) {
    return(weighted.mean(rc, colSums(cm)))
  }
  return (rc)
}

recall(confusion.matrix)

# f-measure
f_measure = function(cm, beta = 1, total = F) {
  (beta^2 + 1) * precision(cm) * recall(cm)/((beta^2) * precision(cm) + recall(cm))
}

f_measure(confusion.matrix, beta = 1)

# TPR = recall
# FPR = fp / (fp/tn)
fpr = function(cm) {
  diag(cm[nrow(cm):1, ]) / colSums(cm)
}

fpr(confusion.matrix)


## VRAAG 2

confusion.matrix = matrix(c(100, 0, 50, 5),nrow = 2, ncol = 2)

rownames(confusion.matrix) = c('Predicted A', 'Predicted B')
colnames(confusion.matrix) = c('Actual A', 'Actual B')

accuracy(confusion.matrix)
precision(confusion.matrix)
recall(confusion.matrix)
f_measure(confusion.matrix)

# c) precision voor A ligt vrij laag, recall en f1 heel laag voor B

## VRAAG 3

confusion.matrix = matrix(c(2385, 0, 0, 0, 12, 4, 332, 1, 0, 0, 0, 0, 908, 0, 0, 1, 0, 8, 1084, 6, 4, 1, 0, 9, 2053),nrow = 5, ncol = 5)

rownames(confusion.matrix) = c('Predicted Asfalt', 'Predicted Beton', 'Predicted Gras', 'Predicted Boom', 'Predicted Gebouw')
colnames(confusion.matrix) = c('Actual Asfalt', 'Actual Asfalt', 'Actual Gras', 'Actual Boom', 'Actual Gebouw')

precision(confusion.matrix)
recall(confusion.matrix)
f_measure(confusion.matrix)


## VRAAG 4

library(pROC)
setwd('/Users/JeBo/Documents/KdG/data-science2/6 Neurale Netwerken/datasets')
simpsons = read.csv('simpsons_orig.csv', sep=';')

x_train = normalize(as.matrix(simpsons[,3:5]))
y_train = as.matrix(ifelse(simpsons$Geslacht == 'M', 0, 1))
model = keras_model_sequential()
model %>% 
  layer_dense(units=64, activation = 'relu', input_shape = c(3)) %>% 
  layer_dense(units = 32, activation = 'relu') %>% 
  layer_dense(units=16, activation = 'relu') %>%
  layer_dense(units=1, activation = 'sigmoid')

model %>% compile(
  loss = 'binary_crossentropy',
  optimizer = optimizer_nadam(),
  metrics = c('accuracy')
)

history = model %>% fit(
  x_train, y_train,
  epochs = 1000, batch_size = 5,
  # validation_split = 0.2,
  verbose = 1
)

pred1 = model %>% predict(x_train)
pred1.class = model %>% predict_classes(x_train)
cbind(pred1,pred1.class)

ROC = roc(as.vector(y_train),as.vector(pred1)) 
#ROC2 = roc(as.vector(y_train),as.vector(pred2))

plot.roc(ROC, print.thres = T, print.auc = T, col="blue")
# plot.roc(ROC2, add=T, print.thres = T, print.auc = T, col="blue")

predictWithCustomThreshold = function(pred, threshold) {
  ifelse(pred > threshold, 1, 0)
}
predictWithCustomThreshold(pred1, 0.46)

## VRAAG 5

data("infert")
require(MASS)
require(pROC)

infert.lda = infert
infert.lda = infert.lda[!infert.lda$education == '0-5yrs',]

infert.lda$education = droplevels(infert.lda$education)

model1 = lda(education ~ ., data=infert.lda)
model2 = lda(education ~ age + parity, data=infert.lda)

responses = as.numeric(infert.lda$education)

pred1 = as.vector(predict(model1)$x)
pred2 = as.vector(predict(model2)$x)
ROC1 = roc(responses, pred1)
ROC2 = roc(responses, pred2)

plot.roc(ROC1, print.thres = T, print.auc = T, col="red")
plot.roc(ROC2, add = T, print.thres = T, print.auc = T, col="blue", print.auc.y = 0.2)


>>>>>>> d397cb781259a90f5b51d8f249a10a408d8d1ad9
