#Example of how to extract all bases at one position
PositionExtract(4, ToyData)

#Example usage to get a vector of heterozygosity values
demo <- hVector(1, 52, ToyData)
print(demo)

#Example usage to get pi
piCalc(demo)
