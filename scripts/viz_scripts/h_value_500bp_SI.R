setwd("/scratch/rtraborn/Dm_Promoter_PopGen/Promoters/results")    
library(GenomicRanges)
library(ggplot2)
library(reshape2)

h_clark <- read.csv(file="CLAR.csv", header=TRUE)
h_ages <- read.csv(file="AGES.csv", header=TRUE)
h_dpgp <- read.csv(file="dpgp.csv", header=TRUE)
h_nuzh <- read.csv(file="NUZH.csv", header=TRUE)
h_summary <- rbind(h_clark, h_ages, h_dpgp, h_nuzh)
h_summary <- h_summary[,-1]

dim(h_summary)
#summary(h_dpgp)
#summary(h_summary)

my.col <- c("chr", "start", "end", "strand")
my.col2 <- -250:250
my.col3 <- c("SI","shape_class")
final.colnames <- c(my.col, my.col2, my.col3)
colnames(h_summary) <- final.colnames
h_values_table <- h_summary[,5:505]
#head(h_summary)
#head(h_values_table)

h_mean_vec_all <- apply(h_values_table, 2, mean)
h_peaked.ind <- which(h_summary$shape_class==1)
h_peaked <- h_summary[h_peaked.ind,]
h_unclass.ind <- which(h_summary$shape_class==0)
h_unclass <- h_summary[h_unclass.ind,]
h_broad.ind <- which(h_summary$shape_class==-1)
h_broad  <- h_summary[h_broad.ind,]

#head(h_peaked)
#head(h_unclass)
#head(h_broad)

h_values_peaked <- h_peaked[,5:505]
h_values_unclass <- h_unclass[,5:505]
h_values_broad <- h_broad[,5:505]

#head(h_values_peaked)
#head(h_values_unclass)
#head(h_values_broad)

h_mean_vec_p <- apply(h_values_peaked, 2, mean)
h_mean_vec_u <- apply(h_values_unclass, 2, mean)
h_mean_vec_b <- apply(h_values_broad, 2, mean)

h_mean_matrix <- cbind(-250:250, h_mean_vec_all, h_mean_vec_p, h_mean_vec_u, h_mean_vec_b)
colnames(h_mean_matrix) <- c("Position", "Mean_h_All", "Mean_h_peaked", "Mean_h_unclass","Mean_h_broad")
h_mean_df <- as.data.frame(h_mean_matrix)
h_mean_melt <- melt(h_mean_df, id="Position")
names(h_mean_melt) <- c("Position", "id", "mean_h")
#head(h_mean_melt)

p <- ggplot(h_mean_melt, aes(x=Position, y=mean_h, colour=id))
p + geom_line()
ggsave(file="TSR_500bp_h_mean_plot_ALL_combined.png")
r <- ggplot(h_mean_melt, aes(x=Position, y=mean_h, colour=id))
r + geom_jitter()
ggsave(file="TSR_500bp_h_mean_dotplot_ALL_combined.png")

TSS_all <- h_values_table[,250]
TSS_peaked <- h_values_peaked[,250]
TSS_broad <- h_values_broad[,250]
TSS_table <- cbind(TSS_all, TSS_peaked, TSS_broad)
head(TSS_table)
TSS_melt <- melt(TSS_table)
TSS_melt[,1] <- 1
colnames(TSS_melt) <- c("number", "id", "mean_h")
#head(TSS_melt)
#q <- ggplot(TSS_melt, aes(x=id, y=mean_h, fill=id))
#q + geom_pointrange()
#ggsave(file="TSS_h_mean_pointrange_ALL_combined.png")
