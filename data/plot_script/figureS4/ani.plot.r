
data1 <- read.table("Ecoli.txt",header = T ,sep="\t",row.names=1)
data2 <- read.table("staphy.txt",header = T ,sep="\t",row.names=1)
data3 <- read.table("Y.txt",header = T ,sep="\t",row.names=1)

library(pheatmap)

pheatmap(data1,display_numbers=T,fontsize_number=10 )

pheatmap(data2 ,display_numbers=T,fontsize_number=10)

pheatmap(data3 ,display_numbers=T,show_colname=F,fontsize_number=10)

