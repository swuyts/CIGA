#!/bin/bash

ptemp=/media/harddrive/sander/carrot_isolates/11_GTs_GHs/temp
pgenomes=/media/harddrive/sander/carrot_isolates/04_annotation/out/
pdb=/media/harddrive/sander/carrot_isolates/11_GTs_GHs/in/dbCAN-fam-HMMs_converted.txt
pout=/media/harddrive/sander/carrot_isolates/11_GTs_GHs/out/

mkdir -p $pout
mkdir -p $ptemp
cd $ptemp

echo
echo COPYING ALL GENOMES TO TEMP FOLDER
cp ${pgenomes}*/*faa* .
echo
parallel --jobs 16 --no-notice 'bunzip2' ::: *.faa.bz2
echo

cd $pout

echo RUNNING HMM SCAN ON EACH GENOME
echo
for isolate in ${ptemp}/*faa
do
        isolateName=$(basename $isolate)
	isolateName2=${isolateName%.*}
	echo $isolateName2

	hmmscan --domtblout ${pout}${isolateName2}_hits.tsv $pdb $isolate
	echo PARSING
	../in/hmmscan-parser.sh ${pout}${isolateName2}_hits.tsv > ${pout}${isolateName2}_parsed.tsv
done
echo

rm -r $ptemp
