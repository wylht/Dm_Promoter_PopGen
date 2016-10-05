#!/bin/bash

DIR=CLARK_sequences/CLARK_Chr2

cd $DIRL

for i in *.seq;
 do
t=$(basename $i .seq)
awk -v c="> $t" '{ print c; print $0; }' $i > $t.fasta
done

echo "Conversion of SEQ files complete"
