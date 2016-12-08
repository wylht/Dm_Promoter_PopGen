setwd("/scratch/rtraborn/Dm_Promoter_PopGen/results")    
library(GenomicRanges)
library(ggplot2)
h_summary <- read.csv(file="all_h_CLARK_sequences.csv", header=FALSE)
dim(h_summary)
head(h_summary)
my.col <- c("chr", "start", "end", "strand")
my.col2 <- -250:250
final.colnames <- c(my.col, my.col2)
colnames(h_summary) <- final.colnames
h_values_table <- h_summary[,5:505]
head(h_summary)
head(h_values_table)
h_mean_vec <- apply(h_values_table, 2, mean)
h_median_vec <- apply(h_values_table, 2, median)
h_mean_matrix <- cbind(-250:250, h_mean_vec, h_median_vec)
colnames(h_mean_matrix) <- c("Position", "Mean_h", "Median_h")
h_mean_df <- as.data.frame(h_mean_matrix)

p <- ggplot(h_mean_df, aes(Position,Mean_h))
p + geom_line()
ggsave(file="TSR_500bp_h_mean_plot_CLARK.png")

p <- ggplot(h_mean_df, aes(Position,Mean_h))
p + geom_point(color="blue2")
ggsave(file="TSR_500bp_h_mean_dotplot_CLARK.png")
