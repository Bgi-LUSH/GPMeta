
library(ggplot2)
library("ggsci")
library(grid)
library(ggpubr)
library(reshape2)

da<-read.table("recall.txt",header = T ,sep="\t")

da1<-melt(da,id.vars=c("name","species","cor"),measure.vars = c("GPMeta","GPMetaC","Bwa"),
		variable.name = "group",value.name = "num")

#Staphylococcus,Shigella,Yersinia
#da2<-subset(da1,species=="Staphylococcus")
#da2<-subset(da1,species=="Shigella")
da2<-subset(da1,species=="Yersinia")

da2$group=factor(da2$group,levels=c("GPMetaC","GPMeta","Bwa"))


gro<-c("case1","case2","case3","case4") 

####将页面分成a*b矩阵
grid.newpage()  ##新建页面 
n_col=6  #设置每行列数
n_row<-ceiling(6/n_col) #分页行数
pushViewport(viewport(layout = grid.layout(n_row,n_col)))
vplayout <- function(x,y){
  viewport(layout.pos.row = x, layout.pos.col = y)
}
##################################
n=0
for(i in gro){
	print(i)
  d=subset(da2,cor==i)

  p1<- ggplot(d)+
  geom_boxplot(aes(x=group,y=num*100,color=group),size=0.5)+ 
  geom_jitter(aes(x=group,y=num*100,color=group,shape=group),size=3)+ theme(legend.position ="none")+
  #geom_line(data=hh1,aes(x=pos,y=num*100,group=col,color=col),size=.5)+	
  #theme_bw()+	
  #theme(panel.grid.major=element_blank(),panel.grid.minor = element_blank())+
  #theme(panel.border= element_rect(size=1,colour="black"))+
  ggtitle("")+ 
  theme(plot.title = element_text(hjust = "0.5",face="bold"))+ 
  labs(fill="")+
  xlab("")+
  ylab("Recall (%)")+
  ylim(0,100)+
  theme(axis.title.y= element_text(size=10, color="black", face= "bold", vjust=0.5, hjust=0.5))+
  theme(axis.text.y= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
  theme(axis.text.x= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5,angle=15))+
  theme(axis.line = element_line(size=1, colour = "black")) +  ## 再加上坐标轴（无刻度、无标签）
  scale_color_nejm()+
  scale_shape_manual(values = c(17, 19, 18))

  #输出到一个图上
  n=n+1	
  a<-ceiling(n/n_col)
  b=n-(a-1)*n_col
  print(p1,vp = vplayout(a,b))
}


###最后
  d=subset(da2,cor=="con1")
  p1<- ggplot(d)+
  geom_boxplot(aes(x=group,y=num*100,color=group),size=0.5)+ 
  geom_jitter(aes(x=group,y=num*100,color=group,shape=group),size=3)+ #theme(legend.position ="none")+
  #geom_line(data=hh1,aes(x=pos,y=num*100,group=col,color=col),size=.5)+	
  #theme_bw()+	
  #theme(panel.grid.major=element_blank(),panel.grid.minor = element_blank())+
  #theme(panel.border= element_rect(size=1,colour="black"))+
  theme(legend.text=element_text(color="black", size=10),
        legend.background=element_blank(),
        legend.position = c(1.8,0.6))+
  ggtitle("")+ 
  theme(plot.title = element_text(hjust = "0.5",face="bold"))+ 
  labs(fill="")+
  xlab("")+
  ylab("Recall (%)")+
  ylim(0,100)+
  theme(axis.title.y= element_text(size=10, color="black", face= "bold", vjust=0.5, hjust=0.5))+
  theme(axis.text.y= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
  theme(axis.text.x= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5,angle=15))+
  theme(axis.line = element_line(size=1, colour = "black")) +  ## 再加上坐标轴（无刻度、无标签）
  scale_color_nejm()+
  scale_shape_manual(values = c(17, 19, 18))
     print(p1,vp = vplayout(1,5))	