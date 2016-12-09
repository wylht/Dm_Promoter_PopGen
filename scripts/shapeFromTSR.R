source(file="shapeIndex.R")
library(GenomicRanges)

tsrData <- read.table(file="/scratch/rtraborn/Dm_Promoter_PopGen/data/Dm_promoter/hoskinsTSRs.txt", header=TRUE)
ctssData <- read.table(file="/scratch/rtraborn/Dm_Promoter_PopGen/data/Dm_promoter/hoskinsCTSSs.txt", header=TRUE)

colnames(tsrData) <- c("cluster", "chr", "start", "end", "strand", "nr_ctss", "dominant_ctss", "tpm", "tpm_dom_ctss")

tsrs_GR <- with(tsrData, GRanges(chr, IRanges(start, end), strand))
ctss_GR <- with(ctssData, GRanges(chr, IRanges(start=pos, width=1), strand, counts=fly))

overlap_set <- findOverlaps(tsrs_GR, ctss_GR)
overlap_set.df <- as.data.frame(overlap_set)

#print(head(overlap_set.df))

print(max(overlap_set.df$queryHits))
print(max(overlap_set.df$subjectHits))

tss.matrix <- matrix(NA, nrow=nrow(tsrData), ncol=4)
colnames(tss.matrix) <- c("tss.num", "shape.index", "nCTSSs", "nTSSs")

for (i in 1:nrow(tsrData)) {
    i -> this.tsr
    print(this.tsr)
    which(overlap_set.df$queryHits==this.tsr) -> this.ind
    overlap_set.df$subjectHits[this.ind] -> ctss.ind
    ctss_GR[ctss.ind,] -> ctss.set
    as.data.frame(ctss.set) -> ctss.set.df
    start(ctss.set) -> ctss.start
    ctss.set.df$counts -> counts.vec
    tss.vec <- c()
    for (j in 1:length(ctss.start)) {
        ctss.start[j] -> this.start
        counts.vec[j] -> this.count
        rep(this.start, this.count) -> this.string
        c(tss.vec, this.string) -> tss.vec
    }
    shapeIndex(tss.vec) -> my.SI
    length(unique(tss.vec)) -> n.CTSSs
    length(tss.vec) -> n.TSSs
    c(this.tsr, my.SI, n.CTSSs, n.TSSs) -> tss.matrix[i,1:4]
}
tss.df <- cbind(tsrData, tss.matrix)
write.table(tss.df, file="tsr.table.shape.txt", sep="\t", row.names=FALSE, col.names=TRUE, quote=FALSE)
    
        

