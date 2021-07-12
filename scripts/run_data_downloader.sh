#!/bin/bash
set -e
set -u
set -o pipefail

echo; echo "[$(date)] $0 job has been started."

# Creating directories
# mkdir -p {data/$(date +%F),scripts,analysis}
# cd data/$(date +%F)
cd data/

# Downloading data
# Ladona fulva
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/376/725/GCA_000376725.2_Lful_2.0/GCA_000376725.2_Lful_2.0_genomic.fna.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/376/725/GCA_000376725.2_Lful_2.0/GCA_000376725.2_Lful_2.0_genomic.gbff.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/376/725/GCA_000376725.2_Lful_2.0/md5checksums.txt

echo; echo "## MD5 checksum"
md5 *.gz
grep "_genomic.fna.gz" *md5checksums.txt
grep "_genomic.gbff.gz" *md5checksums.txt

# decompress files with the command gunzip:
gunzip *.gz

# Done
echo; echo "[$(date)] $0 has been successfully completed."
