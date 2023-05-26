library(tidyverse)

#Question 1
ans_1a <- 1:20
ans_1b <- 20:1
ans_1c <- c(ans_1a,ans_1b[-1])
ans_1d <- c(4,6,3)
tmp <- ans_1d

ans_1e <- rep(tmp, times=10)
ans_1f <- rep(tmp, length.out=31)
ans_1g <- rep(tmp, c(10,20,30))

#Question 2
tmp <- seq(3,6,.1)
ans_2 <- exp(tmp)*cos(tmp)

#Question 3
tmp <- 3*(1:12)
tmp1 <- tmp-2
ans_3a <- (.1^tmp)*(.2^tmp1)

tmp <- 1:25
ans_3b <- 2^tmp/tmp

#Question 4
tmp <- 10:100
ans_4a <- sum(tmp^3+4*tmp^2)
tmp <- 1:25
ans_4b <- sum(2^tmp/tmp+3^tmp/tmp^2)

#Question 5
ans_5a <- paste('label',1:30)
ans_5b <- paste('fn',1:30, sep='')

#Question 6
set.seed(50)
xVec <- sample(0:999, 250, replace=T)
yVec <- sample(0:999, 250, replace=T)

ans_6a <- yVec[2:250]-xVec[1:249]
ans_6b <- sin(yVec[1:249])/cos(xVec[2:250])
ans_6c <- xVec[1:248]+2*xVec[2:249]-xVec[3:250]
ans_6d <- sum(exp(-xVec[2:250])/(xVec[1:249]+10))

#Question 7
ans_7a <- yVec[yVec>600]
ans_7b <- which(yVec>600)
ans_7c <- xVec[ans_7b]
ans_7d <- sqrt(abs(xVec-mean(xVec)))
ans_7e <- length(yVec[yVec>=max(yVec)-200])
ans_7f <- length(xVec[xVec%%2 == 0])
ans_7g <- xVec[order(yVec)]
ans_7h <- yVec[seq(1,250,3)]

#Question 8
ans_8 <- sum(cumprod(2*(1:19)/(2*(1:19)+1)))+1
