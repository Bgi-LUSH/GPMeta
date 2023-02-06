data1 <- read.table("threads1.txt",header = T ,sep="\t")
data2 <- read.table("threads2.txt",header = T ,sep="\t")

library(ggplot2)
library("ggsci")
library(grid)
library(ggpubr)
library(reshape2)

da1<-melt(data1,id.vars=c("threads"))
da1$variable=factor(da1$variable,levels=c("Bowtie2","Bwa"))
da2<-melt(data2,id.vars=c("threads"))
da2$variable=factor(da2$variable,levels=c("Bowtie2","Bwa","Kraken2","Centrifuge"))




p1<- ggplot(da1)+
	geom_line(aes(x=threads,y=value,color=variable,group=variable),size=1)+
	geom_point(aes(x=threads,y=value,color=variable ),size=2)+	
	#theme_bw()+	
	#theme(panel.grid.major=element_blank(),panel.grid.minor = element_blank())+
	#theme(panel.border= element_rect(size=1,colour="black"))+
	ggtitle("Alignerment to Human DB")+ 
	theme(plot.title = element_text(hjust = "0.5",face="bold"))+ 
	labs(fill="")+
	xlab("")+
	ylab("Time-Consumming (s)")+
	#ylim(95,100)+
	theme(axis.title.y= element_text(size=10, color="black", face= "bold", vjust=0.5, hjust=0.5))+
	theme(axis.text.y= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
	theme(axis.text.x= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
scale_color_nejm()

p2<- ggplot(da2)+
	geom_line(aes(x=threads,y=value,color=variable ,group=variable),size=1)+	
	geom_point(aes(x=threads,y=value,color=variable ),size=2)+
	#theme_bw()+	
	#theme(panel.grid.major=element_blank(),panel.grid.minor = element_blank())+
	#theme(panel.border= element_rect(size=1,colour="black"))+
	ggtitle("")+ 
	theme(plot.title = element_text(hjust = "0.5",face="bold"))+ 
	labs(fill="")+
	xlab("")+
	#ylab("Time-Consumming (s)")+
	ylab("")+
	theme(axis.title.y= element_text(size=10, color="black", face= "bold", vjust=0.5, hjust=0.5))+
	theme(axis.text.y= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
	theme(axis.text.x= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
	scale_color_nejm()+
	coord_cartesian(ylim = c(0,100))

p3<- ggplot(da2)+
	geom_line(aes(x=threads,y=value,color=variable,group=variable ),size=1)+
	geom_point(aes(x=threads,y=value,color=variable ),size=2)+	
	#theme(panel.grid.major=element_blank(),panel.grid.minor = element_blank())+
  	theme(axis.text.x = element_blank(),axis.ticks.x = element_blank()) +
	labs(x=NULL,y=NULL,fill=NULL)+
	ggtitle("")+ 
	theme(plot.title = element_text(hjust = "0.5",face="bold"))+ 
	#xlab("")+
	#ylab("Time-Consumming (s)")+
theme(axis.text.y= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
	scale_color_nejm()+
	coord_cartesian(ylim = c(300,700)) #+  #设置上面一半的值域
 	#scale_y_continuous(breaks = c(300,700,100)) #以5为单位划分Y轴

p4<- ggplot(da2)+
	geom_line(aes(x=threads,y=value,color=variable ,group=variable),size=1)+	
	geom_point(aes(x=threads,y=value,color=variable ),size=2)+
	#theme(panel.grid.major=element_blank(),panel.grid.minor = element_blank())+
  	theme(axis.text.x = element_blank(),axis.ticks.x = element_blank()) +
	labs(x=NULL,y=NULL,fill=NULL)+
	ggtitle("Alignerment to refseq DB")+ 
	theme(plot.title = element_text(hjust = "0.5",face="bold"))+ 
	xlab("")+
	#ylab("Time-Consumming (s)")+
	#ylim(95,100)+
	theme(axis.text.y= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
	scale_color_nejm()+
	coord_cartesian(ylim = c(1000,3100)) #+  #设置上面一半的值域
 	#scale_y_continuous(breaks = c(1000,3100,500)) #以5为单位划分Y轴

ggarrange(p4,p3,p2,heights=c(1,1,1),ncol = 1, nrow = 3,
	common.legend = TRUE,legend="right",align = "v")

#ggarrange(p1, p2,p3,
        #  labels = c("A", "B"),
         # ncol = 2, nrow = 1)
