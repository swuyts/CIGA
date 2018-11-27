#!/bin/bash
# Possible updates:
# - Use DNA instead of Proteins

pout=/media/harddrive/sander/carrot_isolates/06_phylogenetic_tree/supermatrix_out/

pin_OrthoFinder=/media/harddrive/sander/carrot_isolates/05_pangenome/Results_Sep05/
pin_OrthoFinderSeqs=/media/harddrive/sander/carrot_isolates/05_pangenome/Results_Sep05/Orthologues_Sep05/Alignments/

threads=16

mkdir $pout
cd $pout
mkdir ${pout}alignments

echo COPYING ALIGNMENT FILES
echo
while IFS='' read -r line || [[ -n "$line" ]]; do
	echo $line
	cp ${pin_OrthoFinderSeqs}${line}.fa.bz2 ${pout}alignments
done < ${pin_OrthoFinder}SingleCopyOrthogroups.txt
echo

echo MAKING SUPERALIGNMENT
echo
bunzip2 ${pout}alignments/*bz2
sed -i 's/GCA_/GCA-/g' ${pout}alignments/*.fa
python ../scripts/geneStitcher.py -d _ -in ${pout}alignments/*.fa
bzip2 ${pout}alignments/*fa
echo
