#!/bin/bash
#$ -N log.lepmap2_filtering
#$ -M userID@ulaval.ca
#$ -m beas
#$ -pe smp 1
#$ -l h_vmem=20G
#$ -l h_rt=00:20:00
#$ -cwd
#$ -S /bin/bash


#usage: java Filtering [options] data=file1 [file2 ...] >file1_filtered.linkage


cd /home/jelel8/LepMap2_workflow


#Loads input genotypes in LINKAGE Pre-makeped format
DIR="/home/jelel8/Software/LepMap2/bin/"
file="data=02-raw_data/file.linkage"			# Loads input genotypes in LINKAGE Pre-makeped format
#e="epsilon=NUM"             				# Probability of a haplotype error [0.01], used to model Mendel errors
d="dataTolerance=0.01"      				# P-value limit for segregation distortion [0.01]
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


java -cp $DIR Filtering $file $e $d $rm $hwe $ml $mli $imf $fis $nil $nnil $maf $ka >03-output/map_trimmed_f.linkage

