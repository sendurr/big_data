
pdf ("Sendurr_Selvaraj_lab1.pdf", width =6 , height =6)

# histogram
data <- read.csv("https://cse.sc.edu/~rose/587/CSV/ALbb.salaries.2003.csv")
data
x=data[,3]/1000000
hist(x,main="Salaries of all players in the American league",xlab="Salaries in millions of dollars.",ylab="No of Players")

# lowest salary
low_salary = min(x)
data_low_salary=data[data$Salary<=low_salary*1000000,]
title=paste("There are",nrow(data_low_salary),"players who have minimum salary of ",low_salary,"million.")
title
data_low_salary
abline ( v=low_salary , col ="red ", lwd =3)

# find millionaires
data_million=data[data$Salary>=1000000,]
title=paste("There are",nrow(data_million),"players who are millionaires.")
title
data_million
abline ( v=1 , col ="red ", lwd =3)

#find salary more than 10 million
data_high_salary=data[data$Salary>=10000000,]
title=paste("There are",nrow(data_high_salary),"players who earn more than 10 million.")
title
data_high_salary
abline ( v=10 , col ="red ", lwd =3)

# extract yankees
yankees = data[data$Team=="New York Yankees",]
yankees

# extract oakland
oakland = data[data$Team=="Oakland Athletics",]
oakland

# extract yankees team salary
yankees_salary =sum(yankees$Salary)
output=paste("The total salary of team yankees is ",yankees_salary)
output

# extract oakland team salary
oakland_salary =sum(oakland$Salary)
output=paste("The total salary of team oakland is ",oakland_salary)
output

# extract highest salary of yankees team
yankees_high_salary =yankees[which.max(yankees$Salary),]
output=paste("The highest salary of team yankees is ")
output
yankees_high_salary

# extract highest salary of oakland team
oakland_high_salary =oakland[which.max(oakland$Salary),]
output=paste("The highest salary of team oakland is ")
output
oakland_high_salary

# extract average salaries of yankees team
yankees_avg_salary =mean(yankees$Salary)
output=paste("The highest salary of team yankees is ",yankees_avg_salary)
output

# extract average salaries of oakland team
oakland_avg_salary =mean(oakland$Salary)
output=paste("The highest salary of team oakland is ",oakland_avg_salary)
output

# extract millionaires of yankees team
yankees_million_salary =yankees[yankees$Salary>=1000000,]
output=paste("There are ",nrow(yankees_million_salary)," millionaires in yankees.")
output
yankees_million_salary

# extract millionaires of oakland team
oakland_million_salary =oakland[oakland$Salary>=1000000,]
output=paste("There are ",nrow(oakland_million_salary)," millionaires in oakland")
output
oakland_million_salary

# histogram of yankees team
x=yankees[,3]/1000000
hist(x,main="Salaries of all players in yankees team",xlab="Salaries in millions of dollars.",ylab="No of Players")

# histogram of oakland team
x=oakland[,3]/1000000
hist(x,main="Salaries of all players in oakland team",xlab="Salaries in millions of dollars.",ylab="No of Players")

dev.off()
