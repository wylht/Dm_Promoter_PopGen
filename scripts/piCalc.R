#' Calculates pi from a list contining multiple DNAStringSet objects.
#' @param myString a list object contining multiple objects of class DNAstring 
#' @importFrom Biostrings readDNAstringSet DNAString
#' @return a numeric value representing pi for a given set of positions

piCalc <- function(myString) {

#    string <- strsplit(string, "")[[1]]

# need to supplant the following toy data with example data from the Fly Nexus    
T <- DNAString('--GTCTGAGCATGCTTACGCGGCGT---GTCTGAGCATGCTTACGCGGCGT-')
A <- DNAString('CTGGCTGAGCATGCTGACGCTACGT-CTGGCTGAGCATGCTGACGCTACGT-')
G <- DNAString('GAGGCT--GCATGCTGACGCTACGT-GAGGCT--GCATGCTGACGCTACGT-')

##### removed strings with less than one valid base

dna <- list(T,A,G)
positions <- list()

for (col in 1:length(T)) {
	temp <- paste(c(lapply(dna, function(x) toString(x[col]))), collapse = '')
	temp <- strsplit(gsub("-", "", temp),'')[[1]]   
	if (length(temp) > 1) {positions[[length(positions) + 1]] <- temp}
    }

hvals <- lapply(positions, hcalc)

myPi <- (Reduce('+', hvals) / length(positions))

return(myPi)

}
