#!/bin/bash

ps=/media/harddrive/tools/spades/SPAdes-3.12.0-Linux/bin/spades.py

parallel --jobs 16 --no-notice 'gunzip' ::: in/*fastq.gz

for isolate in in/*R1*fastq
do
        removePath=$(basename "$isolate")
        isolateName=${removePath%%_*}

	$ps --pe1-1 in/${isolateName}*R1*.fastq \
		--pe1-2 in/${isolateName}*R2*.fastq \
		-t 16 \
		-o out/${isolateName}  \

done

parallel --jobs 16 --no-notice 'gzip' ::: in/*fastq
