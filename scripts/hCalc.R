#' Calculates pi from a DNAStringSet object.
#' @param myString an object of class DNAstring 
#' @return a numeric value representing pi

hCalc <- function(myString) {
	#string <- strsplit(string, "")[[1]]
        n <- length(myString)
        #initialize values to zero
        a <- 0
        c <- 0
        g <- 0
        t <- 0    
        
	t <- length(which(string=='T'))/n
	a <- length(which(string=='A'))/n
	g <- length(which(string=='G'))/n
	c <- length(which(string=='C'))/n

	return((n/(n-1))*(1-(a^2+c^2+t^2+g^2)))
	}
