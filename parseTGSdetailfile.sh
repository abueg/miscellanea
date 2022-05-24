#!/bin/bash
DETAILFILE=$1
## while reading DETAILFILE, for each line 1) if line is header, then save to variable, 
## 2) if line is not header, then print [header variable] and [line contents]
## saved to a parseable tsv file with all information
while read line ; do
	if [[ $line == \>* ]]
	then
		HEADER=$line 
	else
		printf "%s\t%s\n" "$HEADER" "$line"
	fi
done < $DETAILFILE > $DETAILFILE.parseable.tsv

# retain only the coordinates for the filled assembly
# turn into BED file, replace F/S/G with full names for IGV track
# subtract 1 from start position to get 0-based coords for BED
cut -f 1,2,3,4 $DETAILFILE.parseable.tsv | sed -e 's/>//g' -e 's/F$/GapFill/g' -e 's/S$/OriginalSequence/g' -e 's/N$/RemainingGap/g' | awk ' BEGIN { OFS = "\t" } { print $1,($2-1),$3,$4 }' > $DETAILFILE.bed

