#!/bin/bash
#$ -N log_sep_chr_validation
#$ -M userID
#$ -m beas
#$ -pe smp 1
#$ -l h_vmem=20G
#$ -l h_rt=03:00:00
#$ -cwd
#$ -S /bin/bash

#variables
TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"

#usage: java SeparateChromosomes [options] data=file [file2 file3...]
DIR="/home/jelel8/Software/LepMap2/v2016-04-27/bin/"

for i in $(ls 02_data/*linkage|sed 's/.linkage//g')
do
base=$(basename $i)

file="data=03_output/"$base"_trimmed_f.linkage"

mp="malePrior=0.01"       		#Uniform prior for recombination fraction for (maternal) paternal haplotypes [0.05]
#ap="(fe)malePrior=A B C"	     	#Affine prior for recombination fraction for (maternal) paternal haplotypes [not set]
#t="(fe)maleTheta=NUM"		        #Use fixed recombination fraction [not set]
#tml="(fe)maleTheta=ML"        		#Use maximum likelihood recombination fraction [not set]
#R="removeMarkers=m1 [m2 ...]"		# Remove markers m1 m2 ... from further analysis [not set]
im="informativeMask=23"     		#Use only markers with informative father (1), mother(2), both patrents(3) or neither parent(0) [0123]
#f="families=f1 [f2 ...]"    		#Use only families f1 f2 ... [not set]
sl="sizeLimit=1"
SL="$(echo $sl|sed 's/sizeLimit=//g')"

#Testing various lod values
	for value in {1..30}
	do
	lod=$(echo lodLimit="$value")
	java -cp $DIR SeparateChromosomes $file $sl $lod $mp $ap $t $tml $R $im $f > 03_output/map_"$base"_lod"$value"_sizeLimit"$SL".txt
	done

done 2>&1 | tee 98_log_files/"$TIMESTAMP"_separatechromosomes.log

