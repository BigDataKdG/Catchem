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

#Les 1: kansverdelingen & kansen
{

##binom verdeling
#vragen over repetitieve experimenten

dbinom(x,n,p)
#x= aantal keer de uitkomst (exact!) voor 
#n= aantal keer herhaling
#p= de kans 

# voor ranges 
pbinom(x,n,p) #minder dan
1- pbinom(x,n,p) #meer dan


#gemiddelde aantal gebeurtenis, gegeven kans
# mu = n*p

##Poissionverdeling
# als een gebeurtenis verschilende keren voorkomt

dpois(x,mu)
#x = antal keren dat het voorkomt
#mu = aantal keren het gemiddeld voorkomt

#voor ranges 
1-ppois(x,mu)
ppois(x,mu)


#formules
mu = n*p #verwachte waarden binom
sqrt(n*p(1-p)) # verwachte standaard afwijking binom

sigma = sqrt(mean) #verwachte standaard afwijking Pois

#normaal verdeling
dnorm(x, mean=, sd=) #specifieke waarde
pnorm(x, mean=, sd=) #cummulatieve 

1- pnorm(x, mean=, sd=) # > exacte waarde
pnorm(x, mean=, sd=)# < exacte waarde
pnorm(x, mean=0, sd=1)-pnorm(x, mean=0,sd=1)#tussen 2 waarden
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
X$statistic
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


pnorm(x, mean=, sd=)# kans op een bepaalde waarde
qnorm(0.99, mean=, sd=) #lengte gegeven een bepaalde kans 

pt(x, df=)
qt(x, df=)

#intervals met normale verdeling
##als sigma gekend is of grote steekproef --> Z TEST
#op basis van een steekproef iets zeggen over de populatie
# b = gewenste betrouwbaarheid
b= 0.99 
f = qnorm((1+b)/2) #factor op basis van zekerheid
m = 11.9#mean(x)
s = 1 #sd(x)
n = 100
links = m - f * s / sqrt(n) 
rechts = m + f * s / sqrt(n)
links
rechts

#of
a <- 1-b
m + c(-1,1)*qnorm(1-a/2)*s/sqrt(n) #zekerheid dat populatie gemiddelde tussen deze twee grenzen ligt


#testen normaal (standaard afwijking niet gekend)
#kunnen we een bewering over de populatie weerleggen adhv steekproef?
n <- 100
m <- 12
mo <- 11.9
s <- 0.1
z = (mo-m) / (s / sqrt(n)) #z = (mo-m) / s * sqrt(n)
p <- pnorm(z) * 2
p


#Z-test eenzijdig
m <- -0.545
mo <-  -0.539 
s <- 0.008
n <- 5
z <- (mo-m)/(s/sqrt(n)) #Z-score die hoort bij deze specifieke waarde
z<- pnorm(-abs(z)) #-abs is de waarde 1-, voor een rechter test?
z

#of
p <- pnorm(mo, mean = m, sd= s/sqrt(n))
1-p

qnorm(0.1, mean= -0.545, sd=0.008/sqrt(5), lower.tail=FALSE) #vinden van kritieke waarde (alles wat boven/onder ligt )


# T intervallen

#f =factor
#m = mean
# n= sample
# b = betrouwbaarheid
# s = standaard afwijking
m <- 11.9
b <- 0.99
a <- 0.01
n <- 100
f <- qt((1+b)/2, n-1) #qt(1-a/2, n-1)
s <- 1
links = m - f * s / sqrt(n) 
rechts = m + f * s / sqrt(n)
links
rechts

#testen t TOETS
n <- 100
m <- 12
mo <- 11.9
s <- 1
t = (mo-m) / (s/sqrt(n)) #t = (mo-m) / s *sqrt(n)
p <- pt(-abs(t), n-1) *2
p

#???t-test eenzijdig
n <- 5
m <- -0.545
mo <- -0.539
s <- 0.008
t = (mo-m) / (s/sqrt(n)) #t = (mo-m) / s *sqrt(n)
p <- pt(-abs(t), n-1)
p


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
}

