#This fuction takes a position number and a DNAStringSet, and returns a vector of valid bases at that position

positionExtract <- function(Position, MyString) {
  BasePosition = c()
      for (seq in 1:length(MyString)){ 
          BasePosition <- paste(BasePosition, as.character(MyString[[seq]][Position]), sep="")
          }

  BasePosition <- strsplit(BasePosition, "")
  BasePosition <- BasePosition[[1]]
  BasePosition <- BasePosition[is.element(BasePosition, c('A', 'C', 'T', 'G'))]
  return(BasePosition)
}
