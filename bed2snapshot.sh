#!/bin/bash
echo Script for converting a BED file to an IGV snapshot batch script
if [[ -z $1 ]] || [[ -z $2 ]]; then
    echo "Usage: ./bed2snapshotscript.sh <BED file> <BP upstream> <BP downstream> <snapshot dir> <output prefix>"
    echo -e "\t<BP upstream>: base pairs upstream of the start coordinate in the BED file"
    echo -e "\t<BP downstream>: base pairs downstream of the end coordinate in the BED file"
    echo -e "\t<snapshot dir>: directory where IGV will put the snapshots"
    echo -e "\t<output prefix>: the output script will be named <output prefix>.bat"
    exit -1
fi

export BEDFILE=$1
export UPSTREAM=$2
export DOWNSTREAM=$3
export SNAPSHOTDIR=$4
export SNAPSHOTFILE=$5

echo "Converting coordinates from $BEDFILE to IGV snapshot batch script"
echo "Using $SNAPSHOTDIR as snapshot directory"
echo "Snapshots are $UPSTREAM bp upstream of start coord and $DOWNSTREAM bp downstream of end coord"

echo snapshotDirectory $SNAPSHOTDIR > $SNAPSHOTFILE.bat
awk -v var1=$UPSTREAM -v var2=$DOWNSTREAM 'OFS="/t" { print "goto "$1":"$2-var1"-"$3+var2"\nmaxPanelHeight 300\nsnapshot gapfill_"$1"_"$2"_"$3".png" }' $BEDFILE >> $SNAPSHOTFILE.bat

echo "Finished, $SNAPSHOTFILE.bat has been written."

