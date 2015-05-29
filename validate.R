# Load raw data
sc.raw <- read.csv('selfcaredata.csv')

# select 10% of data set for validating
n <- nrow(sc.raw)
sc.val <- sc.raw[sample(1:n, ceiling(n/10)),]

# Present each selected row and ask to validate
numRows <- nrow(sc.val)
numCorrect <- 0
for (i in 1:numRows){
    print(sc.val[i,])
    
}