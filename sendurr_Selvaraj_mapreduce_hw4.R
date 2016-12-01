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
# Our map function which returns the keyval <origin airport, cancellations>
map1 = function(k,flights) {  
  return ( keyval(as.character(flights[[17]]),flights[[22]]))
}

# Our reduce function which sums up the cancelled flights at each origin airport
reduce1 = function(origin, counts) {
  keyval(origin, sum(counts,na.rm=TRUE))
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
hdfs.data = file.path(hdfs.root,'test_25K.csv')
hdfs.out = file.path(hdfs.root,'out1')

# Invoke out mapreduce job
out = mr1(hdfs.data, hdfs.out)

# Fetch the results from HDFS and coerce into a dataframe
results = from.dfs(out)
results.df = as.data.frame(results, stringsAsFactors=F)

# add column heading to dataframe
colnames(results.df) = c('Origin', 'Canceled')

# Display results
results.df

#***********************************
#*  Problem 2                      *
#***********************************

map2 = function(k,flights) {  
  return ( keyval(as.character(flights[[18]]),flights[[20]]))
}

# Our reduce function which finds the largest taxin time for each destination airports
reduce2 = function(origin, counts) {
  keyval(origin, max(counts,na.rm=TRUE))
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
hdfs.data = file.path(hdfs.root,'test_25K.csv')
hdfs.out = file.path(hdfs.root,'out2')

# Invoke out mapreduce job
out = mr2(hdfs.data, hdfs.out)

# Fetch the results from HDFS and coerce into a dataframe
results = from.dfs(out)
results.df = as.data.frame(results, stringsAsFactors=F)

# add column heading to dataframe
colnames(results.df) = c('Airport', 'Max Taxi In')

# Display results
results.df

