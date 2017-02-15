library(boot) #load the package
# Now we need the function we would like to estimate
# In our case the beta:
dat <- data.frame(x = rnorm(10, 30, .2), y = runif(10, 3, 5))

betfun = function(data,b,formula){  
  # b is the random indexes for the bootstrap sample
  d = data[b,] 
  return(lm(d[,1]~d[,2], data = d)$coef[2])  
  # thats for the beta coefficient
}
# now you can bootstrap:
bootbet = boot(data=dat, statistic=betfun, R=5000) 
# R is how many bootstrap samples
names(bootbet)
plot(bootbet)
hist(bootbet$t, breaks = 100)


zoombot = boot.array(bootbet, indices = T)
dim(zoombot)
hist(zoombot[1,], breaks = 100) 

nb = 5000 ; bet = NULL ; n = NROW(dat)
ptm <- proc.time() # have a look at the time it takes
for (i in 1:nb){
  unifnum = sample(c(1:n),n,replace = T)	# pick random indices
  bet[i] = lm(data[unifnum,1]~data[unifnum,2])$coef[2]
}
proc.time() - ptm # about 80 seconds on my end