## Commands necessary to obtain pi for a set of coordinates

## In an R console
## loading the sample dataset (which is located at /N/dc2/projects/PromoterPopGen)
load("DNAstring_example.RData")

# loading the code into our workspace
source("scripts/hCalc.R")
source("scripts/hVector.R")
source("scripts/extractPos.R")
source("scripts/retrievePi.R")

# calculting pi for an arbitrarily-selected set of coordinates
retrievePi(sample_DNAstring, 6000000, 6000020)

# this should return a table to your workspace with pi of 0 except at the 13th position:
....
 13    6000012 0.4285714
...
