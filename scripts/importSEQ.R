#' Imports fasta files from Drosophila Genome Nexus datasets and creates a DNAStringSet object.
#' @param dirName a directory containing fasta files
#' @import biostrings readDNAstringSet
#' @return an object of class DNAStringSet containing the sequences from the SEQ files

importSEQ <- function(dirName) {

    library("Biostrings")
    
    my.list <- list.files(dirName, full.names=TRUE, pattern="\\.fasta$")
    
    if (length(my.list)<1) {
        stop("There are no files with the .fasta extension in the folder (dirName) provided.")
    }

    this.list <- vector(mode="list")

    for (i in 1:length(my.list)) {

        my.list[i] -> this.SEQ
    
        readDNAStringSet(this.SEQ, format="fasta", use.names=TRUE) -> this.list[[i]]

    }

    return(this.list)
        
}    
    
