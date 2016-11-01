### INFO-I 529 Project ###
List of group members:
* Krishna Bathina
* Guillaume Dury
* Xuan Wang
* R. Taylor Raborn (co-advisor)

Agenda items from 9-12 meeting

1. Read and become familiar with background literature, especially Hoskins and Lenhard et al (2011 and 2012, respectively).
2. To decide which PopGen dataset(s) to use in our study, and to become familiar with it (/them).
3. To determine whether peaked/broad promoter classifications are available from Hoskins or whether this needs to be via Taylor's pipeline.

Agenda items from 9-19 meeting

1. Agreed on using the Clark population data from Fly Nexus database.
2. Plan of attack: create a figure that evaulates pi within the core promoter.
3. Need to add:i) pi calculator, which can then be incorporated into larger scripts, and ii) the promoter data (TR).
4. Agreed on using github for code and and small files and Box for very large (>50MB) files.

Misc updates 9-22

1. Krishna added a pi calculator script: py.pi (thanks to Guillaume for adding his code on Monday). Taylor tweaked the code very slightly so it automatically outputs pi given the embedded test data.
2. Our storage allocation is now available at /N/dc2/projects/PromoterPopGen . Please check to see if you i) can navigate into the directory and ii) encounter any permissions issues creating a test directory/file.

Misc updates 10-4

1. Meeting scheduled for 10-11 at 5:30PM (location TBA).
2. RTR added a relevant Population Genomics link to reading list.
3. RTR wrote and added 'importSeq', an R file that imports fasta data derived from SEQ data.

Misc updates 10-5

1. RTR added seqConvert.sh, which converts all SEQ files to FASTA format; the header is the filename before the .seq prefix.
2. RTR converted all SEQ files in our `/N/dc2/projects/PromoterPopGen/` folder to FASTA format using seqConvert.sh.

Misc updates 10-11

1. Our meeting was extremely productive. We discussed our current progress, the data structure (DNAstring object in R) and the things that need to be done.
2. We agreed to focus on the following two issues: i) how to manipulate the DNAstring object to calculate pi and ii) subsetting the DNAstring object to retrieve only the intervals of interest (i.e. promoters)
3. RTR added an example of the DNAstring object (as an R binary in .RData format) to our folder on UITS (see /data). Load the file into your R workspace using the following command:
`R
load("DNAstrings_example.RData")
`

Misc updates 10-20

1. Guillaume and Taylor met to get through our problem with accessing strings from DNAStringSet objects. We're happy to report that we have solved this; we'll report how below.
2. RTR modified immportSEQ.R to operate on a single combined (multiple SEQ files concatenated toegher) fasta file at a time.
3. Character information can be extracted from a DNAStringSet object (please see the sample object in /data)  as follows:
`R
load("DNAstring_example.RData")
as.character(sample_DNAstring[[1]][20000:20100])
[1] "TGTGGCCGAATTTATTCTAAACTGAAAATAATAATAAAAATTAATCAAATTTTCAATAAGTAAAAAATTAAAAAGGAACTTGTATATTTTTTCACTCTTAT"
`
4. Guillaume is now re-implementing the pi caculator in R, and RTR is writing a function to extract sequences from a given interval (e.g. from a BED file).
