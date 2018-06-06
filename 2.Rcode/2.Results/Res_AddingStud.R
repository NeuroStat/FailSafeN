home<-paste(getwd(),"/",sep="")
setwd(home)

#####################################################
# 				Read in Data 						#
#####################################################
	# Scenario 1
		# Uncorrected
				scen1_unc_10<-read.table("scen1/FSN_unc_0.001_10_1.txt",header=FALSE)
				scen1_unc_20<-read.table("scen1/FSN_unc_0.001_20_1.txt",header=FALSE)
				scen1_unc_30<-read.table("scen1/FSN_unc_0.001_30_1.txt",header=FALSE)
		# vFWE
				scen1_vFWE_10<-read.table("scen1/FSN_FWER_0.05_10_1.txt",header=FALSE)
				scen1_vFWE_20<-read.table("scen1/FSN_FWER_0.05_20_1.txt",header=FALSE)
				scen1_vFWE_30<-read.table("scen1/FSN_FWER_0.05_30_1.txt",header=FALSE)
		# cFWE
				scen1_cFWE_10<-read.table("scen1/FSN_clunc_0.001_0.05_10_1.txt",header=FALSE)
				scen1_cFWE_20<-read.table("scen1/FSN_clunc_0.001_0.05_20_1.txt",header=FALSE)
				scen1_cFWE_30<-read.table("scen1/FSN_clunc_0.001_0.05_30_1.txt",header=FALSE)

  # Scenario 4
		# Uncorrected
				scen2_unc_10<-read.table("scen4/FSN_unc_0.001_10_4.txt",header=FALSE)
				scen2_unc_20<-read.table("scen4/FSN_unc_0.001_20_4.txt",header=FALSE)
				scen2_unc_30<-read.table("scen4/FSN_unc_0.001_30_4.txt",header=FALSE)
		# vFWE
				scen2_vFWE_10<-read.table("scen4/FSN_FWER_0.05_10_4.txt",header=FALSE)
				scen2_vFWE_20<-read.table("scen4/FSN_FWER_0.05_20_4.txt",header=FALSE)
				scen2_vFWE_30<-read.table("scen4/FSN_FWER_0.05_30_4.txt",header=FALSE)
		# cFWE
				scen2_cFWE_10<-read.table("scen4/FSN_clunc_0.001_0.05_10_4.txt",header=FALSE)
				scen2_cFWE_20<-read.table("scen4/FSN_clunc_0.001_0.05_20_4.txt",header=FALSE)
				scen2_cFWE_30<-read.table("scen4/FSN_clunc_0.001_0.05_30_4.txt",header=FALSE)

	# Scenario 5
		# Uncorrected
				scen3_unc_10<-read.table("scen3/FSN_unc_0.001_10_3.txt",header=FALSE)
				scen3_unc_20<-read.table("scen3/FSN_unc_0.001_20_3.txt",header=FALSE)
				scen3_unc_30<-read.table("scen3/FSN_unc_0.001_30_3.txt",header=FALSE)
		# vFWE
				scen3_vFWE_10<-read.table("scen5/FSN_FWER_0.05_10_5.txt",header=FALSE)
				scen3_vFWE_20<-read.table("scen5/FSN_FWER_0.05_20_5.txt",header=FALSE)
				scen3_vFWE_30<-read.table("scen5/FSN_FWER_0.05_30_5.txt",header=FALSE)
		# cFWE
				scen3_cFWE_10<-read.table("scen5/FSN_clunc_0.001_0.05_10_5.txt",header=FALSE)
				scen3_cFWE_20<-read.table("scen5/FSN_clunc_0.001_0.05_20_5.txt",header=FALSE)
				scen3_cFWE_30<-read.table("scen5/FSN_clunc_0.001_0.05_30_5.txt",header=FALSE)



