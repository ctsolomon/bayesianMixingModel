# bayesianMixingModel
Code (R and OpenBUGS) and data to run a Bayesian stable isotope mixing model for food web analysis. From Solomon et al. 2011 Ecology 92:1115-1125, DOI:10.1890/10-1185.1.

We used this code to do the analyses described in the paper cited above. I have also included some of the data from that paper, which allows you to run the code pretty much as-is, and also get a sense of how the code wants the data to be formatted. When we wrote this code we were using WinBUGS, but that WinBUGS code runs in OpenBUGS too.

A quick overview of the code: The main wrapper script which calls everything else is 'script - run 3Nov model for real data v2.R'. So you should open this first and then follow it as it calls the other scripts. The actual mixing model is in the WinBugs code in 'mixBayesCLR_29Oct.bug'. You may have to change some filepaths in order to get the code to run - for instance, the 'runBayesMix_7Dec.R' script points WinBugs towards a particular filepath, different from where the rest of the files are, in order to find the WinBugs script. This was a hack workaround because WinBugs seemed to choke when we gave it a long filepath - so maybe you could do away with it.

We spent a long time developing and testing this code. Please use it and modify it, but please cite the paper above and reference this repository when you do so!
