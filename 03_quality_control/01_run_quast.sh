#!/bin/bash

mkdir /media/harddrive/sander/carrot_isolates/03_quality_control/in

# Copy own isolates to in folder
for isolate in /media/harddrive/sander/carrot_isolates/01_assemble_isolates/out/*/contigs.fasta
do
	isolateName=$(basename $(dirname $isolate))
	cp $isolate in/${isolateName}.fna
done

# Copy other assemblies to in folder
cp /media/harddrive/sander/carrot_isolates/02_download_ncbi_genomes/ncbi_sunetal_fna/*.fna* in/
parallel --jobs 16 --no-notice --verbose 'bunzip2' ::: in/*fna.bz2

# Run quast
quast.py -o out --threads 16 in/*.fna*

# Remove in folder to save space
rm -rf /media/harddrive/sander/carrot_isolates/03_quality_control/in
