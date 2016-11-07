# this script returns a data frame with the position and the values of pi

retrievePi <- function(MyString, start, end) {
    if (end < start) {
        stop("the end position must be greater than the start position.")
    }

    my.len <- length(start:end)
    my.mat <- matrix(NA, ncol=2, nrow=my.len)

    my.vec <- hVector(MyString=MyString, startPos=start, endPos=end)

    #depositing the information in our matrix
    my.mat[,1] <- start:end 
    my.mat[,2] <- my.vec
    colnames(my.mat) <- c("coordinate", "pi")
    my.df <- as.data.frame(my.mat)
    
    return(my.df)
}
    
    
    
