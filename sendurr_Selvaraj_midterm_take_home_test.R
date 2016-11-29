#***** Part 1: Setting up the data. *******#
library(titanic)
titanic_train
s= factor(titanic_train[,2])
titanic_train[,2] = s
subset_temp = titanic_train[,c( 2, 3, 5, 6, 7, 8)]
test_set = subset_temp[c(1:291),]
test_set
train_set = subset_temp[c(292:891),]
train_set

#***** Part 2: Naive Bayes Analysis of the titanic dataset  *******#
library(e1071)
m1 <-naiveBayes(train_set[,2:6],train_set[,1])
table(predict(m1,train_set[,2:6]),train_set[,1])

m2 <-naiveBayes(test_set[,2:6],test_set[,1])
table(predict(m2,test_set[,2:6]),test_set[,1])

#***** Part 3: Decision Tree Analysis of the titanic dataset   *******#
library(rpart)
tree1 <-rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch, method = "class",
              data=train_set, control =rpart.control(minsplit=2, cp=0.002))
tree1
table(predict(tree1,train_set[,2:6],type="class"),train_set[,1])

tree2 <-rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch, method = "class",
              data=test_set, control =rpart.control(minsplit=2, cp=0.002))
tree2
table(predict(tree2,test_set[,2:6],type="class"),test_set[,1])

#***** Part 4: Graduate Students Only: Comparison of Part 2 & Part 3 results   *******#

plot(tree1, uniform=TRUE, main="Classification Tree for Titanic Training Dataset")
text(tree1, use.n=TRUE, all=TRUE, cex=.7)

plot(tree2, uniform=TRUE, main="Classification Tree for Titanic Test Dataset")
text(tree2, use.n=TRUE, all=TRUE, cex=.7)


