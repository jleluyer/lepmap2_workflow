#!/bin/bash

#SBATCH -D ./ 
#SBATCH --job-name="filter"
#SBATCH -o log-filter.out
#SBATCH -c 1
#SBATCH -p ibismini
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=0-20:00
#SBATCH --mem=50000

cd $SLURM_SUBMIT_DIR


TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)

# Copy script as it was run
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"

#java Filtering [options] data=file1 [file2 ...] >file1_filtered.linkage

#variables
DIR="/home/jelel8/Software/LepMap2/v2016-04-27/bin/"

for i in $(ls 02_data/*.linkage|sed 's/.linkage//g')
do
base=$(basename $i)


#Loads input genotypes in LINKAGE Pre-makeped format
file="data=02_data/"$base".linkage"			# Loads input genotypes in LINKAGE Pre-makeped format
#e="epsilon=NUM"             				# Probability of a haplotype error [0.01], used to model Mendel errors
d="dataTolerance=0.001"      				# P-value limit for segregation distortion [0.01]
#rm="removeMarkers=m1 [m2 ...]" 			# Remove markers m1 m2 ... from further analysis [not set]
#hwe="outputHWE=1"             				# Output p-values of segregation distortion (to error stream)
#ml="missingLimit=NUM"        				# Filter out markers with > NUM missing values in each family [inf]
#mli="missingLimitIndividual=NUM"  			# Filter out individuals with > NUM missing values [inf]
#imf="informativeFamilyLimit=NUM"			# Filter out markers that have < NUM informative families [0]
#fis="filterIdenticalSubset=A B"   			# Filter genotypes that occur less than B times in size A subsets of adjacent individuals [1 1 = not set]
#nil="nonIdenticalLimit=NUM"   				# Filter out markers based on low number of identical (or complementary) segregation patterns in each family[1]
#nnil="nonNearIdenticalLimit=NUM1 NUM2"  		# Same as above but allows missing rate of NUM2 when considering patterns to be identical [1 0.0]
#maf="MAFLimit=NUM"					# Filter out markers with minimum allele frequency < NUM in each family [0.0]
#ka="keepAlleles=1" 					# Keep the same alleles in the data as were in the input


java -cp $DIR Filtering $file $e $d $rm $hwe $ml $mli $imf $fis $nil $nnil $maf $ka >03_output/"$base"_trimmed_f.linkage 

done 2>&1 | tee 98_log_files/"$TIMESTAMP"_filtering.log
