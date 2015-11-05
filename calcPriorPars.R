#Calculate prior pars for runBayesMix_3Nov
#CTS 4 Nov 2009

calcPriorPars <- function(TLVec,wVec,epsNVec)
{

#Inputs are
#  TLVec: Mean and variance of estimated TL (as levels above primary producer)
#  wVec: Mean and variance of estimated water contribution
#  epsNVec: Mean and variance of estimated trophic fractionation of N

#Assumption about TL
TL <- TLVec[1]
TLVar <- TLVec[2]

#Calculate params of beta prior for wTot
w <- wVec[1]
wVar <- wVec[2]
#Calculate point estimate of wCompound, and var by error prop
wCompound <- 1-(1-w)^TL
wCompoundVar <- TL*(1-w)^(TL-1)*wVar - (1-w)^TL*log(1-w)*TLVar
#Convert to parameters of beta
par1 <- -wCompound*(wCompound^2 - wCompound + wCompoundVar)/wCompoundVar
par2 <- (wCompound-1)*(wCompound^2 - wCompound +wCompoundVar)/wCompoundVar
wTotPriorPars <- c(par1,par2)

#Calculate params of normal prior for DeltaTot
#Assumption about epsN: mean and var of 40 estimates for ammonotelic orgs, Vanderklift and Ponsard 2003
epsN <- epsNVec[1]
epsNVar <- epsNVec[2]
#Calculate point estimate of DeltaTot, and var (actually precision) by error prop
DeltaTot <- epsN*TL
DeltaTotVar <- TL^2*epsNVar+epsN^2*TLVar
DeltaTotPrec <- 1 / DeltaTotVar
DeltaTotPriorPars <- c(DeltaTot,DeltaTotPrec)

#Assemble output
dataOut <- list(wTotPriorPars=wTotPriorPars,wCompoundVar=wCompoundVar,DeltaTotPriorPars=DeltaTotPriorPars)

#Return dataOut
return(dataOut)

}
