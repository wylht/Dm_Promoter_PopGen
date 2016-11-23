
setwd("/scratch/rtraborn/Dm_Promoter_PopGen/results")    

library(GenomicRanges)

library(ggplot2)

h_summary <- read.table(file="h_summary_combined.txt", header=TRUE)

dim(h_summary)

head(h_summary)

colnames(h_summary) <- c("chr", "start", "end", "strand", "h_mean")

head(h_summary)

tsrs_GR <- with(h_summary, GRanges(chr, IRanges(start, end, names="."),strand, score=h_mean))

head(tsrs_GR)

my.width <- width(tsrs_GR)

h_summary2 <- cbind(h_summary, my.width)

colnames(h_summary2) <- c("chr", "start", "end", "strand", "h_mean","width")

tsrs_GR <- with(h_summary2, GRanges(chr, IRanges(start, end),strand, score=h_mean))

tsrs_GR

tsrs.df <- as.data.frame(tsrs_GR)

head(tsrs.df)

colnames(tsrs.df) <- c("chr", "start", "end", "width","strand", "h_mean")

head(tsrs.df)

p <- ggplot(tsrs.df, aes(width))

p + geom_histogram(binwidth=1, colour="white",fill="navy")

ggsave(file="TSR_width_histogram.png")

h <- ggplot(tsrs.df, aes(h_mean))

h + geom_histogram(binwidth=0.005, colour="white",fill="darkgreen")

summary(tsrs.df$h_mean)

ggsave(file="TSR_h_mean_histogram.png")

head(tsrs.df)

summary(tsrs.df$width)

width_quantiles <- quantile(tsrs.df$width, probs=seq(0,1,0.1))

width_quantiles

peaked_decile <- which(tsrs.df$width <= 2)

broad_decile <- which(tsrs.df$width >= 20)

length(peaked_decile)

length(broad_decile)

tsrs.df$width_class <- rep(NA, nrow(tsrs.df))

tsrs.df$width_class <- "unclassified"

tsrs.df$width_class[broad_decile] <- "broad"

tsrs.df$width_class[peaked_decile] <- "peaked"

head(tsrs.df)

tsrs.df$h_mean[broad_decile] -> broad_hval

tsrs.df$h_mean[peaked_decile] -> peaked_hval

summary(broad_hval)

summary(peaked_hval)

w <- ggplot(tsrs.df, aes(width_class, h_mean))

w + geom_boxplot() + ylim(c(0,0.10))

ggsave(file="TSR_h_mean_vs_breadth_class.png")
