#!/bin/bash

DIR="data/DmNexus/CLARK_Chr2L"
HEADER="Chr2L"

cd $DIR

for i in *.seq;
 do
t=$(basename $i .seq)
awk -v c="> $t" '{ print c; print $0; }' $i > $t.fasta
done

echo "Conversion of SEQ files complete"

cat *.fasta > $HEADER.combined.fasta

echo "Concatentation of fasta files complete."


