data <- read.table("rate.txt",header = T ,sep="\t")
data$precision<-data$precision*100
data$recall<-data$recall*100


library(ggplot2)
library("ggsci")
library(grid)
library(reshape2)
library(plyr)

gro<-c("Cerebrospinal-fluid","Serum")


####将页面分成a*b矩阵
grid.newpage()  ##新建页面 
n_col=4  #设置每行列数
n_row<-ceiling(3/n_col) #分页行数
pushViewport(viewport(layout = grid.layout(n_row,n_col)))
vplayout <- function(x,y){
  viewport(layout.pos.row = x, layout.pos.col = y)
}
##################################



data$group=factor(data$group,levels=c("GPMeta","Bowtie2","Bwa","Kraken2","Centrifuge"))


n=0
for(i in gro){
	print(i)
  d=subset(data,sample==i)
  D <- ddply(d, .(group),transform, pos = cumsum(precision)) #- (1 * precision))
  p1<-ggplot(D,aes(x=group,y=precision,fill=group)) + guides(fill=FALSE)+
      geom_bar(stat="identity",position="stack")+
	theme_bw()+	
	theme(panel.grid.major=element_blank(),panel.grid.minor = element_blank())+
	theme(panel.border= element_rect(size=1,colour="black"))+
	theme(legend.text=element_text(color="black", size=10),
        legend.background=element_blank(),
        legend.position = c(1.8,0.6))+
  ggtitle(i)+theme(plot.title = element_text(hjust = "0.5",face="bold"))+
	labs(fill="")+
	xlab("")+
  	ylab("Precision")+

	theme(axis.title.y= element_text(size=10, color="black", face= "bold", vjust=0.5, hjust=0.5))+
	theme(axis.text.y= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
	#theme(axis.text.x= element_text(size=9, color="black",face="bold", angle=30,vjust=0.5, hjust=0.5))+
	theme(axis.text.x= element_text(size=9, color="black",face="bold", angle=30,vjust=1, hjust=1))+
	scale_fill_nejm()+
	#facet_grid(RNA,scale = "free",switch="y")+
	geom_text(data=D,aes(x=group,y=pos,label=precision),size=3,color="black")
  
  #输出到一个图上
  n=n+1	
  a<-ceiling(n/n_col)
  b=n-(a-1)*n_col
  print(p1,vp = vplayout(a,b))
}	



##########################
  i="Throat-swab"
  d=subset(data,sample==i)
  D <- ddply(d, .(group),transform, pos = cumsum(precision)) #- (1 * precision))
  p1<-ggplot(D,aes(x=group,y=precision,fill=group)) + #guides(fill=FALSE)+
      geom_bar(stat="identity",position="stack")+
	theme_bw()+	
	theme(panel.grid.major=element_blank(),panel.grid.minor = element_blank())+
	theme(panel.border= element_rect(size=1,colour="black"))+
	theme(legend.text=element_text(color="black", size=10),
        legend.background=element_blank(),
        legend.position = c(1.8,0.6))+
  ggtitle(i)+theme(plot.title = element_text(hjust = "0.5",face="bold"))+
	labs(fill="")+
	xlab("")+
  	ylab("Precision")+

	theme(axis.title.y= element_text(size=10, color="black", face= "bold", vjust=0.5, hjust=0.5))+
	theme(axis.text.y= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
	theme(axis.text.x= element_text(size=9, color="black",face="bold",angle=30, vjust=1, hjust=1))+
	scale_fill_nejm()+
	#facet_grid(RNA,scale = "free",switch="y")+
	geom_text(data=D,aes(x=group,y=pos,label=precision),size=3,color="black")
	
     print(p1,vp = vplayout(1,3))

