import sys


#This deals with the command line input from the user
popset = open(sys.argv[1])

'''
#This is the hardcoded filename used for while writing the code
popset = open("HW2.fa")


#These are my test sequences
seq1 = '--GTCTGAGCATGCTTACGCGGCGT---GTCTGAGCATGCTTACGCGGCGT-'
seq2 = 'CTGGCTGAGCATGCTGACGCTACGT-CTGGCTGAGCATGCTGACGCTACGT-'
seq3 = 'GAGGCT--GCATGCTGACGCTACGT-GAGGCT--GCATGCTGACGCTACGT-'
listofsequs = [seq1, seq2, seq3, seq1, seq1, seq1, seq1]
'''

#Read the different lines of the file
lines = popset.readlines()
sequence = ""
name_list=[]
seq_list=[]
qual_lines=[]
for line in lines:
    line=line.strip()
    if line.startswith('>'):
        sequence += ' '
        head, sep, tail = line.partition(' ')
        name_list.append(head[1::])
    elif any(i.isdigit() for i in line):
        qual_lines.append(line)
    else:
        sequence += line
#Uses spaces to seperate the sequences in the string to make the list
seq_list = sequence.strip().split()
#Uses spaces to seperate quality scores into vectors
qualscore_list=[]
for line in qual_lines:
    qualscore_list += line.split()
#Uses sequence lenghts to seperate qual scores into a list
#of lists that match the sequences
j = 0
listofzeros = [0] * len(seq_list[1])
qual_list = [listofzeros for _ in xrange(len(seq_list))]
for i in range(0,len(seq_list)):
    qual_list[i]=qualscore_list[(j):(len(seq_list[i])+j)]
    j = j+len(seq_list[i])

#This piece of code makes one string for each position of all the sequences
#but only if the base is not missing and if
#the quality score of that base is 20 or above
positions=list(seq_list[0])
for j in range (1, len(seq_list)):
    for i in range (0, len(seq_list[0])):
        if seq_list[j][i] == 'A':
            if int(qual_list[j][i]) >= 20:
                positions[i] = positions[i]+seq_list[j][i]
            else:
                continue
        elif seq_list[j][i] == 'C':
            if int(qual_list[j][i]) >= 20:
                positions[i] = positions[i]+seq_list[j][i]
            else:
                continue
        elif seq_list[j][i] == 'T':
            if int(qual_list[j][i]) >= 20:
                positions[i] = positions[i]+seq_list[j][i]
            else:
                continue
        elif seq_list[j][i] == 'G':
            if int(qual_list[j][i]) >= 20:
                positions[i] = positions[i]+seq_list[j][i]
            else:
                continue
        else:
            continue
ckdpositions = positions

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
    if len(ckdpositions[i])>1:
        hvals.append(hcalc(ckdpositions[i]))
    else:
        continue

print("Thank you for using Guillaume's code!")
print("Number of SNPs in the sample:")
print(len(filter(None, hvals)))
print("Number of chromosomes in the sample:")
print(len(seq_list))
print("The length of the sequence is:")
print(str(len(seq_list[1]))+" bp")
print("pi for the alignment entered is:")
print(sum(hvals)/len(hvals))


