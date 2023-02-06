
data1 <- read.table("host-h.txt",header = T ,sep="\t")
data2 <- read.table("host-p.txt",header = T ,sep="\t")
data3 <- read.table("precision.txt",header = T ,sep="\t")
data4 <- read.table("recall.txt",header = T ,sep="\t")

library(ggplot2)
library("ggsci")
library(grid)
library(ggpubr)
library(reshape2)

#data$size=factor(data$size,levels=c("1.28M","12.8M","25.6M","111.8M"))
dat1<-melt(data1)
dat1$variable=factor(dat1$variable,levels=c("GPMeta","Bowtie2","Bwa"))
dat2<-melt(data2)
dat2$variable=factor(dat2$variable,levels=c("GPMeta","Bowtie2","Bwa"))
dat3<-melt(data3)
dat3$variable=factor(dat3$variable,levels=c("GPMeta","GPMetaC","Bowtie2","Bwa","Kraken2","Centrifuge"))
dat4<-melt(data3)
dat4$variable=factor(dat4$variable,levels=c("GPMeta","GPMetaC","Bowtie2","Bwa","Kraken2","Centrifuge"))

p1<- ggplot(dat1)+
	geom_boxplot(aes(x=variable,y=value*100,color=variable),size=1)+
	geom_jitter(aes(x=variable,y=value*100,color=variable),size=3,shape=17)+	
	theme_bw()+	
	#theme(panel.grid.major=element_blank(),panel.grid.minor = element_blank())+
	theme(panel.border= element_rect(size=1,colour="black"))+
	ggtitle("")+ 
	theme(plot.title = element_text(hjust = "0.5",face="bold"))+ 
	labs(fill="")+
	xlab("")+
	ylab("Percentage (%)")+
	#ylim(99,100)+
	theme(axis.title.y= element_text(size=10, color="black", face= "bold", vjust=0.5, hjust=0.5))+
	theme(axis.text.y= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
	theme(axis.text.x= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
	scale_color_nejm()

p2<- ggplot(dat2)+
	geom_boxplot(aes(x=variable,y=value*100,color=variable),size=1)+
	geom_jitter(aes(x=variable,y=value*100,color=variable),size=3,shape=17)+	
	theme_bw()+	
	#theme(panel.grid.major=element_blank(),panel.grid.minor = element_blank())+
	theme(panel.border= element_rect(size=1,colour="black"))+
	ggtitle("")+ 
	theme(plot.title = element_text(hjust = "0.5",face="bold"))+ 
	labs(fill="")+
	xlab("")+
	ylab("Percentage (%)")+
	#ylim(98,100)+
	theme(axis.title.y= element_text(size=10, color="black", face= "bold", vjust=0.5, hjust=0.5))+
	theme(axis.text.y= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
	theme(axis.text.x= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
	scale_color_nejm()

p3<- ggplot(dat3)+
	geom_boxplot(aes(x=variable,y=value*100,color=variable),size=1)+
	geom_jitter(aes(x=variable,y=value*100,color=variable),size=3,shape=17)+	
	theme_bw()+	
	#theme(panel.grid.major=element_blank(),panel.grid.minor = element_blank())+
	theme(panel.border= element_rect(size=1,colour="black"))+
	ggtitle("")+ 
	theme(plot.title = element_text(hjust = "0.5",face="bold"))+ 
	labs(fill="")+
	xlab("")+
	ylab("Precision (%)")+
	#ylim(98,100)+
	theme(axis.title.y= element_text(size=10, color="black", face= "bold", vjust=0.5, hjust=0.5))+
	theme(axis.text.y= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
	theme(axis.text.x= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
	#scale_color_nejm()
	scale_color_manual(values=c("#FF6347","#BC3C29FF", "#0072B5FF", "#E18727FF", "#20854EFF", "#7876B1FF" )) 


p4<- ggplot(dat4)+
	geom_boxplot(aes(x=variable,y=value*100,color=variable),size=1)+
	geom_jitter(aes(x=variable,y=value*100,color=variable),size=3,shape=17)+	
	theme_bw()+	
	#theme(panel.grid.major=element_blank(),panel.grid.minor = element_blank())+
	theme(panel.border= element_rect(size=1,colour="black"))+
	ggtitle("")+ 
	theme(plot.title = element_text(hjust = "0.5",face="bold"))+ 
	labs(fill="")+
	xlab("")+
	ylab("Recall (%)")+
	#ylim(98,100)+
	theme(axis.title.y= element_text(size=10, color="black", face= "bold", vjust=0.5, hjust=0.5))+
	theme(axis.text.y= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
	theme(axis.text.x= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
	#scale_color_nejm()
	scale_color_manual(values=c("#FF6347","#BC3C29FF", "#0072B5FF", "#E18727FF", "#20854EFF", "#7876B1FF" )) 

ggarrange(p1, p2 ,
          #labels = c("A", "B", "C","D"),
          ncol = 2, nrow = 1)

ggarrange(p3 , p4, ncol = 2, nrow = 1)
