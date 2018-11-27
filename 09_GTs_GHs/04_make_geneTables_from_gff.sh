# Originally written by S. Wittouck
# Adapted by S. Wuyts

pin_prokka=/media/harddrive/sander/carrot_isolates/04_annotation/out/
pout=/media/harddrive/sander/carrot_isolates/11_GTs_GHs/out_geneTables/

mkdir $pout
cd $pout

echo EXTRACT GENETABLE AND CONTIGTABLE FROM EACH GFF
echo

parallel --jobs 16 --no-notice bunzip2 {} ::: ${pin_prokka}*/*.gff.bz2

for file in ${pin_prokka}*/*.gff; do
	genome=${file%.gff}
	genome=${genome##*/}
	grep -v '#' $file | awk -v FS="\t" -v genome=$genome '$3 == "CDS" {print $1,genome,$4,$5,$7,$9}' | cut -d'|' -f3 | cut -d';' -f1 > ${genome}_geneTable.tsv
	grep '##sequence-region' $file | cut -d'|' -f3 > ${genome}_contigTable.tsv
done

echo CAT ALL FILES INTO ONE SUPERFILE
echo
cat *_geneTable.tsv > geneTable_allGenomes.tsv
cat *_contigTable.tsv > contigTable_allGenomes.tsv
echo

parallel --jobs 16 --no-notice bzip2 {} ::: ${pin_prokka}*/*.gff

