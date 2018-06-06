###########################################################################
#                         The Fail-Safe N                                 #
#                                                                         #
#                                                                         #
# This code computes the FSN of a meta-analysis of fMRI studies. The FSN  #
# is the number of studies that do not report activation in a certain re- #
# gion that can be added to an existing meta-analysis before the target   #
# region is no longer statistically significant.                          #
#                                                                         #
# The FSN is calculated for meta-analyses with 3 real studies with each   #
# one peak that reports activation around MNI coordinate (46,-66,-6).     #
# Null studies report one peak at the other side of the brain. For seven  #
# thresholding methods and three different average sample sizes 1000      #
# simulated data sets are used to determine the average FSN for that con- #
# dition.                                                                 #
###########################################################################


###########################################
# Preamble - define variables and functions
###########################################
    # define directories
        home<-paste(getwd(),"/",sep="")
        save<-paste(home,"save/",sep="")
        dataraw<-paste(home,"DataRaw/",sep="")
        alldata<-paste(home,"simstudies_Grey10_1/",sep="")
        results<-paste(home,"ALE/",sep="")
        image<-paste(home,"ALE/Results/",sep="")
        setwd(home)

    # packages
    require(oro.nifti,quietly=FALSE)
    require(gdata)

    # variables
    varppnc<-c(10)
    threshunc<-("0.001")
    threshcl<-("0.05")

    nrst<-3                         # (mean) number of studies with "real activation" simulated
    naddst<-100                     # (mean) number of studies with random activation simulated
    minvol<-200                     # mininmum volume (in mm^3) of a significant cluster

 
###########################################
# Read in studies (with 100 null studies)
###########################################
    # read simulated studies, output: file with coordinates and number of participants per study
    seeds<-c(1:1000)
    for (seed in seeds) {
        for (varppn in varppnc) {
            tryCatch({

          print(paste("seed=",seed,", varppn=",varppn,sep=""))
            
            setwd(alldata)

            name<-paste(nrst,"+",naddst,"stud-",seed,"_",varppn,sep="")                             # name file
            nametxt<-paste0(name,".txt")                # file with foci
            
            foci.info <- array(NA,dim=c(1,5))
            colnames(foci.info) <- c("X","Y","Z","N","S")
            tempfoci <- array(NA,dim=c(1,3))
            foci.raw<-read.table(nametxt,header=FALSE,fill=TRUE)
            nfoci<-1
                for(i in 1:50000){
                    S <- i
                    N <- as.numeric(gsub("\\D", "", x=foci.raw[3,1]))
                       
                    for(j in 4:500){
                        if(is.na(foci.raw[j,3])) 
                          break
                          if(j==500)
                          cat("Warning: more then 500 foci were found in 1 study")
                        }

                        nfoci[i]<-j-4

                        tempfoci <- foci.raw[4:c(j-1),,]
                        names(tempfoci) <- c("X","Y","Z")
                        foci.info <- rbind(foci.info,cbind(tempfoci,N,S))
                        foci.raw <- foci.raw[-(1:(j-1)),,]
                          
                          if(dim(foci.raw)[1]==0)
                          break
                          if(i==50000)
                          cat("Warning: more then 50000 studies were included in the meta-analysis")
                      }

            foci.info <- na.omit(foci.info)
            allst<-foci.info
           

        ###########################################
        # Perform ALE analyses
        ###########################################
                setwd(dataraw)
                diff<-c(25,13,7,4,2,1,1)                # amount of null-studies that need to be added or subtracted to get to the FSN
                tempadd<-50                             # starting point for FSN
                FSNtest<-array(data=c(rep(NA,100),0),dim=101)

                for (j in 1:length(diff)) {
                if(tempadd==101) break
                if(tempadd<0)break
                print(paste("seed = ",seed,", nullst = ",tempadd,sep=""))

                  # write to txt-file for ALE-analysis, preparation
                  file<-array(data=NA,dim=c((100*(nrst+tempadd)),1))
                  row<-1
                  for (i in 1:(nrst+tempadd)) {
                    nfoci<-length(which(allst[,5]==i))
                    file[row,1]<-"//Reference=MNI"
                    file[(row+1),1]<-ifelse(i<nrst+1,paste("//Exp",i,"-real",sep=""),paste("//Exp",i,"-nullst",sep=""))
                    file[(row+2),1]<-paste("//Subjects=",foci.info[which(foci.info[,5]==i),4][1],sep="")
                    file[((row+3):(row+2+nfoci)),1]<-paste(allst[min(which(allst[,5]==i)):max(which(allst[,5]==i)),1]," ",allst[min(which(allst[,5]==i)):max(which(allst[,5]==i)),2]," ",allst[min(which(allst[,5]==i)):max(which(allst[,5]==i)),3],sep="")
                    file[(row+3+nfoci),1]<-paste(" ",sep="")
                    row<-row+4+nfoci
                  }

                file<-file[!is.na(file[,1]),1]
                
                    # write to text-file
                    setwd(home)
                    system("rm -r ALE")
                    system("rm DataMatlab/ALEPeaks.mat")
                    setwd(dataraw)
                    write.table(file,"ALEPeaks.txt",quote=FALSE,row.names=FALSE,col.names=FALSE)
                    
                    # name variables
                    nameFSN<-paste(nrst,"+",tempadd,"stud-",seed,"_",varppn,sep="")
                    nametxtFSN<-paste(nrst,"+",tempadd,"stud-",seed,"_",varppn,".txt",sep="")

                    # perform ALE
                    setwd(home)
                    system(paste("/Applications/MATLAB_R2015b.app/bin/matlab -nodisplay -nosplash -nodesktop -r FSN",sep=""))

                    # is the target cluster present? 
                    setwd(image)
                    imagename<-system("ls FSNmat_cFWE05_001*",intern=TRUE)
                    clustermap <- readNIfTI(imagename, verbose=FALSE, warn=-1, reorient=TRUE, call=NULL)
                    FSNtest[tempadd]<-clustermap[23,31,34]

                    # determine significance target area + reach conclusion (add null, remove null, quit loop)
                    ifelse(FSNtest[tempadd]==0, (ifelse(tempadd==0,break,tempadd<-tempadd-diff[j])), tempadd<-tempadd+diff[j])
                    setwd(home)
                    system("rm -r ALE")
                    system("rm DataMatlab/ALEPeaks.mat")
                }
            }, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})

###########################################
# Save results
###########################################
    FSNseed<-ifelse(is.na(FSNtest[50]),NA,min(which(FSNtest==0))-1)           # FSN van elke seed opslaan

    setwd(save)
    percrs<-nrst/(FSNseed+nrst)
    write.table(cbind(seed,FSNseed,percrs),paste("FSN_clunc_",threshunc,"_",threshcl,"_",varppn,"_1.txt", sep=""),quote=FALSE,row.names=FALSE,col.names=FALSE,append=TRUE)
}}



