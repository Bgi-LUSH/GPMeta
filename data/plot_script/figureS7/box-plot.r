

library(ggplot2)
library("ggsci")
library(grid)
library(ggpubr)
library(reshape2)

da<-read.table("precision.txt",header = T ,sep="\t")
dad<-read.table("recall.txt",header = T ,sep="\t")
da2<-melt(da,id.vars=c("rep"),variable.name = "group",value.name = "num")
da3<-melt(dad,id.vars=c("rep"),variable.name = "group",value.name = "num")

da2$group=factor(da2$group,levels=c("GPMetaC","GPMeta","cuCLARK","cuCLARK.l"))

p1<- ggplot(da2)+
  geom_boxplot(aes(x=group,y=num*100,color=group),size=0.5)+ 
  geom_jitter(aes(x=group,y=num*100,color=group,shape=group),size=3)+ #theme(legend.position ="none")+
  #geom_line(data=hh1,aes(x=pos,y=num*100,group=col,color=col),size=.5)+	
  #theme_bw()+	
  #theme(panel.grid.major=element_blank(),panel.grid.minor = element_blank())+
  #theme(panel.border= element_rect(size=1,colour="black"))+
  ggtitle("")+ 
  theme(plot.title = element_text(hjust = "0.5",face="bold"))+ 
  labs(fill="")+
  xlab("")+
  ylab("Precision (%)")+
  ylim(0,100)+
  theme(axis.title.y= element_text(size=10, color="black", face= "bold", vjust=0.5, hjust=0.5))+
  theme(axis.text.y= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
  theme(axis.text.x= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
  theme(axis.line = element_line(size=1, colour = "black")) +  ## 再加上坐标轴（无刻度、无标签）
  scale_color_nejm()+
  scale_shape_manual(values = c(17, 19, 18,8))

p2<- ggplot(da3)+
  geom_boxplot(aes(x=group,y=num*100,color=group),size=0.5)+ 
  geom_jitter(aes(x=group,y=num*100,color=group,shape=group),size=3)+ #theme(legend.position ="none")+
  #geom_line(data=hh1,aes(x=pos,y=num*100,group=col,color=col),size=.5)+	
  #theme_bw()+	
  #theme(panel.grid.major=element_blank(),panel.grid.minor = element_blank())+
  #theme(panel.border= element_rect(size=1,colour="black"))+
  ggtitle("")+ 
  theme(plot.title = element_text(hjust = "0.5",face="bold"))+ 
  labs(fill="")+
  xlab("")+
  ylab("Recall(%)")+
  ylim(0,100)+
  theme(axis.title.y= element_text(size=10, color="black", face= "bold", vjust=0.5, hjust=0.5))+
  theme(axis.text.y= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
  theme(axis.text.x= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
  theme(axis.line = element_line(size=1, colour = "black")) +  ## 再加上坐标轴（无刻度、无标签）
  scale_color_nejm()+
  scale_shape_manual(values = c(17, 19, 18,8))

da4<-read.table("time-ave.txt",header = T ,sep="\t")
da4$soft=factor(da4$soft,levels=c("GPMetaC","GPMeta","cuCLARK","cuCLARK-l"))
p3<- ggplot(da4)+
  geom_bar(aes(x=soft,y=time,fill=soft),stat='identity',color="black",width = 0.65)+ 
  #geom_jitter(aes(x=group,y=num*100,color=group,shape=group),size=3)+ #theme(legend.position ="none")+
  #geom_line(data=hh1,aes(x=pos,y=num*100,group=col,color=col),size=.5)+	
  #theme_bw()+	
  theme(panel.grid.major=element_blank(),panel.grid.minor = element_blank())+
  #theme(panel.border= element_rect(size=1,colour="black"))+
  ggtitle("")+ 
  theme(plot.title = element_text(hjust = "0.5",face="bold"))+ 
  labs(fill="")+
  xlab("")+
  ylab("Time-consuming(s)")+
  #ylim(0,43)+
	geom_text(aes(x=soft,y=time,label=time), 
            position = position_dodge2(width = 0.9, preserve = 'single'), 
            vjust = -0.2, hjust = 0.5,size=3)+
  theme(axis.title.y= element_text(size=10, color="black", face= "bold", vjust=0.5, hjust=0.5))+
  theme(axis.text.y= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
  theme(axis.text.x= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
  theme(axis.line = element_line(size=1, colour = "black")) +  ## 再加上坐标轴（无刻度、无标签）
  scale_fill_nejm()+scale_y_continuous(expand = c(0,0),limits = c(0, 40))

ggarrange(p3, p1, p2,
          labels = c("A", "B","C"),
          ncol = 2, nrow = 2)


