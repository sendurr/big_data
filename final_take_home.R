#***********************************
#*  Problem 1                      *
#***********************************
# Set environmental variables
Sys.setenv(HADOOP_CMD="/usr/bin/hadoop")
Sys.setenv(HADOOP_STREAMING="/usr/hdp/2.3.0.0-2557/hadoop-mapreduce/hadoop-streaming-2.7.1.2.3.0.0-2557.jar")

# Load the following packages in the following order
library(rhdfs)
library(rmr2)

# initialize the connection from rstudio to hadoop
hdfs.init()

# Doing simple mapreduce on airline data
# Our map function which returns the keyval < airline, departure delay>
map1 = function(k,flights) {  
  return ( keyval(as.character(flights[[9]]),as.numeric(flights[[16]])))
}

# Our reduce function which mean departure delay for each airline
reduce1 = function(airline, delay) {
  keyval(airline, mean(delay,na.rm=TRUE))
}

# Our mapreduce function which invokes map1 and reduce1 and parses
# the input file expected it to be comma delimited
mr1 = function(input, output = NULL) {
  mapreduce(input = input,
            output = output,
            input.format = make.input.format("csv", sep=","),
            map = map1,
            reduce = reduce1)}

# Set up the input definition (small dataset) and output definition
hdfs.root = '/user/share/student'
hdfs.data = file.path(hdfs.root,'wholeEnchilada.csv')
hdfs.out = file.path(hdfs.root,'out1')

# Invoke out mapreduce job
out = mr1(hdfs.data, hdfs.out)

# Fetch the results from HDFS and coerce into a dataframe
results = from.dfs(out)
results.df = as.data.frame(results, stringsAsFactors=F)

# add column heading to dataframe
colnames(results.df) = c('Carrier', 'Delay')

# Display results
x=results.df[order(-results.df$Delay),]
x[1:20,]


#***********************************
#*  Problem 2                      *
#***********************************

map2 = function(k,flights) {  
#  return ( keyval(as.character(flights[[9]]),flights[[16]]))
  pair=paste(as.character(flights[[9]]), as.character(flights[[17]]), sep="-")
  return ( keyval(pair,as.numeric(flights[[16]]))) 
}

# Our reduce function which finds the largest taxin time for each destination airports
reduce2 = function(car_airport, delay) {
  keyval(car_airport, mean(delay,na.rm=TRUE))
}

# Our mapreduce function which invokes map1 and reduce1 and parses
# the input file expected it to be comma delimited
mr2 = function(input, output = NULL) {
  mapreduce(input = input,
            output = output,
            input.format = make.input.format("csv", sep=","),
            map = map2,
            reduce = reduce2)}

# Set up the input definition (small dataset) and output definition
hdfs.root = '/user/share/student'
hdfs.data = file.path(hdfs.root,'wholeEnchilada.csv')
hdfs.out = file.path(hdfs.root,'out2')

# Invoke out mapreduce job
out = mr2(hdfs.data, hdfs.out)

# Fetch the results from HDFS and coerce into a dataframe
results = from.dfs(out)
results.df = as.data.frame(results, stringsAsFactors=F)

# add column heading to dataframe
colnames(results.df) = c('Carrier/Airport', 'Delay')

# Display results
x=results.df[order(-results.df$Delay),]
x[1:20,]