#Les 3: genetische Algoritmen
{
library("GA")
library("GenSA")


data <- read.csv(file="Knapsack Items.csv", sep=";")


#knapsack problem with SA

# Define data 
p <- data$gewichten.gr. # Profits 
w <- data$waarde # Weights 
W <- 750 # Knapsack ???s capacity 
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
sum(x.star * w) # Total weight of selected items: 9


#knapsack problem with GENSA

p <- data$gewichten.gr. # Profits 
w <- data$waarde # Weights 
W <- 750 # Knapsack ???s capacity 
n <- length(p) # Number of items


x = sample(c(0,1),size = n, replace = T) #set a first at random to be optimized 

knapsack <- function(x) { 
  f <- sum(x * p) 
  penalty <- sum(w) * abs(sum(x * w) - W) 
  f - penalty 
}

# Run GenSA
SA = GenSA(par = x, fn = knapsack, lower = rep(0,n), upper = rep(1,n))
x.star = round(SA$par)

print(x.star)
print(sum(x.star)) # Total number of selected items
print(sum(x.star * p)) # Total profit of selected items
print(sum(x.star * w)) # Total weight of selected items

###the traveling salesman problem

# Define data 
p <- data$gewichten.gr. # Profits 
w <- data$waarde # Weights 
W <- 750 # Knapsack ???s capacity 
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

#Les 4: discriminant analyse
{
library("MASS")

#aantal dimensies = 
 # - aantal categorie??n afhank - 1
 # - aantal indep 
 # = minimum van deze twee

lda(groep ~ x1 +x2 + X3, data = data)
data("biopsy")
lda(class ~ V1 + V2 + V3, data=biopsy)
summary(glm(class ~ V1 + V2 + V4 ,family=binomial(link='logit'),data=biopsy))


#oef 1
library("DiscriMiner")
data("bordeaux")

m1 <- lda(quality ~ temperature + sun + heat + rain, data = bordeaux)
plot(m1)
predict(m1)$Class

vergelijk <- table(bordeaux$quality, predict(m1)$class)
#2 dimensisies 
# de individuele waarden, op 2 dimensies, gebruik makend van de functies

#oef 2
data("birthwt")

str(birthwt)

#low, race, smoke, hypertension, uterine (tho depending on how you look at ftw: max 6)
# all other variables

m1 <- lda(low ~ age + lwt + ptl + ftv, data = birthwt)
#1
plot(m1)


#oef3
data("Cars93")

str(Cars93)
data1 <- Cars93[1:90,]
data2 <- Cars93[91:93,]

#everything factor except model & make
#the rest, except for min,max price
 m1 <- lda(Type ~ Price + MPG.city + MPG.highway  + EngineSize + Horsepower + 
             RPM + Rev.per.mile + Fuel.tank.capacity + Passengers + Length +Wheelbase + Width + Turn.circle + 
             Rear.seat.room + Luggage.room + Weight, data = Cars93)
 # 4 (want van is empty)
 
 predict(m1,data2)
 # 91 = 1, 92 = 1, 93=3 (Enkel 1 klopt niet
 
 # les 4 PCA
 
 data <- read.csv(file="Protein.csv")
 
 data1 <- data[, -(c(1,2,3,13)) ]
 rownames(data1) <- data[,1]
 
 
 cor(data1)
 #ja goede corr
 
 result = prcomp(data1, scale.= TRUE, center = TRUE) #rank. = kan je ook ingeven hoeveel compo weer te geven
 summary(result)
 
 corr(data1)
 mean(abs(cor(data1)))
 
 # 5 PCA
 result$rotation #nuts weegt door
 biplot(result)
 install.packages("devtools")
 library("devtools")
 install_github("vqv/ggbiplot") #werkt niet
 
 library("ggbiplot")
 
 PCApredictoren = data.frame(predict(result)[,1:3])
 
 clusters <- hclust(dist(PCApredictoren))
 plot(clusters)
 
 #oef2
goblet <- read.csv(file="goblets.csv", sep=";")
goblet1 <- goblet[, -1 ]
rownames(goblet1) <- goblet[,1]
result = prcomp(goblet1, scale.= TRUE, center = TRUE)
summary(result)
plot(result)
biplot(result)

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
      epochs = 100, batch_size = 3 
      ,validation_split = 0.2
      , callbacks = c(early_stopping)
    )
    
    
  }
}








#Les 6: Evaluatie Metrieken
{
  #cheat
   # Sensitivity = RECALL = TPR
   # Specifciity = 1-FPR 
  
  
 #in carret package?
   #confusion matrix
  
  values <- c(2385,4,0,1,4,0,332,0,0,1,0,1,908,8,0,0,0,0,1084,9,12,0,0,6,2053)
  confusion.matrix <- matrix(values, byrow=T, ncol=5)
  colnames(confusion.matrix) <- c("Asfalt", "Beton", "Gras", "Boom", "Gebouw")
  rownames(confusion.matrix) <- colnames(confusion.matrix)
  confusion.matrix
  
  rowSums(confusion.matrix)
  colSums(confusion.matrix)
  diag(confusion.matrix)
  
  #precisions for all classes
  diag(confusion.matrix)/rowSums(confusion.matrix)
  
  #recalls 
  diag(confusion.matrix)/colSums(confusion.matrix)
  
  #accuract
  sum(diag(confusion.matrix))/sum(confusion.matrix)
  
  accuracy <- function(cm)
  {
    sum(diag(cm)/sum(cm))
  }
  
  accuracy(confusion.matrix)

  precision <- function(cm)
  {
    ps <- diag(cm)/rowSums(cm)
    return(ps)
   }
  
  precision(confusion.matrix)
  
  precision <- function(cm,g = FALSE)
  {
    ps <- diag(cm)/rowSums(cm)
    if(g){
      return(weighted.mean(ps, rowSums(cm)))
    }
    
  }
  
  precision(confusion.matrix, g= TRUE )
  
  #de rest ook in functies zetten!
  
  #Fmeasure
  
  
  #ROC-curce 
  
  install.packages("pROC")
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
   
   
  
  
  
}
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


