# Load raw data
sc.raw <- read.csv('selfcaredata.csv')

# select 10% of data set for validating
n <- nrow(sc.raw)
sc.val <- sc.raw[sample(1:n, ceiling(n/10)),]

# Present each selected row and ask to validate
numRows <- nrow(sc.val)
totalData <- numRows * dim(sc.val)[2]
numCorrect <- 0
numErrors <- 0
for (i in 1:numRows){
    rowErrors <- 0
   
    print(sc.val[i,1:20])
    err <- readline('Number of errors (1): ')
    rowErrors <- rowErrors + as.numeric(err)

    print(sc.val[i,21:40])
    err <- readline('Number of errors (2): ')
    rowErrors <- rowErrors + as.numeric(err)

    print(sc.val[i,41:61])
    err <- readline('Number of errors (3): ')
    rowErrors <- rowErrors + as.numeric(err)
    
    numErrors <- numErrors + rowErrors
    numCorrect <- numCorrect + 1*(rowErrors==0)
}

cat(numCorrect, 'correct out of', numRows,'rows.\n')
cat(numErrors/totalData, 'datum accuracy.\n')