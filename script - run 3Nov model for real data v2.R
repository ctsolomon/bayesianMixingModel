#Run UNDERC data through CLR version of model
#4 Nov 2009
#Updated 9 Sept 2010 during revisions for Ecology


#Load scripts
source('runBayesMix_7Dec.R')
source('summarizeResults2.R')
source('calcPriorPars.R')

#Read consumer data
consData <- read.table('consDataAll.txt',header=T,sep="\t")

#Read in source data
dataCrampton <- read.csv('sourceIsotopesSquare_Crampton.csv',row.names=1)
dataCramptonVar <- read.csv('sourceIsotopesSquareVar_Crampton.csv',row.names=1)


##
#Run model for each consumer

#Crampton chiro 1m
outName <- 'Crampton chiro 1m'
consDataSub <- consData[consData$lake=="Crampton" & consData$taxonGroup=="Chironomidae" & consData$depthGroup==1,]
consDataSub
consDataIn <- as.matrix(consDataSub[,c("d13C","d15N","dD")])
priorPars <- calcPriorPars(TLVec=c(1.5,0.1^2),wVec=c(0.25,0.1^2),epsNVec=c(2.52,1.46^2))
bugsOut <- runBayesMix_7Dec(dataCrampton,dataCramptonVar,consDataIn,priorPars$wTotPriorPars,priorPars$wCompoundVar,priorPars$DeltaTotPriorPars,nIter=10000,debug=F)
summarizeResults2(bugsOut,outName,priorPars$wTotPriorPars,priorPars$DeltaTotPriorPars)

#Crampton Odonata 1m
outName <- 'Crampton Odanata 1m'
consDataSub <- consData[consData$lake=="Crampton" & consData$taxonGroup=="Odanata" & consData$depthGroup==1,]
consDataSub
consDataIn <- as.matrix(consDataSub[,c("d13C","d15N","dD")])
priorPars <- calcPriorPars(TLVec=c(2,0.1^2),wVec=c(0.25,0.1^2),epsNVec=c(2.52,1.46^2))
bugsOut <- runBayesMix_7Dec(dataCrampton,dataCramptonVar,consDataIn,priorPars$wTotPriorPars,priorPars$wCompoundVar,priorPars$DeltaTotPriorPars,nIter=10000,debug=F)
summarizeResults2(bugsOut,outName,priorPars$wTotPriorPars,priorPars$DeltaTotPriorPars)

#Crampton zoop
outName <- 'Crampton zoop'
consDataSub <- consData[consData$lake=="Crampton" & consData$taxonGroup=="zoop",]
consDataSub
consDataIn <- as.matrix(consDataSub[,c("d13C","d15N","dD")])
priorPars <- calcPriorPars(TLVec=c(1.5,0.1^2),wVec=c(0.25,0.1^2),epsNVec=c(2.52,1.46^2))
bugsOut <- runBayesMix_7Dec(dataCrampton,dataCramptonVar,consDataIn,priorPars$wTotPriorPars,priorPars$wCompoundVar,priorPars$DeltaTotPriorPars,nIter=10000,debug=F)
summarizeResults2(bugsOut,outName,priorPars$wTotPriorPars,priorPars$DeltaTotPriorPars)

#Crampton Chaoborus
outName <- 'Crampton Chaoborus'
consDataSub <- consData[consData$lake=="Crampton" & consData$taxonGroup=="Chaoborus",]
consDataSub
consDataIn <- as.matrix(consDataSub[,c("d13C","d15N","dD")])
priorPars <- calcPriorPars(TLVec=c(2,0.1^2),wVec=c(0.25,0.1^2),epsNVec=c(2.52,1.46^2))
bugsOut <- runBayesMix_7Dec(dataCrampton,dataCramptonVar,consDataIn,priorPars$wTotPriorPars,priorPars$wCompoundVar,priorPars$DeltaTotPriorPars,nIter=10000,debug=F)
summarizeResults2(bugsOut,outName,priorPars$wTotPriorPars,priorPars$DeltaTotPriorPars)

#Crampton BLG
outName <- 'Crampton BLG'
consDataSub <- consData[consData$lake=="Crampton" & consData$taxonGroup=="fish 1",]
consDataSub
consDataIn <- as.matrix(consDataSub[,c("d13C","d15N","dD")])
priorPars <- calcPriorPars(TLVec=c(2.5,0.1^2),wVec=c(0.25,0.1^2),epsNVec=c(2.52,1.46^2))
bugsOut <- runBayesMix_7Dec(dataCrampton,dataCramptonVar,consDataIn,priorPars$wTotPriorPars,priorPars$wCompoundVar,priorPars$DeltaTotPriorPars,nIter=10000,debug=F)
summarizeResults2(bugsOut,outName,priorPars$wTotPriorPars,priorPars$DeltaTotPriorPars)

#Crampton LMB adult
outName <- 'Crampton LMB adult'
consDataSub <- consData[consData$lake=="Crampton" & consData$taxonGroup=="fish 2",]
consDataSub
consDataIn <- as.matrix(consDataSub[,c("d13C","d15N","dD")])
priorPars <- calcPriorPars(TLVec=c(3.5,0.1^2),wVec=c(0.25,0.1^2),epsNVec=c(2.52,1.46^2))
bugsOut <- runBayesMix_7Dec(dataCrampton,dataCramptonVar,consDataIn,priorPars$wTotPriorPars,priorPars$wCompoundVar,priorPars$DeltaTotPriorPars,nIter=10000,debug=F)
summarizeResults2(bugsOut,outName,priorPars$wTotPriorPars,priorPars$DeltaTotPriorPars)

