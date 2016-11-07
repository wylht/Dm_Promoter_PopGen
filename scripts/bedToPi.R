bedToPi <- function(DNAstringFile, chrName, bedFile, writeTable) {
    my.bed <- importBed(bedFile)
    bed.chr <- subset(my.bed, chr==chrName, drop=TRUE)
    my.matrix <- matrix(NA, ncol=2, nrow=nrow(bed.chr))
    for (i in 1:nrow(bed.chr)) {
        print(i)
        bed.chr[i,] -> this.interval
        as.character(this.interval[1]) -> my.chr
        as.numeric(as.character(this.interval[2])) -> my.start
        as.numeric(as.character(this.interval[3])) -> my.end
        paste(my.chr, my.start, my.end, sep=":") -> my.coord
        retrievePi(DNAstringFile, start=my.start, end=my.end) -> pi.table
        print(head(pi.table))
        mean(as.numeric(as.character(pi.table$pi))) -> pi.value
        print(pi.value)
        c(my.coord, pi.value) -> my.matrix[i,]
    }
    colnames(my.matrix) <- c("coordinates", "pi")
    my.df <- as.data.frame(my.matrix)
         if (writeTable==TRUE) {
             write.table(my.df, file="piTable.txt", sep="\t", quote=FALSE, col.names=TRUE, row.names=FALSE)
         }
         return(my.df)
     }
