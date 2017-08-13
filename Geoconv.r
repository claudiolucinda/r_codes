install.packages("sp")
install.packages("rgdal")

library(sp)
library(rgdal)


setwd("C:\\Users\\ClaudioLucinda\\Google Drive\\Dissertação_ Camila")


coords<-read.table("Coordenadas2.txt",sep="\t",header=TRUE)


#Function
LongLatToUTM<-function(x,y,zone){
  xy <- data.frame(ID = 1:length(x), X = x, Y = y)
  coordinates(xy) <- c("X", "Y")
  proj4string(xy) <- CRS("+proj=longlat +datum=GGRS87")  ## for example
  res <- spTransform(xy, CRS(paste("+proj=utm +zone=",zone," ellps=GGRS87",sep='')))
  return(as.data.frame(res))
}

# Example
#x<-c( -94.99729,-94.99726,-94.99457,-94.99458,-94.99729)
#y<-c( 29.17112, 29.17107, 29.17273, 29.17278, 29.17112)
j<-LongLatToUTM(coords[,1],coords[,2],23)
write.table(j,file="CoordsUTM.txt",row.names=T, sep="\t")