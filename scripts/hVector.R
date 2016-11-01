#This loops through the wanted positions and gives a vector of heterozygosity values
hVector <- function(MyString, startPos, endPos) {
  hVec = c()

  message("\nPi calculation in progress for the selected range...\n")

  for (i in startPos:endPos) {
      h <- piCalc(extractPos(MyString, i))
#     print(h)
      hVec = c(hVec, h)
  }
  
  return(hVec)
}
