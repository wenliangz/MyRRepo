library("gplots")
PCRarray <- Change
PCRarray[,4:5]<-log2(Change[,2:3])
PCRarray$FOB<-1
PCRarray$FC<-PCRarray$aged/PCRarray$young
View(PCRarray)
row.names(PCRarray) = PCRarray[,1]
heatmap=PCRarray[PCRarray$FC>2 | PCRarray$FC < 0.5,6:7]
hm_matrix<-data.matrix(heatmap)
colsample=c('FOB','ABC')
breaks=c(seq(0.1, 1, by=0.05),seq(1,10,by=0.5))
#View(breaks)
lwid = c(1.5,0.3)
lhei = c(1.2,0.05,7)
lmat = rbind(c(0,4),c(0,3),c(2,1))
mycol <- colorpanel(n=length(breaks)-1,low="green",mid="black",high="red")
nf <- layout(matrix(c(1,2,3),1,3, byrow=T))
heatmap.2(hm_matrix,
          col=mycol,
          lmat =lmat,  #layout arrangement
          lwid = lwid, #layout width
          lhei =lhei,  #layout height
          trace="none",
          Colv=FALSE, # colum cluster off
          dendrogram = "none",
          labCol=colsample,
          density.info="none",
          cexCol=1.5, #column label size
          cexRow=1.5, #row label size
          symm=F,symkey=F,symbreaks=T, 
          scale="none",
          keysize=1,
          key.xlab='Fold Change',
          breaks=breaks,
          margins=c(8,8) # heatmap down and right margins)
