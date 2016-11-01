#' Imports fasta files from Drosophila Genome Nexus datasets and creates a DNAStringSet object.
#' @param fileName a fasta file containing multiple SEQ strings
#' @import biostrings readDNAstringSet
#' @return an object of class DNAStringSet containing the sequences from the SEQ files
#' @export

importSEQ <- function(fileName) {
    library("Biostrings")
    
    if (is.character(fileName)==FALSE) {
        stop("\nfileName must be of class 'character'\n")
    }
    
        readDNAStringSet(fileName, format="fasta", use.names=TRUE) -> this.string

    return(this.string)
        
}    
    
