library("ggplot2")
library("gplots")
ImmGenData$GeneSymbol <- as.character(ImmGenData$GeneSymbol)
ImmGenData$Description <- as.character(ImmGenData$Description)
row.names(ImmGenData) = make.unique(ImmGenData[,2])
#View(ImmGenData)
heatmap=ImmGenData[1:10000,c(4,6:9)]
#View(heatmap)
hm_matrix<-data.matrix(heatmap)
colsample=c('FOB_Sp','MZB_Sp','B1a_Sp','B1b_PC','B1a_PC')
breaks=c(seq(10, 100, by=1),seq(100,1000,by=10))
#View(breaks)
#lwid = c(1.5,0.3)
#lhei = c(1.2,0.05,7)
#lmat = rbind(c(0,4),c(0,3),c(2,1))
mycol <- colorpanel(n=length(breaks)-1,low="green",mid="black",high="red")
#nf <- layout(matrix(c(1,2,3),1,3, byrow=T))
heatmap.2(hm_matrix,
          col=mycol,
          #lmat =lmat,  #layout arrangement
          #lwid = lwid, #layout width
          #lhei =lhei,  #layout height
          trace="none",
          Colv=FALSE, # colum cluster off
          dendrogram = "none",
          labCol=colsample,
          labRow='',
          srtRow = NULL,
          srtCol = 90,
          density.info="none",
          cexCol=1.5, #column label size
          #cexRow=1.5, #row label size
          symm=F,symkey=F,symbreaks=T, 
          scale="none",
          keysize=1,
          #key.xlab='Fold Change',
          breaks=breaks,
          margins=c(8,8) # heatmap down and right margins
          )
