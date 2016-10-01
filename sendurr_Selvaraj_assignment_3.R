data = read.csv("/Users/Sendurr/Dropbox/Transfer/CSCE587 - Big Data/gold_target1.csv")
summary(data)
y=data[,1]
x=data[,2]
x
y
plot(y~x,main="As level vs Sb level")
m=lm(y~x)
str(m)
print(m)
par(mfrow=c(2,2))
plot(m)


ypred=predict(m)
par(mfrow=c(1,1))
plot(y,ytype='l',xlab="observed y", ylab='predicted y')
points(y,ypred)


y=data[,4]
x=data[,1]
x
y
plot(y~x,main=" Gold deposit proximity vs As level")

y=data[,4]
x=data[,2]
x
y
plot(y~x,main=" Gold deposit proximity vs Sb level")
