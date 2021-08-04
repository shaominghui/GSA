
fatch.dir = "./"
load(paste(fatch.dir,"chr.info.Rdata",sep=""))
TAI_Threshold = 11000000

cal.LOH <- function(final_result){
	final_result[(final_result[,"nA"]==0|final_result[,"nB"]==0) & 
                 final_result[,"nA"]!=final_result[,"nB"] &
                 (final_result[,"loc.end"]-final_result[,"loc.start"])>15000000, ]
}

cal_disnum <- function(LST){
  if (nrow(LST)>1){
    distance <- c()
    for (i in 1:nrow(LST)-1){
      distance[i] <- ifelse(LST[i+1,1]==LST[i,1],LST[i+1,2]-LST[i,3],Inf)
    }
    dis1 <- distance[which(diff(LST[,4])==0)]
    return(length(which(dis1<3000000)))
  }
  else {return(0)}
}

cal.LST <- function(final_result){
  LST <- data.frame(out$final_result[,c("Chr","loc.start","loc.end")],
                    rowSums(out$final_result[,c("nA","nB")]))
  disnum <- cal_disnum(LST)
  if(length(which(is.na(LST[,4]))) != 0){
    LST <- LST[-which(is.na(LST[,4])),]
  }
  while(disnum!=0){
    if(nrow(LST)>1){
      j=1
      while(j<nrow(LST)){
        if(LST[j,1]==LST[j+1,1] & LST[j,4]==LST[j+1,4] & 
           (LST[j+1,2]-LST[j,3])<3000000){
          LST[j+1,2]<-LST[j,2]
          LST<-LST[-j,]
        }
        else{j=j+1}
      }
    }
    LST<-LST[which((LST[,3]-LST[,2])>3000000),]
    if (nrow(LST)>1){
      disnum <- cal_disnum(LST)
    }
  }
  colnames(LST)<-c("Chr","loc.start","loc.end","CN")
  as.data.frame(LST[(LST[,3]-LST[,2])>10000000 & LST[,4]!=2,])
}


cal.TAI <- function(final_result){
  TAI <- final_result[,c("Chr","id","loc.start","loc.end","nA","nB")]
  TAI <- TAI[TAI[,5] != TAI[,6] & (TAI[,4] - TAI[,3]) > TAI_Threshold,]
  mat <- data.frame()
  if(nrow(TAI)!=0){
    for(i in 1:nrow(TAI)){
      ch <- TAI[i,"Chr"]
      if(TAI[i,3]<500000 & TAI[i,4]<chr.info[ch,"cen.start"])
      {
        tel.pos <- 500000 - TAI[i,3]
        mat <- rbind(mat,data.frame(TAI[i,],tel.pos))
      }
      if(TAI[i,3]>chr.info[ch,"cen.end"] & TAI[i,4]>(chr.info[ch,"tpos"]-500000))
      {
        tel.pos <- chr.info[ch,"tpos"] - TAI[i,4]
        mat <- rbind(mat,data.frame(TAI[i,],tel.pos))
      }
    }		
  }
  mat
}

cal.HRD <- function(LOH,LST,TAI,ploidy){
  LOH+LST+TAI-15.5*ploidy
}

segment <- read.table("demo.segmentation.txt",sep="\t",header=T)
ploidy <- read.table("demo.purity_ploidy.txt",sep="\t",header=T)

out=list()
out$LOH <- cal.LOH(segment)
out$LST <- cal.LST(segment)
out$TAI <- cal.TAI(segment)
out$ploidy <- ploidy$ploidy
out$HRDScore <- cal.HRD(nrow(out$LOH),nrow(out$LST),nrow(out$TAI),out$ploidy)




