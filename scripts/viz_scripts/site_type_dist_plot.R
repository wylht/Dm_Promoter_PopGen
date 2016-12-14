#Sets the folder to work in
library(ggplot2)
setwd("/scratch/rtraborn/Dm_Promoter_PopGen/data/h_values")

#This part is for exons
h_mean_exon_dfdpgp3 <- read.table("Pop_h_mean_exon_dfdpgp3.txt")
h_mean_exon_dfPOOL <- read.table("Pop_h_mean_exon_dfPOOL.txt")
h_mean_exon_dfNUZHDIN <- read.table("Pop_h_mean_exon_dfNUZHDIN.txt")
h_mean_exon_dfAGES <- read.table("Pop_h_mean_exon_dfAGES.txt")
h_mean_exon_dfCLARK <- read.table("Pop_h_mean_exon_dfCLARK.txt")

Mean_h_exon <- (h_mean_exon_dfdpgp3$Mean_h + h_mean_exon_dfPOOL$Mean_h + h_mean_exon_dfCLARK$Mean_h + h_mean_exon_dfNUZHDIN$Mean_h + h_mean_exon_dfAGES$Mean_h)/5

#This part is for introns
h_mean_intron_dfdpgp3 <- read.table("Pop_h_mean_intron_dfdpgp3.txt")
h_mean_intron_dfPOOL <- read.table("Pop_h_mean_intron_dfPOOL.txt")
h_mean_intron_dfNUZHDIN <- read.table("Pop_h_mean_intron_dfNUZHDIN.txt")
h_mean_intron_dfAGES <- read.table("Pop_h_mean_intron_dfAGES.txt")
h_mean_intron_dfCLARK <- read.table("Pop_h_mean_intron_dfCLARK.txt")

Mean_h_intron <- (h_mean_intron_dfdpgp3$Mean_h + h_mean_intron_dfPOOL$Mean_h + h_mean_intron_dfCLARK$Mean_h + h_mean_intron_dfNUZHDIN$Mean_h + h_mean_intron_dfAGES$Mean_h)/5

#This part is for promoters (promoters only, not the whole region)

##This is for CLARK
CLARK_data_prom <- read.csv("h_adjacent_tss_CLARK_sequences.csv")
CLARK_data_prom[,508]->CLARK_vec
strsplit(as.character(CLARK_vec)," ")->CLARK_TSR_list
lapply(CLARK_TSR_list, as.numeric)->CLARK_TSR_num
lapply(CLARK_TSR_num, mean)->CLARK_TSR_mean
as.data.frame(CLARK_TSR_mean)->CLARK_TSR_mean.df

##This is for AGES
AGES_data_prom <- read.csv("h_adjacent_tss_AGES_sequences.csv")
AGES_data_prom[,508]->AGES_vec
strsplit(as.character(AGES_vec)," ")->AGES_TSR_list
lapply(AGES_TSR_list, as.numeric)->AGES_TSR_num
lapply(AGES_TSR_num, mean)->AGES_TSR_mean
as.data.frame(AGES_TSR_mean)->AGES_TSR_mean.df

##This is for dpgp3
dpgp3_data_prom <- read.csv("h_adjacent_tss_dpgp3_sequences.csv")
dpgp3_data_prom[,508]->dpgp3_vec
strsplit(as.character(dpgp3_vec)," ")->dpgp3_TSR_list
lapply(dpgp3_TSR_list, as.numeric)->dpgp3_TSR_num
lapply(dpgp3_TSR_num, mean)->dpgp3_TSR_mean
as.data.frame(dpgp3_TSR_mean)->dpgp3_TSR_mean.df
##This is for NUZHDIN
NUZHDIN_data_prom <- read.csv("h_adjacent_tss_NUZHDIN_sequences.csv")
NUZHDIN_data_prom[,508]->NUZHDIN_vec
strsplit(as.character(NUZHDIN_vec)," ")->NUZHDIN_TSR_list
lapply(NUZHDIN_TSR_list, as.numeric)->NUZHDIN_TSR_num
lapply(NUZHDIN_TSR_num, mean)->NUZHDIN_TSR_mean
as.data.frame(NUZHDIN_TSR_mean)->NUZHDIN_TSR_mean.df
##This is for POOL
POOL_data_prom <- read.csv("h_adjacent_tss_POOL_sequences.csv")
POOL_data_prom[,508]->POOL_vec
strsplit(as.character(POOL_vec)," ")->POOL_TSR_list
lapply(POOL_TSR_list, as.numeric)->POOL_TSR_num
lapply(POOL_TSR_num, mean)->POOL_TSR_mean
as.data.frame(POOL_TSR_mean)->POOL_TSR_mean.df
#This is a dataframe with all the columns
h_prom_df <- cbind(1:7067,as.numeric(CLARK_TSR_mean), as.numeric(AGES_TSR_mean), as.numeric(dpgp3_TSR_mean), as.numeric(NUZHDIN_TSR_mean), as.numeric(POOL_TSR_mean))
colnames(h_prom_df) <- c("Promoter", "CLARK", "AGES", "dpgp3", "NUZHDIN", "POOL")
h_prom_df <- as.data.frame(h_prom_df)
Mean_prom <- as.numeric((h_prom_df$CLARK + h_prom_df$AGES + h_prom_df$dpgp3 + h_prom_df$NUZHDIN + h_prom_df$POOL)/5)
ind<-rep("TSR", 7067)
h_prom_ALLmean_df <- cbind.data.frame(1:7067, Mean_prom, ind)
colnames(h_prom_ALLmean_df) <- c("Position", "values", "ind")

#This part to get a data frame with h_values of introns and exons together
h_mean_df <- cbind(1:500, Mean_h_exon, Mean_h_intron) #commented out: , h_median_vec
colnames(h_mean_df) <- c("Position", "exon", "intron")
h_mean_df <- as.data.frame(h_mean_df)
h_mean_df_2 <- data.frame(h_mean_df[1], stack(h_mean_df[2:ncol(h_mean_df)]))

#Now to get a data frame with h_values of promoters introns and exons together!
h_mean_df_3 <- rbind(h_mean_df_2, h_prom_ALLmean_df)

#This part is for the plot
p <- ggplot(h_mean_df_3, aes(ind, values))
p + geom_boxplot(color="black") + labs(x = "Sequence type", y = "Mean h value") + scale_y_continuous(limits=c(0, 0.15))
ggsave(file="Promoter_Exon_Intron_h_value_boxplot.png")
