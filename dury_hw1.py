import sys

#This deals with the command line input from the user
popset = open(sys.argv[1])

'''
#This is the hardcoded filename used for while writing the code
popset = open("197126382.fasta")
'''

#Read the different lines of the file
lines = popset.readlines()
sequence = ""
name_list=[]
seq_list=[]
for line in lines:
    line=line.strip()
    if line.startswith('>'):
        sequence += ' '
        head, sep, tail = line.partition(' ')
        name_list.append(head[1::])
    else:
        sequence += line
#Uses spaces to seperate the sequences in the string to make the list
seq_list = sequence.strip().split()

'''
#These are my test sequences
seq1 = '--GTCTGAGCATGCTTACGCGGCGT---GTCTGAGCATGCTTACGCGGCGT-'
seq2 = 'CTGGCTGAGCATGCTGACGCTACGT-CTGGCTGAGCATGCTGACGCTACGT-'
seq3 = 'GAGGCT--GCATGCTGACGCTACGT-GAGGCT--GCATGCTGACGCTACGT-'
listofsequs = [seq1, seq2, seq3, seq1, seq1, seq1, seq1]
'''

#This piece of code makes one string for each position of all the sequences
positions=list(seq_list[0])
for j in range (1, len(seq_list)):
    for i in range (0, len(seq_list[0])):
        positions[i] = positions[i]+seq_list[j][i]

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
    return checkedpos
#This applies the fuction to the list sequences
ckdpositions = []
for i in range (0, len(positions)):
    ckdpositions.append(checkbases(positions[i]))
#This removes strings that have only one valid base
for pos in ckdpositions:
    if len(pos)>1:
        pos = pos
    else:
        pos = ''
#This removes empty strings (ones that did not contain any valid bases)
ckdpositions = filter(None, ckdpositions)

#This calculates h for a given string that has all bases for that position
def hcalc(position):
    n = float(len(position))
    afreq = float(position.count('A'))/n
    cfreq = float(position.count('C'))/n
    tfreq = float(position.count('T'))/n
    gfreq = float(position.count('G'))/n
    h = (n/(n-1))*(1-(afreq*afreq+cfreq*cfreq+tfreq*tfreq+gfreq*gfreq))
    return h

#This gets a list of h values and sums it to get pi
hvals = []
for i in range (0, len(ckdpositions)):
    hvals.append(hcalc(ckdpositions[i]))

print("Thank you for using Guillaume's code!")
print("Number of SNPs in the sample:")
print(len(filter(None, hvals)))
print("Number of chromosomes in the sample:")
print(len(seq_list))
print("pi for the alignment entered is:")
print(sum(hvals)/len(ckdpositions))

