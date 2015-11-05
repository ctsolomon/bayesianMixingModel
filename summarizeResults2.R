#Summarize bugs results
#3 Nov 2009

summarizeResults2 <- function(bugsOut,outName,wTotPriorPars,DeltaTotPriorPars,knownPars=NULL)
{

library(plotrix)

#Read in results from coda files
#readBugsOut <- read.bugs(codaList,quiet=T)
#bugsOut <- as.data.frame(as.matrix(readBugsOut))

#Save results of WinBugs model
#Complete results
dput(bugsOut,paste('bugsOut_',outName,'.txt',sep=""))
#Summary of results
summaryOut <- print(bugsOut)
dput(summaryOut,file=paste('bugsOut_',outName,' summary.txt',sep=""))


##
#Plots

if (is.null(knownPars)==TRUE)
  {

  #Plot ternary plot
  pdf(file=paste('plotTernary ',outName,'.pdf',sep=""), width=8.5,height=11,title=NULL)
  triax.plot(bugsOut$sims.matrix[,1:3],show.grid=T,axis.labels=c("Terrestrial","Pelagic","Littoral"))
  dev.off(dev.cur())

  #Plot priors and posteriors of source proportions (i.e. same data as ternary plot)
  #  as well as wTot and DeltaTot
  pdf(file=paste('plots ',outName,'.pdf',sep=""), width=8.5,height=11,title=NULL)
  par(mfcol=c(3,2),mar=c(4.1,2.1,1.1,1.1),oma=c(1,1,0,0)+0.1,mgp=c(2.5,0.5,0))
  fgrad <- seq(0,1,length.out=51)
  #fT
  hist(bugsOut$sims.matrix[,"f[1]"],breaks=fgrad,main="",xlab="fT",axes=F,cex.main=0.8)#xlab='',ylab='',cex.axis=1.5,cex.lab=1.5)
  axis(1, at=seq(0,1,0.2),labels=F); axis(2, cex.axis=1)
  #fP
  hist(bugsOut$sims.matrix[,"f[2]"],breaks=fgrad,main="",xlab="fP",axes=F,cex.main=0.8,ylab="Frequency")#xlab='',ylab='',cex.axis=1.5,cex.lab=1.5)
  axis(1, at=seq(0,1,0.2),labels=F); axis(2, cex.axis=1)
  #fL
  hist(bugsOut$sims.matrix[,"f[3]"],breaks=fgrad,main="",xlab="fL",axes=F,cex.main=0.8)#xlab='',ylab='',cex.axis=1.5,cex.lab=1.5)
  axis(1, at=seq(0,1,0.2),labels=T); axis(2, cex.axis=1)
  #wCompound prior (line) and posterior (hist)
  xRange <- c(0,1)
  fgrad <- seq(xRange[1],xRange[2],length.out=51)
  x <- seq(xRange[1],xRange[2],(xRange[2]-xRange[1])/1000)
  wPrior <- dbeta(x,wTotPriorPars[1],wTotPriorPars[2])
  yLims <- c(0,max(hist(bugsOut$sims.matrix[,"wTot"],breaks=fgrad,plot=F)$density))
  plot(wPrior~x,xlim=c(0,1),ylim=yLims,type="l",col="gray",xlab="wTot",ylab="Denisty",cex.main=0.8,axes=F)
  axis(1, cex.axis=0.8); axis(2, cex.axis=0.8)
  hist(bugsOut$sims.matrix[,"wTot"],freq=F,xlim=c(0,1),breaks=fgrad,add=T)
  #DeltaTot prior (line) and posterior (hist)
  xRange <- range(bugsOut$sims.matrix[,"DeltaTot"])
  fgrad <- seq(xRange[1],xRange[2],length.out=51)
  x <- seq(xRange[1],xRange[2],(xRange[2]-xRange[1])/1000)
  DeltaNPrior <- dnorm(x,DeltaTotPriorPars[1],sqrt(1/DeltaTotPriorPars[2]))
  yLims <- c(0,max(hist(bugsOut$sims.matrix[,"DeltaTot"],breaks=fgrad,plot=F)$density))
  plot(DeltaNPrior~x,ylim=yLims,type="l",col="gray",xlab="DeltaTot",ylab="Density",cex.main=0.8,axes=F)
  axis(1, cex.axis=0.8); axis(2, cex.axis=0.8)
  hist(bugsOut$sims.matrix[,"DeltaTot"],freq=F,breaks=fgrad,add=T)
  
  dev.off(dev.cur())
  
  } else
 
#If want to use this part below, need to update bugsOut to be bugsOut$simsMatrix
#with appropriate columns, as above
if (is.null(knownPars)==FALSE)
  {
  
  #Plot ternary plot
  pdf(file=paste('plotTernary ',outName,'.pdf',sep=""), width=8.5,height=11,title=NULL)
  triax.plot(bugsOut[,3:5],show.grid=T,no.add=FALSE,axis.labels=c("Terrestrial","Pelagic","Littoral"))
  triax.points(knownPars[[1]],pch="*",col="red",cex=4)
  dev.off(dev.cur())

  #Plot priors and posteriors of source proportions (i.e. same data as ternary plot)
  #  as well as wTot and DeltaTot
  pdf(file=paste('plots ',outName,'.pdf',sep=""), width=8.5,height=11,title=NULL)
  par(mfcol=c(3,2),mar=c(4.1,2.1,1.1,1.1),oma=c(1,1,0,0)+0.1,mgp=c(2.5,0.5,0))
  fgrad <- seq(0,1,length.out=51)
  #fT
  hist(bugsOut[,"f[1]"],breaks=fgrad,main="",xlab="fT",axes=F,cex.main=0.8)#xlab='',ylab='',cex.axis=1.5,cex.lab=1.5)
  axis(1, at=seq(0,1,0.2),labels=F); axis(2, cex.axis=1)
  points(knownPars[[1]][1],0,pch="*",col="red")
  #fP
  hist(bugsOut[,"f[2]"],breaks=fgrad,main="",xlab="fP",axes=F,cex.main=0.8,ylab="Frequency")#xlab='',ylab='',cex.axis=1.5,cex.lab=1.5)
  axis(1, at=seq(0,1,0.2),labels=F); axis(2, cex.axis=1)
  points(knownPars[[1]][2],0,pch="*",col="red")
  #fL
  hist(bugsOut[,"f[3]"],breaks=fgrad,main="",xlab="fL",axes=F,cex.main=0.8)#xlab='',ylab='',cex.axis=1.5,cex.lab=1.5)
  axis(1, at=seq(0,1,0.2),labels=T); axis(2, cex.axis=1)
  points(knownPars[[1]][3],0,pch="*",col="red")
  #wCompound prior (line) and posterior (hist)
  xRange <- c(0,1)
  fgrad <- seq(xRange[1],xRange[2],length.out=51)
  x <- seq(xRange[1],xRange[2],(xRange[2]-xRange[1])/1000)
  wPrior <- dbeta(x,wTotPriorPars[1],wTotPriorPars[2])
  yLims <- c(0,max(hist(bugsOut$wTot,breaks=fgrad,plot=F)$density))
  plot(wPrior~x,xlim=c(0,1),ylim=yLims,type="l",col="gray",xlab="wTot",ylab="Denisty",cex.main=0.8,axes=F)
  axis(1, cex.axis=0.8); axis(2, cex.axis=0.8)
  hist(bugsOut$wTot,freq=F,xlim=c(0,1),breaks=fgrad,add=T)
  points(knownPars[[2]],0,pch="*",col="red")
  #DeltaTot prior (line) and posterior (hist)
  xRange <- range(bugsOut[,"DeltaTot"])
  fgrad <- seq(xRange[1],xRange[2],length.out=51)
  x <- seq(xRange[1],xRange[2],(xRange[2]-xRange[1])/1000)
  DeltaNPrior <- dnorm(x,DeltaTotPriorPars[1],sqrt(1/DeltaTotPriorPars[2]))
  yLims <- c(0,max(hist(bugsOut$DeltaTot,breaks=fgrad,plot=F)$density))
  plot(DeltaNPrior~x,ylim=yLims,type="l",col="gray",xlab="DeltaTot",ylab="Density",cex.main=0.8,axes=F)
  axis(1, cex.axis=0.8); axis(2, cex.axis=0.8)
  hist(bugsOut$DeltaTot,freq=F,breaks=fgrad,add=T)
  points(knownPars[[3]],0,pch="*",col="red")

  dev.off(dev.cur())

  }

}
