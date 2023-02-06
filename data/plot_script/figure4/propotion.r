data <- read.table("rate.txt",header = T ,sep="\t")
da<- melt(data,id.vars=c("species"))
da$value<-da$value*100

library(ggplot2)
library("ggsci")
library(grid)
library(reshape2)
library(plyr)

da$variable=factor(da$variable,levels=c("Reported_Proportion","GPMeta","Bowtie2","Bwa","Kraken2","Centrifuge"))
da$species=factor(da$species,levels=da$species[1:10])
#da$variable=factor(da$variable,levels=rev(c("Reported_Proportion","GPMeta","Bowtie2","Bwa","Kraken2","Centrifuge")))
#da$species=factor(da$species,levels=rev(da$species[1:10]))


p1<-ggplot(da,aes(x=species,y=value,fill=variable)) + #guides(fill=FALSE)+
      #geom_bar(stat="identity",position="stack")+
	geom_bar(stat="identity", position=position_dodge())+
	theme_bw()+	
	#theme(panel.grid.major=element_blank(),panel.grid.minor = element_blank())+
	theme(panel.border= element_rect(size=1,colour="black"))+
	theme(legend.text=element_text(color="black", size=10),
        legend.background=element_blank(),
        #legend.position ='right')+
	  legend.position ='top')+
  	ggtitle("")+theme(plot.title = element_text(hjust = "0.5",face="bold"))+
	labs(fill="")+
	xlab("")+
  	ylab("Proportion (%)")+
	theme(axis.title.y= element_text(size=10, color="black", face= "bold", vjust=0.5, hjust=0.5))+
	theme(axis.text.y= element_text(size=9, color="black",face="bold"))+
	#theme(axis.text.x= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
	theme(axis.text.x= element_text(size=9, color="black",face="bold",angle=20, vjust=1, hjust=1))+
	#scale_fill_nejm()
	scale_fill_manual(values=c("grey","#BC3C29FF", "#0072B5FF", "#E18727FF", "#20854EFF", "#7876B1FF" )) 
	#scale_fill_manual(values=rev(c("grey","#BC3C29FF", "#0072B5FF", "#E18727FF", "#20854EFF", "#7876B1FF" ))) 

p1+theme(plot.margin=unit(c(0,1,0,4),'lines')) #unit中设置页边距大小，数值分别为上、右、下、左页边距，lines为单位。
#p1 +coord_flip()