#This fuction takes a position number and a DNAStringSet, and returns a vector of valid bases at that position

extractPos <- function(stringObj, coordinate) {

#    if (is(stringObj)!="DNAStringSet") {
#        stop("stringObj must be of class DNAStringSet")
#    }

    if (is.numeric(coordinate)==FALSE) {
        stop("coordinate must be of class 'numeric'")
    }
    
  base.pos <- c()
  for (i in 1:length(stringObj)) {
      as.character(stringObj[[i]][coordinate]) -> this.seq
      paste(base.pos, this.seq, sep="") -> base.pos
      }
  base.pos <- strsplit(base.pos, "")
  base.pos <- base.pos[[1]]
  base.pos <- base.pos[is.element(base.pos, c('A', 'C', 'T', 'G'))]
  return(base.pos)
}
