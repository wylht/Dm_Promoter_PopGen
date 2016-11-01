library(Biostrings)
ToyData <- DNAStringSet(c("--GTCTGAGCATGCTTACGCGGCGT---GTCTGAGCATGCTTACGCGGCGT-", 
                          "CTGGCTGAGCATGCTGACGCTACGT-CTGGCTGAGCATGCTGACGCTACGT-", 
                          "GAGGCT--GCATGCTGACGCTACGT-GAGGCT--GCATGCTGACGCTACGT-",
                          "--GTCTGAGCATGCTTACGCGGCGT---GTCTGAGCATGCTTACGCGGCGT-",
                          "--GTCTGAGCATGCTTACGCGGCGT---GTCTGAGCATGCTTACGCGGCGT-",
                          "--GTCTGAGCATGCTTACGCGGCGT---GTCTGAGCATGCTTACGCGGCGT-",
                          "--GTCTGAGCATGCTTACGCGGCGT---GTCTGAGCATGCTTACGCGGCGT-"))

#The line below shows what syntax to use to get the bases from a DNAStringSet:
#as.character(ToyData[[1]][1])

#This fuction takes a position number and a DNAStringSet, and returns a vector of valid bases at that position
PositionExtract <- function(Position, MyString) {
  BasePosition = c()
for (seq in 1:length(MyString)){ 
  BasePosition <- paste(BasePosition, as.character(MyString[[seq]][Position]), sep="")
}
  BasePosition <- strsplit(BasePosition, "")
  BasePosition <- BasePosition[[1]]
  BasePosition <- BasePosition[is.element(BasePosition, c('A', 'C', 'T', 'G'))]
  return(BasePosition)
}

#This fuction calculates heterozygosity using the vector of valib bases at a position (from PositionExtract)
hCalc <- function(BasePosition) {
  n = length(BasePosition)
  if(n == 0){return(NULL)}
  else{
  afreq <- sum(BasePosition == 'A')
  tfreq <- sum(BasePosition == 'T')
  cfreq <- sum(BasePosition == 'C')
  gfreq <- sum(BasePosition == 'G')
  h <- (n/(n-1))*(1-((afreq/n)^2+(cfreq/n)^2+(tfreq/n)^2+(gfreq/n)^2))
  return(h)
  }
}

#This loops through the wanted positions and gives a vector of heterozygosity values
hVector <- function(startpos, endpos, MyString){
  hVec = c()
for (position in startpos:endpos){
  h<-(hCalc(PositionExtract(position, MyString)))
  hVec = c(hVec, h)
}
  return(hVec)
}

#this calculates pi for that sequence
piCalc <- function(hVec){
  return(sum(hVec)/length(hVec))
}

#Example of how to extract all bases at one position
PositionExtract(4, ToyData)

#Example of how to extract all bases at one position
hCalc(PositionExtract(4, ToyData))

#Example usage to get a vector of heterozygosity values
demo <- hVector(1, 52, ToyData)
print(demo)

#Example usage to get pi
piCalc(demo)