FSNall<-array(data=NA,dim=c(27,1000))
	# scenario 1
		# uncorrected
			FSNall[1,1:length(scen1_unc_10[!duplicated(scen1_unc_10[,1]),2])]<-scen1_unc_10[!duplicated(scen1_unc_10[,1]),2]
			FSNall[2,1:length(scen1_unc_20[!duplicated(scen1_unc_20[,1]),2])]<-scen1_unc_20[!duplicated(scen1_unc_20[,1]),2]
			FSNall[3,1:length(scen1_unc_30[!duplicated(scen1_unc_30[,1]),2])]<-scen1_unc_30[!duplicated(scen1_unc_30[,1]),2]
		# vFWE
			FSNall[4,1:length(scen1_vFWE_10[!duplicated(scen1_vFWE_10[,1]),2])]<-scen1_vFWE_10[!duplicated(scen1_vFWE_10[,1]),2]
			FSNall[5,1:length(scen1_vFWE_20[!duplicated(scen1_vFWE_20[,1]),2])]<-scen1_vFWE_20[!duplicated(scen1_vFWE_20[,1]),2]
			FSNall[6,1:length(scen1_vFWE_30[!duplicated(scen1_vFWE_30[,1]),2])]<-scen1_vFWE_30[!duplicated(scen1_vFWE_30[,1]),2]
		# cFWE
			FSNall[7,1:length(scen1_cFWE_10[!duplicated(scen1_cFWE_10[,1]),2])]<-scen1_cFWE_10[!duplicated(scen1_cFWE_10[,1]),2]
			FSNall[8,1:length(scen1_cFWE_20[!duplicated(scen1_cFWE_20[,1]),2])]<-scen1_cFWE_20[!duplicated(scen1_cFWE_20[,1]),2]
			FSNall[9,1:length(scen1_cFWE_30[!duplicated(scen1_cFWE_30[,1]),2])]<-scen1_cFWE_30[!duplicated(scen1_cFWE_30[,1]),2]
	# scenario 2
		# uncorrected
			FSNall[10,1:length(scen2_unc_10[!duplicated(scen2_unc_10[,1]),2])]<-scen2_unc_10[!duplicated(scen2_unc_10[,1]),2]
			FSNall[11,1:length(scen2_unc_20[!duplicated(scen2_unc_20[,1]),2])]<-scen2_unc_20[!duplicated(scen2_unc_20[,1]),2]
			FSNall[12,1:length(scen2_unc_30[!duplicated(scen2_unc_30[,1]),2])]<-scen2_unc_30[!duplicated(scen2_unc_30[,1]),2]
		# vFWE
			FSNall[13,1:length(scen2_vFWE_10[!duplicated(scen2_vFWE_10[,1]),2])]<-scen2_vFWE_10[!duplicated(scen2_vFWE_10[,1]),2]
			FSNall[14,1:length(scen2_vFWE_20[!duplicated(scen2_vFWE_20[,1]),2])]<-scen2_vFWE_20[!duplicated(scen2_vFWE_20[,1]),2]
			FSNall[15,1:length(scen2_vFWE_30[!duplicated(scen2_vFWE_30[,1]),2])]<-scen2_vFWE_30[!duplicated(scen2_vFWE_30[,1]),2]
		# cFWE
			FSNall[16,1:length(scen2_cFWE_10[!duplicated(scen2_cFWE_10[,1]),2])]<-scen2_cFWE_10[!duplicated(scen2_cFWE_10[,1]),2]
			FSNall[17,1:length(scen2_cFWE_20[!duplicated(scen2_cFWE_20[,1]),2])]<-scen2_cFWE_20[!duplicated(scen2_cFWE_20[,1]),2]
			FSNall[18,1:length(scen2_cFWE_30[!duplicated(scen2_cFWE_30[,1]),2])]<-scen2_cFWE_30[!duplicated(scen2_cFWE_30[,1]),2]
	# scenario 3
		# uncorrected
			FSNall[19,1:length(scen3_unc_10[!duplicated(scen3_unc_10[,1]),2])]<-scen3_unc_10[!duplicated(scen3_unc_10[,1]),2]
			FSNall[20,1:length(scen3_unc_20[!duplicated(scen3_unc_20[,1]),2])]<-scen3_unc_20[!duplicated(scen3_unc_20[,1]),2]
			FSNall[21,1:length(scen3_unc_30[!duplicated(scen3_unc_30[,1]),2])]<-scen3_unc_30[!duplicated(scen3_unc_30[,1]),2]
		# vFWE
			FSNall[22,1:length(scen3_vFWE_10[!duplicated(scen3_vFWE_10[,1]),2])]<-scen3_vFWE_10[!duplicated(scen3_vFWE_10[,1]),2]
			FSNall[23,1:length(scen3_vFWE_20[!duplicated(scen3_vFWE_20[,1]),2])]<-scen3_vFWE_20[!duplicated(scen3_vFWE_20[,1]),2]
			FSNall[24,1:length(scen3_vFWE_30[!duplicated(scen3_vFWE_30[,1]),2])]<-scen3_vFWE_30[!duplicated(scen3_vFWE_30[,1]),2]
		# cFWE
			FSNall[25,1:length(scen3_cFWE_10[!duplicated(scen3_cFWE_10[,1]),2])]<-scen3_cFWE_10[!duplicated(scen3_cFWE_10[,1]),2]
			FSNall[26,1:length(scen3_cFWE_20[!duplicated(scen3_cFWE_20[,1]),2])]<-scen3_cFWE_20[!duplicated(scen3_cFWE_20[,1]),2]
			FSNall[27,1:length(scen3_cFWE_30[!duplicated(scen3_cFWE_30[,1]),2])]<-scen3_cFWE_30[!duplicated(scen3_cFWE_30[,1]),2]


