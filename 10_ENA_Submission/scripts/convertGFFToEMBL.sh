#!/bin/bash

########################################################
# Script example to simplify the use of many options #
########################################################

#PATH to the FASTA file used to produce the annotation = .fna file
GENOME=$1

#PATH to the ANNOTATION in gff3 FORMAT
ANNOTATION=$2

#PROJECT name registered on EMBL
PROJECT=$3

#Locus tag registered on EMBL
LOCUS_TAG=$4

# species name
SPECIES=$5

# Taxonomy
TAXONOMY="PRO"

#The working groups/consortia that produced the record. No default value
REFERENCE_GROUP="UANTW"

#Translation table
TABLE="11"

#Strain
STRAIN=$6

#Topology.
TOPOLOGY="circular"

#Molecule type of the sample.
MOLECULE="genomic DNA"

#Output file
OUTPUT=$7

myCommand="EMBLmyGFF3 --rg $REFERENCE_GROUP -i $LOCUS_TAG -p $PROJECT -t $TOPOLOGY -m \"$MOLECULE\" -r $TABLE -t linear --strain $STRAIN -s \"$SPECIES\" -q -x $TAXONOMY -o $OUTPUT $ANNOTATION $GENOME"
echo -e "Running the following command:\n$myCommand"

#execute the command
eval $myCommand
