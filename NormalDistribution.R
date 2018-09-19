# P(Z)=?, pnorm(q,mean=0,sd=1,lower.tail=TRUE). lower.tail=> Left tail
# Stand Normal N(μ=0,σ=1)
# ex1: P(0<=Z<=1.96)=?,N(μ=0,σ=1). 
pnorm(1.96) - pnorm(0) #0.4750
# ex2: P(-1.81<=Z<=1.81)=?,N(μ=0,σ=1)
pnorm(1.81) - pnorm(-1.81) #0.9297
# ex3: P(0.53<=Z<=2.42)=?,N(μ=0,σ=1)
pnorm(2.42) - pnorm(0.53) #0.2903
# ex4: P(Z>=-0.36)=?,N(μ=0,σ=1). no Left tail
pnorm(-0.36,lower.tail = FALSE) #0.6405764

# Normal Distribution N(μ=value,σ=value)
# ex1: P(11<=X<=13.6)=?,N(μ=10,σ=2).
pnorm(13.6,mean=10,sd=2) - pnorm(11,mean=10,sd=2) #0.2726072
# ex2: P(X>12)=?,N(μ=10,σ=2). no Left tail
pnorm(12,mean=10,sd=2, lower.tail = FALSE) #0.1586553
# ex3: P(36<=X<=40)=?,N(μ=38.5,σ=2.5).
pnorm(40,mean=38.5,sd=2.5) - pnorm(36,mean=38.5,sd=2.5) # 0.5670916

# P(?)=value, qnorm(p,mean=0,se=1,lower.tail=TRUE). lower.tail=> Left tail
# ex1: P(Z<C)=0.95,N(μ=0,σ=1). C?
qnorm(0.95) # 1.644854
# ex2: P(Z>C)=0.7019,N(μ=0,σ=1). C? no Left tail
qnorm(0.7019,lower.tail = FALSE) # -0.529873
# ex3: P(Z>C)=0.1379,N(μ=0,σ=1). C? no Left tail
qnorm(0.1379,lower.tail = FALSE) # 1.089803
# ex4: P(Z<C)=0.0110,N(μ=0,σ=1). C?
qnorm(0.0110) # -2.290368


# Check Normal Distribution
#Data <- scan() # input data
Data <- c(0.88,0.95,0.72,1.39,0.81,0.88,0.94,1.12,0.69,0.95,0.98,1.29,1.54,0.87,1.09,0.87,0.69,0.89,0.96,1.15,
          1.26,1.18,0.85,0.87,0.76,0.95,0.64, 1.1,0.95,0.96,1.09,1.15,   1,0.93,1.32,1.24,1.07,1.03,0.89,1.09,
          1.04,0.95,0.72,1.21,1.02, 1.1,1.12,0.94,1.15,1.34,0.98,0.74,1.28,1.16,0.99, 1.4,0.95,1.06,0.96,0.99,
           1.2,0.77,0.79, 1.1,1.28,1.13,1.06,0.83,0.76,0.67,1.1,1.42,0.88,1.04,0.97)
# hist Graphics
hist(Data)

# normal quantile-quantile plot
qqnorm(Data)
qqline(Data,col="red")

# Chi-Sauare Goodness-of-fi Test => p-value > 0.05
chisq.test(Data) # X-squared = 2.7513, df = 74, p-value = 1
pearson.test(Data) # P = 9.32, p-value = 0.4083

# K-S(Kolmogorov-Smirnov) => p-value>0.05
lillie.test(Data) # D = 0.070261, p-value = 0.4775

# A-D(Anderson-Darling normality test) => p-value > 0.05
install.packages("nortest")
library(nortest)
ad.test(Data) # A = 0.31376, p-value = 0.5391
