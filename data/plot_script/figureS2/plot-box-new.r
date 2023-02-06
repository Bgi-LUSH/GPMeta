
library(ggplot2)
library("ggsci")
library(grid)
library(ggpubr)
library(reshape2)

host1<-read.table("host1.txt",header = T ,sep="\t")
host2<-read.table("host2.txt",header = T ,sep="\t")
patho1<-read.table("patho1.txt",header = T ,sep="\t")
patho2<-read.table("patho2.txt",header = T ,sep="\t")


h1<-melt(host1)
h2<-melt(host2)
p1<-melt(patho1)
p2<-melt(patho2)
h1$length=factor(h1$length,levels=c("SE50","SE65","SE75","SE100","SE150"))
h2$length=factor(h2$length,levels=c("SE50","SE65","SE75","SE100","SE150"))
p1$length=factor(p1$length,levels=c("SE50","SE65","SE75","SE100","SE150"))
p2$length=factor(p2$length,levels=c("SE50","SE65","SE75","SE100","SE150"))

hh1<-aggregate(h1$value, by=list(h1$length,h1$variable), mean) 
names(hh1)<-c("pos","col","num")

hh2<-aggregate(h2$value, by=list(h2$length,h2$variable), mean) 
names(hh2)<-c("pos","col","num")

pp1<-aggregate(p1$value, by=list(p1$length,p1$variable), mean) 
names(pp1)<-c("pos","col","num")

pp2<-aggregate(p2$value, by=list(p2$length,p2$variable), mean) 
names(pp2)<-c("pos","col","num")



f1<- ggplot()+
  #geom_boxplot(aes(x=length,y=value*100,color=variable),size=0.5)+
  geom_jitter(data=h1,aes(x=length,y=value*100,color=variable,shape=variable),size=3)+
  geom_line(data=hh1,aes(x=pos,y=num*100,group=col,color=col),size=.5)+	
  #theme_bw()+	
  #theme(panel.grid.major=element_blank(),panel.grid.minor = element_blank())+
  #theme(panel.border= element_rect(size=1,colour="black"))+
  ggtitle("")+ 
  theme(plot.title = element_text(hjust = "0.5",face="bold"))+ 
  labs(fill="")+
  xlab("")+
  ylab("PHR (%)")+
  ylim(95,100.1)+
  theme(axis.title.y= element_text(size=10, color="black", face= "bold", vjust=0.5, hjust=0.5))+
  theme(axis.text.y= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
  theme(axis.text.x= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
  theme(axis.line = element_line(size=1, colour = "black")) +  ## 再加上坐标轴（无刻度、无标签）
  scale_color_nejm()+
  scale_shape_manual(values = c(17, 19, 18))

f2<- ggplot()+
  #geom_boxplot(aes(x=length,y=value*100,color=variable),size=0.5)+
  geom_jitter(data=h2,aes(x=length,y=value*100,color=variable,shape=variable),size=3)+
  geom_line(data=hh2,aes(x=pos,y=num*100,group=col,color=col),size=.5)+	
  #theme_bw()+	
  #theme(panel.grid.major=element_blank(),panel.grid.minor = element_blank())+
  #theme(panel.border= element_rect(size=1,colour="black"))+
  ggtitle("")+ 
  theme(plot.title = element_text(hjust = "0.5",face="bold"))+ 
  labs(fill="")+
  xlab("")+
  ylab("PPA (%)")+
  ylim(0,0.5)+
  theme(axis.title.y= element_text(size=10, color="black", face= "bold", vjust=0.5, hjust=0.5))+
  theme(axis.text.y= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
  theme(axis.text.x= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
  theme(axis.line = element_line(size=1, colour = "black")) +  ## 再加上坐标轴（无刻度、无标签）
  scale_color_nejm()+
  scale_shape_manual(values = c(17, 19, 18))

f3<- ggplot()+
  #geom_boxplot(aes(x=length,y=value*100,color=variable),size=0.5)+
  geom_jitter(data=p1,aes(x=length,y=value*100,color=variable,shape=variable),size=3)+
  geom_line(data=pp1,aes(x=pos,y=num*100,group=col,color=col),size=.5)+	
  #theme_bw()+	
  #theme(panel.grid.major=element_blank(),panel.grid.minor = element_blank())+
  #theme(panel.border= element_rect(size=1,colour="black"))+
  ggtitle("")+ 
  theme(plot.title = element_text(hjust = "0.5",face="bold"))+ 
  labs(fill="")+
  xlab("")+
  ylab("Precison (%)")+
  ylim(80,100)+
  theme(axis.title.y= element_text(size=10, color="black", face= "bold", vjust=0.5, hjust=0.5))+
  theme(axis.text.y= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
  theme(axis.text.x= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
  theme(axis.line = element_line(size=1, colour = "black")) +  ## 再加上坐标轴（无刻度、无标签）
  scale_color_nejm()+
  scale_shape_manual(values = c(17, 19, 18,8,9))

f4<- ggplot()+
  #geom_boxplot(aes(x=length,y=value*100,color=variable),size=0.5)+
  geom_jitter(data=p2,aes(x=length,y=value*100,color=variable,shape=variable),size=3)+
  geom_line(data=pp2,aes(x=pos,y=num*100,group=col,color=col),size=.5)+	
  #theme_bw()+	
  #theme(panel.grid.major=element_blank(),panel.grid.minor = element_blank())+
  #theme(panel.border= element_rect(size=1,colour="black"))+
  ggtitle("")+ 
  theme(plot.title = element_text(hjust = "0.5",face="bold"))+ 
  labs(fill="")+
  xlab("")+
  ylab("Recall (%)")+
  ylim(70,100)+
  theme(axis.title.y= element_text(size=10, color="black", face= "bold", vjust=0.5, hjust=0.5))+
  theme(axis.text.y= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
  theme(axis.text.x= element_text(size=9, color="black",face="bold", vjust=0.5, hjust=0.5))+
  theme(axis.line = element_line(size=1, colour = "black")) +  ## 再加上坐标轴（无刻度、无标签）
  scale_color_nejm()+
  scale_shape_manual(values = c(17, 19, 18,8, 9))

ggarrange(f1, f2, f3 , f4, 
          labels = c("A", "B", "C","D"),
          ncol = 2, nrow = 2)

