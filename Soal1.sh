#!/bin/bash

satu=$(awk -F'\t' '{sum[$13]+=$21} END {for (i in sum) print i }' dataset.tsv | sort -g | head -n1)
echo $satu
echo " "

dua=$(awk -v satu=$satu -F'\t' '{if ($13==satu) sum[$11]+=$21;} END {for (i in sum) print i }' dataset.tsv | sort -g | head -n2)
echo $dua
echo " "

dua=($(echo $dua | tr " " "\n"))
for i in "${dua[@]}"
do
	echo $i
	awk -v dua=$i -F'\t' 'BEGIN {print dua} {if($11==dua) sum[$17]+=$21;} END {for (i in sum) print i}' dataset.tsv | sort -g | head -n10
	echo " "
done
