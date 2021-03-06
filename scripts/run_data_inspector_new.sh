#!/bin/bash
set -e
set -u
#set -o pipefail

cd data/

echo; echo "* Inspecting and Manipulating Text Data with Unix Tools"

# p.425 | Variables and Command Arguments
# create a variable and assign it a value with (do not use spaces around the equals sign!):  
FNA=GCA_000376725.2_Lful_2.0_genomic.fna
GFF=GCA_000376725.2_Lful_2.0_genomic.gbff

# To access a variable’s value, we use a dollar sign in front of the variable’s name:  
echo $FNA
echo $GFF

echo; echo "* Inspecting Data with Head and Tail"
head -n 10 $GFF
tail -n 3 $GFF

echo; echo "* Using grep, cut, sort, uniq to summarize columns of data"
#grep -v "^#" $GFF | cut -f3 | sort | uniq -c
# pipe these results to sort -rn to show these counts in order from most frequent to least
#grep -v "^#" $GFF | cut -f3 | sort | uniq -c | sort -rn

# Pipe the standard output to the next command with the pipe character (|):  
grep "^>" $FNA | wc -l
grep "^#" $GFF | wc -l

# exclude lines that begin with "#":  
grep -v "^#" $GFF | head -n 3

# p.151 | Working with Column Data with cut and Columns

# chop off the metadata rows using `grep`, and then use `cut` to extract the first, fourth, and fifth columns (chromosome, start, end):
echo; echo "* Only 1,4,5"
grep -v "^#" $GFF | cut -f1,4,5 | head -n 3

echo; echo "* Using grep, cut, sort, uniq to summarize columns of data2"
#grep -v "^#" $GFF | cut -f3 | sort | uniq -c
# pipe these results to sort -rn to show these counts in order from most frequent to least
grep -v "^#" $GFF | cut -f3 | sort | uniq -c | sort -rnß
grep -v "^#" $GFF | cut -f3,7 | sort | uniq -c | sort -rn

# p.170 | Text Processing with Awk
# p.157: `grep -o` extract only the matching part of the pattern. 
# rRNA遺伝子（16S、23S、5S）をカウントする:  
awk -F"\t" '$3 ~ /rRNA/ { print $0 }' $GFF | grep -E -o 'product=.+' | sort | uniq -c

# p.173: add a column with the feature length (end position - start position) for only "CDS"
awk -F"\t" '$3 ~ /CDS/ { print $5 - $4 "\t" $0 }' $GFF | sort -k1,1n | tail -n 1

# p.147 | Plain-Text Data Summary Information with wc, ls, and awk
# `ls -lh` reports human-readable file sizes
ls -lh

# `wc -l` outputs the number of lines
wc -l *