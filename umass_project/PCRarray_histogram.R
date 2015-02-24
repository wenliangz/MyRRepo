library("ggplot2")
PCRarray <- Change
PCRarray[,4:5]<-log2(Change[,2:3])
PCRarray$FOB<-1
PCRarray$FC<-PCRarray$aged/PCRarray$young
#View(PCRarray)
row.names(PCRarray) = PCRarray[,1]
heatmap=PCRarray[PCRarray$FC>2 | PCRarray$FC < 0.5,6:7]
#View(heatmap)
heatmap$FCdown <- ifelse(heatmap$FC > 1, heatmap$FC, -(1/heatmap$FC))
heatmap$genes<-rownames(heatmap)
heatmap$colour <- ifelse(heatmap$FCdown < 0,"steelblue", "firebrick1")
qplot(genes, FCdown, data = heatmap, 
      geom = "bar",
      fill=colour,
      stat="identity",
      ylim=c(-55,55),
      main = "Genes more than 2-fold changes",
      xlab = "Genes", ylab = "Fold Change")+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5,hjust = 1))

ggplot(heatmap,aes(x=genes,y=FCdown))+geom_bar(binwidth=1)+
  geom_bar(stat="identity",position="identity",aes(fill = colour))+
  ggtitle("Gene Expression(ABC relative to FOB)")+
  xlab("Genes")+
  ylab("Fold Change")+
 scale_fill_discrete(name="Regulation",labels=c("Up", "Down"))+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5,hjust = 1,size=13,color="black"))+
theme(axis.text.y = element_text(size=13,color="black"), 
#plot appearance
plot.title = element_text(lineheight=3, face="bold", color="black", size=29),
#axis appearance
axis.text.x = element_text(angle = 90, vjust = 0.5,hjust = 1,size=18,color="black"),
axis.text.y = element_text(size=18,color="black"), 
axis.title=element_text(size=20,face="bold"),
#legend appearance
legend.title = element_text(colour="black",size=16, face="bold"),
legend.text = element_text(colour="black", size=16, face = "bold"))

