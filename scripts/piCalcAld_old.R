#This function calculates heterozygosity using the vector of valib bases at a position (from PositionExtract)

piCalc <- function(BasePosition) {
  n <- length(BasePosition)
  #print(n)  
  BasePosition <- table(BasePosition)
  afreq <- sum(BasePosition == 'A')
  tfreq <- sum(BasePosition == 'T')
  cfreq <- sum(BasePosition == 'C')
  gfreq <- sum(BasePosition == 'G')
  #print(afreq)
  #print(tfreq)
  #print(cfreq)
  #print(gfreq)
  h <- (n/(n-1))*(1-(afreq*afreq+cfreq*cfreq+tfreq*tfreq+gfreq*gfreq))
  if(n == 0){return(NULL)}
  else{return(h)}
}
