library(Biostrings)

hcalc <- function(string) {
	#string <- strsplit(string, "")[[1]]
	n <- length(string)
	t <- a <- g <- c <- 0
	t <- length(which(string=='T'))/n
	a <- length(which(string=='A'))/n
	g <- length(which(string=='G'))/n
	c <- length(which(string=='C'))/n
	return((n/(n-1))*(1-(a^2+c^2+t^2+g^2)))
	}


T <- DNAString('--GTCTGAGCATGCTTACGCGGCGT---GTCTGAGCATGCTTACGCGGCGT-')
A <- DNAString('CTGGCTGAGCATGCTGACGCTACGT-CTGGCTGAGCATGCTGACGCTACGT-')
G <- DNAString('GAGGCT--GCATGCTGACGCTACGT-GAGGCT--GCATGCTGACGCTACGT-')

##### removed strings with less than one valid base


dna = list(T,A,G)


positions = list()
for (col in 1:length(T)) {
	temp <- paste(c(lapply(dna,function(x) toString(x[col]))), collapse = '')
	temp <- strsplit(gsub("-", "", temp),'')[[1]]   
	if (length(temp) > 1) {positions[[length(positions) + 1]] <- temp}
}

hvals = lapply(positions, hcalc)

print(Reduce('+',hvals) / length(positions))

