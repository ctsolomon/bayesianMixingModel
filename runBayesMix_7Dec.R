#Identical to runBayesMix_3Nov except that change codaPkg argument
#in bugs() call to FALSE, so that bugs output is directly accessible

runBayesMix_7Dec <- function(sourceData,sourceDataVar,consData,wTotPriorPars,wCompoundVar,DeltaTotPriorPars,nChains=5,nIter=10000,debug=F)
{

library(arm)

originalDir <- getwd()
#setwd('J:/WinBugsTemp')
setwd('C:/Users/csolom7/Documents/WinBugsTemp')

##
#Organize details of WinBugs run

#Rename consumer data
dXObs <- consData

#Number of consumer samples, sources, isotopes
nSamples <- dim(dXObs)[1]
nSrc <- 3
nIso <- 3

#List of inputs to WinBugs script
dataIn <- vector("list",9)
names(dataIn) <- c("sourceData","sourceDataVar","dXObs","nSamples","nSrc","nIso","wTotPriorPars","wCompoundVar","DeltaTotPriorPars")
dataIn[[1]] <- as.matrix(sourceData)
dataIn[[2]] <- as.matrix(sourceDataVar)
dataIn[[3]] <- dXObs
dataIn[4] <- nSamples
dataIn[5] <- nSrc
dataIn[6] <- nIso
dataIn[[7]] <- as.vector(wTotPriorPars)
dataIn[8] <- wCompoundVar
dataIn[[9]] <- as.vector(DeltaTotPriorPars)

#List of parameters to monitor
paramList <- c("f","wTot","DeltaTot","residSd")

#Name of model file
bugsModelName <- 'mixBayesCLR_29Oct.bug'

##
#Fit WinBugs model
bugsOut <- bugs(dataIn,inits=NULL,paramList,bugsModelName,
                 n.chains=nChains,n.iter=nIter,n.burnin=500,n.thin=50,
                 program="openbugs",codaPkg=F,debug=debug)

#Set wd back to what it was
setwd(originalDir)

#Return bugsOut
return(bugsOut)

}
