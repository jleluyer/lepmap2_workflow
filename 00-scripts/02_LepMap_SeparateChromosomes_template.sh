#!/bin/bash
#$ -N log.lepmap2_SeparateChrom
#$ -M userID@ulaval.ca
#$ -m beas
#$ -pe smp 1
#$ -l h_vmem=20G
#$ -l h_rt=03:00:00
#$ -cwd
#$ -S /bin/bash

#usage: java SeparateChromosomes [options] data=file [file2 file3...]


file="data=03-output/map_trimmed_f.linkage"
DIR="/home/jelel8/Software/LepMap2/bin/"
mp="malePrior=0.01"       		#Uniform prior for recombination fraction for (maternal) paternal haplotypes [0.05]
#ap="(fe)malePrior=A B C"	     	#Affine prior for recombination fraction for (maternal) paternal haplotypes [not set]
#t="(fe)maleTheta=NUM"		        #Use fixed recombination fraction [not set]
#tml="(fe)maleTheta=ML"        		#Use maximum likelihood recombination fraction [not set]
#R="removeMarkers=m1 [m2 ...]"		# Remove markers m1 m2 ... from further analysis [not set]
im="informativeMask=23"     		#Use only markers with informative father (1), mother(2), both patrents(3) or neither parent(0) [0123]
#f="families=f1 [f2 ...]"    		#Use only families f1 f2 ... [not set]
sl="sizeLimit=1"
#lod="lodLimit=12"

#Testing various lod values
for value in {1..30}
do
	lod=$(echo lodLimit="$value")
java -cp $DIR SeparateChromosomes $file $sl $lod $mp $ap $t $tml $R $im $f > 03-output/map_lod"$value"_sizeLimit$sl.txt
done

#optimal lod and sl
#java -cp $DIR SeparateChromosomes $file $sl $los $mp $ap $t $tml $R $im $f > 03_output/map_lod"$value"_Mask23_sizeLimit1.txt
