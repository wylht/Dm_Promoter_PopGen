library(ggplot2)
setwd("/scratch/rtraborn/Dm_Promoter_PopGen/data/Dm_promoter")
tsr.table <- read.table("hoskins_tsr_table_SI.txt", header=TRUE, sep="\t")
peaked.t <- tsr.table[tsr.table$shape.index == 2,]
broad.t <- tsr.table[tsr.table$shape.index <= 0.4705696,]
unclass.ind <- which(tsr.table$shape.index > 0.4705696 & tsr.table$shape.index < 2,)
unclass.t <- tsr.table[unclass.ind,]

p <- ggplot(tsr.table, aes(shape.index))
p + geom_density(stat="density",colour="blue")
ggsave(file="overall_SI_density.png")

q <- ggplot(tsr.table, aes(tpm))
q + geom_density(stat="density", colour="red") + scale_x_continuous(limits=c(0,200))
ggsave(file="overall_expression_density.png")

