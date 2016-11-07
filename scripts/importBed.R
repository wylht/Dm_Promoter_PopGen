importBed <- function(x) {
    fileName <- x
    if (is.character(fileName)==FALSE) {
        stop("The value for x must be of class Character.")
    }
    my.bed <- read.table(file=fileName, header=FALSE, sep="\t", colClasses=c("character", "numeric", "numeric", "character", "character", "character"))
    my.bed <- my.bed[,1:8]
    colnames(my.bed) <- c("chr","start", "end", "ID", "score", "strand", "start_CTSS", "end_CTSS")
    return(my.bed)
}
