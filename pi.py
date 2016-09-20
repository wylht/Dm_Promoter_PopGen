
# seq1 = '--GTCTGAGCATGCTTACGCGGCGT---GTCTGAGCATGCTTACGCGGCGT-'
# seq2 = 'CTGGCTGAGCATGCTGACGCTACGT-CTGGCTGAGCATGCTGACGCTACGT-'
# seq3 = 'GAGGCT--GCATGCTGACGCTACGT-GAGGCT--GCATGCTGACGCTACGT-'
# listofseq = [seq1, seq2, seq3, seq1, seq1, seq1, seq1]

from __future__ import division
import collections

positions = [''.join(x) for x in zip(*listofseq)] # list of string of bases by position value

removed_positions = [''.join(x if x in 'TAGC' else '' for x in new) for new in positions] #removes non TAGC

cleaned_positions = [pos for pos in removed_positions if sum(x.isalpha() for x in pos) > 1] # keeps strings with > 1 valid base

# calculates h
length_sequences = len(cleaned_positions) # length of list
n = [len(x) for x in cleaned_positions] # length of bases in each position
h = [(n[seq] * (1 - sum((base/n[seq])**2 for base in collections.Counter(cleaned_positions[seq]).values())) / (n[seq]-1)) for seq in range(length_sequences)] 

pi = sum(h)/len(cleaned_positions) # finds pi