#####################################################
# 				Compute statistics					#
#####################################################
	stats_all<-array(data=NA,dim=c(3,27))
	for (i in 1:27) {
		stats_all[1,i]<-mean(FSNall[i,],na.rm=TRUE)
		stats_all[2,i]<-sd(FSNall[i,],na.rm=TRUE)
	}

#####################################################
# 				Create plots 						#
#####################################################
scale<-1.6
scale1<-1.2
scale2<-1

databox1<-cbind(FSNall[1,],FSNall[2,],FSNall[3,],rep(NA,1000),FSNall[4,],FSNall[5,],FSNall[6,],rep(NA,1000),FSNall[7,],FSNall[8,],FSNall[9,])

jpeg('FSN_addstud_scen1.jpg',width=750,height=525)
boxplot(databox1,col=c("chocolate1","gold","cyan3","black"),ylim=c(0,100),xlim=c(1,15),axes=FALSE,xlab="Type of thresholding",ylab="y",xaxt='n',main="maximum number of studies y that can be added without altering the results, \n averaged over 1000 simulations \n Scenario1: 1 peak per study")
par(new=TRUE)
axis(1, at=c(-2,2,6,10,35,45), labels=c("","Uncorrected","vFWE","cFWE","",""))
axis(2,at=c(-5,seq(from=0,to=100,by=10)),labels=c("",seq(from=0,to=100,by=10)))
legend(13.5,100,c(expression(paste("n",phantom() %~~% phantom(),"10",sep="")),expression(paste("n",phantom() %~~% phantom(),"20",sep="")),expression(paste("n",phantom() %~~% phantom(),"30",sep=""))),lty=c(1,1),lwd=c(2.5,2.5),col=c("chocolate1","gold","cyan3"),bty="n")
dev.off()


databox2<-cbind(FSNall[10,],FSNall[11,],FSNall[12,],rep(NA,1000),FSNall[13,],FSNall[14,],FSNall[15,],rep(NA,1000),FSNall[16,],FSNall[17,],FSNall[18,])

jpeg('FSN_addstud_scen2.jpg',width=750,height=525)
boxplot(databox2,col=c("chocolate1","gold","cyan3","black"),ylim=c(0,100),xlim=c(1,15),axes=FALSE,xlab="Type of thresholding",ylab="y",xaxt='n',main="maximum number of studies y that can be added without altering the results, \n averaged over 1000 simulations \n Scenario2: 8 peaks per study")
par(new=TRUE)
axis(1, at=c(-2,2,6,10,35,45), labels=c("","Uncorrected","vFWE","cFWE","",""))
axis(2,at=c(-5,seq(from=0,to=100,by=10)),labels=c("",seq(from=0,to=100,by=10)))
legend(13.5,100,c(expression(paste("n",phantom() %~~% phantom(),"10",sep="")),expression(paste("n",phantom() %~~% phantom(),"20",sep="")),expression(paste("n",phantom() %~~% phantom(),"30",sep=""))),lty=c(1,1),lwd=c(2.5,2.5),col=c("chocolate1","gold","cyan3"),bty="n")
dev.off()


databox3<-cbind(FSNall[19,],FSNall[20,],FSNall[21,],rep(NA,1000),FSNall[22,],FSNall[23,],FSNall[24,],rep(NA,1000),FSNall[25,],FSNall[26,],FSNall[27,])

jpeg('FSN_addstud_scen3.jpg',width=750,height=525)
boxplot(databox3,col=c("chocolate1","gold","cyan3","black"),ylim=c(0,100),xlim=c(1,15),axes=FALSE,xlab="Type of thresholding",ylab="y",xaxt='n',main="maximum number of studies y that can be added without altering the results, \n averaged over 1000 simulations \n Scenario3: random number of peaks per study")
par(new=TRUE)
axis(1, at=c(-2,2,6,10,35,45), labels=c("","Uncorrected","vFWE","cFWE","",""))
axis(2,at=c(-5,seq(from=0,to=100,by=10)),labels=c("",seq(from=0,to=100,by=10)))
legend(13.5,100,c(expression(paste("n",phantom() %~~% phantom(),"10",sep="")),expression(paste("n",phantom() %~~% phantom(),"20",sep="")),expression(paste("n",phantom() %~~% phantom(),"30",sep=""))),lty=c(1,1),lwd=c(2.5,2.5),col=c("chocolate1","gold","cyan3"),bty="n")
dev.off()


