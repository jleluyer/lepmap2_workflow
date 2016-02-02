#!/bin/bash
#$ -N log.lepmap2_filtering
#$ -M userID@ulaval.ca
#$ -m beas
#$ -pe smp 1
#$ -l h_vmem=20G
#$ -l h_rt=00:20:00
#$ -cwd
#$ -S /bin/bash

#EstimateLod deprecated

INPUT="/home/jelel8/file_BEN_final"
DIR="/home/jelel8/Software/LepMap2/bin/"

for DT in $(cat list_DT)
do
java -cp $DIR Filtering data="$INPUT".linkage dataTolerance=$DT > "$INPUT"_f.DT"$DT".linkage
done

: '
usage: java Filtering [options] data=file1 [file2 ...] >file1_filtered.linkage
options:
         data=file [file2 ...]   Loads input genotypes in LINKAGE Pre-makeped format
         epsilon=NUM             Probability of a haplotype error [0.01], used to model Mendel errors
         dataTolerance=NUM       P-value limit for segregation distortion [0.01]
         removeMarkers=m1 [m2 ...] Remove markers m1 m2 ... from further analysis [not set]
         outputHWE=1             Output p-values of segregation distortion (to error stream)
         missingLimit=NUM        Filter out markers with > NUM missing values in each family [inf]
         missingLimitIndividual=NUM  Filter out individuals with > NUM missing values [inf]
         informativeFamilyLimit=NUM  Filter out markers that have < NUM informative families [0]
         filterIdenticalSubset=A B   Filter genotypes that occur less than B times in size A subsets of adjacent individuals [1 1 = not set]
         nonIdenticalLimit=NUM   Filter out markers based on low number of identical (or complementary) segregation patterns in each family[1]
         nonNearIdenticalLimit=NUM1 NUM2   Same as above but allows missing rate of NUM2 when considering patterns to be identical [1 0.0]
         MAFLimit=NUM            Filter out markers with minimum allele frequency < NUM in each family [0.0]
         keepAlleles=1           Keep the same alleles in the data as were in the input
'
