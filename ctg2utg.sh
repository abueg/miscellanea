#!/bin/bash

###########
## USAGE ##
###########
# bash ctg2utg.sh h1tg000148l bTaeGut2.trim.HiC.hic.hap1.p_ctg.gfa bTaeGut2.trim.HiC.hic.r_utg.gfa

contig=$1
contiggfa=$2
unitiggfa=$3
echo The unitigs in $unitiggfa that correspond to $contig in $contiggfa are:
grep $contig <(grep -e "^A" $contiggfa) | cut -f 5 | grep -f - <(grep -e "^A" $unitiggfa) | cut -f 2 | sort | uniq
