

'''
#These are my test sequences
seq1 = '--GTCTGAGCATGCTTACGCGGCGT---GTCTGAGCATGCTTACGCGGCGT-'
seq2 = 'CTGGCTGAGCATGCTGACGCTACGT-CTGGCTGAGCATGCTGACGCTACGT-'
seq3 = 'GAGGCT--GCATGCTGACGCTACGT-GAGGCT--GCATGCTGACGCTACGT-'
listofseq = [seq1, seq2, seq3, seq1, seq1, seq1, seq1]
'''

import collections

#This piece of code makes one string for each position of all the sequences
positions = [''.join(x) for x in zip(*listofseq)]

#This function removes all bases that are not A C T or G
def checkbases(positions):
    checkedpos = ''
    for pos in positions:
        if pos == 'A':
            checkedpos += 'A'
        elif pos == 'C':
            checkedpos += 'C'
        elif pos == 'T':
            checkedpos += 'T'
        elif pos == 'G':
            checkedpos += 'G'
        else:
            checkedpos += ''
    return 


#This applies the fuction to the list sequences
ckdpositions = []
for i in range (0, len(positions)):
    ckdpositions.append(checkbases(positions[i]))

#This removes strings that have only one valid base
#This removes empty strings (ones that did not contain any valid bases)
cleaned_positions = [pos for pos in positions if sum(x.isalpha() for x in pos) > 1]


#This calculates h for a given string that has all bases for that position
h = []
for posit in cleaned_positions:
    n = float(len(position))
    counts = collections.Counter(posit)
    h.append((n/(n-1)) * (1-((counts['A']/n)**2 + (counts['C']/n)**2 + (counts['T']/n)**2 + c(counts['G']/n)*2)))


pi = sum(h)/len(cleaned_positions)

print("Thank you for using Guillaume's code!")
print("Number of SNPs in the sample:")
print(len(filter(None, hvals)))
print("Number of chromosomes in the sample:")
print(len(seq_list))
print("pi for the alignment entered is:")
print(sum(hvals)/len(ckdpositions))

