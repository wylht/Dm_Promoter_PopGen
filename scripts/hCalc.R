#' Calculates pi from a DNAStringSet object.

hCalc <- function(myString) {
	#string <- strsplit(string, "")[[1]]

        #initialize values to zero #not necessary; will be computed each time
        #a <- 0
        #c <- 0
        #g <- 0
        #t <- 0    

        n <- length(myString)
	a <- (length(which(myString=='A'))/n)
	g <- (length(which(myString=='G'))/n)
	c <- (length(which(myString=='C'))/n)
        t <- (length(which(myString=='T'))/n)

#        print(t) #for debugging
#        print(a)
#        print(g)
#        print(c)
#        print(n)

        my.h <- (n/(n-1))*(1-(a^2+c^2+t^2+g^2))
        return(my.h)
	}
