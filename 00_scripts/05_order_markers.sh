#!/bin/bash

#SBATCH -D ./ 
#SBATCH --job-name="order"
#SBATCH -o log-order.out
#SBATCH -c 4
#SBATCH -p ibismini
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=1-00:00
#SBATCH --mem=50000

cd $SLURM_SUBMIT_DIR

#usage java OrderMarkers [options] data=file1 [file2 file3...]

#variables
TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"
DIR="/home/jelel8/Software/LepMap2/v2016-04-27/bin/"


for i in $(ls 02_data/*linkage|sed 's/.linkage//g')
do
base=$(basename $i)

file="data=file.linkage"
js_lod=10
sc_lod=22
sc_sl=11



map="map=03_output/map_js.txt"
#rem="removeMarkers=m1 [m2 ...]"		# Remove markers m1 m2 ... from further analysis [not set]
#im="informativeMask=23"				# Use only markers with informative father (1), mother(2), both patrents(3) or neither parent(0) [0123]
#f="families=f1 [f2 ...]"	  		# Use only families f1 f2 ... [not set]
#nmi="numMergeIterations=NUM"			# How many iterations are performed [6]
#chr="chromosome=NUM"         			# Order only one chromosome [not set]
#io="improveOrder=0"	         		# Disable order refinement by maximizing likelihood
#red="removeDuplicates=0"	   		# Disable removing of duplicate markers
#eo="evaluateOrder=file"     			# Loads the order of markers from a file. Either map or evaluateOrder must be provided
#cls="computeLODScores=1"		    	# Evaluate pair-wise LOD scores on the order given in evaluateOrder
#maxd="maxDistance=NUM"		        	# Maximum allowed recombination probability (when evaluating likelihoods) [inf]
maxe="maxError=0.01"	       		   	# Maximum allowed haplotype error probability (when evaluating likelihoods)
#mine="minError=NUM"           			# Minimum allowed haplotype error probability (when evaluating likelihoods)
#uk="useKosambi=1"		          	# Use Kosambi mapping function (instead of Haldane).
pw="polishWindow=100"	      			# Uses only a window of NUM markers in the polishing step to obtain speedup.
fw="filterWindow=10"       			# Uses about 4 x NUM markers to decided whether it is needed to evaluate the full likelihood for all markers,to obtain speedup.
						# Only activated with more than 32 x NUM markers.
#ircb="initRecombination=0.01 0.05"   		# Initial recombination probability paternal [and maternal] [0.05, NUM2=NUM]
#ierr="initError=NUM"           		# Initial haplotype error probability [0.01]
#lep="learnErrorParameters=0"			# Disable error parameter learning [not set]
#lrpP="learnRecombinationParameters=0 1"	# Disable paternal recombination rate learning [not set]
#lrp="learnRecombinationParameters=0 0"		# Disable recombination rate learning [not set]
#lrpM="learnRecombinationParameters=1 0" 	# Disable maternal recombination rate learning [not set]
#sa="sexAveraged=1"			        # Use sex-averaged recombination rates
#a="alpha=NUM"			        	# Penalty parameter. The optimization score is 'likelihood - alpha*COUNT' [0.0]
#mc="markerClusters=file"			# Load duplicated markers from a file, file should contain two columns, marker name and cluster ID
#mcl="missingClusteringLimit=NUM"		# Allow missing rate of NUM when deciding whether two markers are duplicates [0.0] (exprimental)
#hcl="hammingClusteringLimit=NUM"		# Allow hamming difference rate of NUM when deciding whether two markers are duplicates [0.0] (exprimental)
cpu="numThreads=4"        			# CPUs

#Create Maps
java -cp $DIR OrderMarkers $map $rem $im $f $nmi $chr $io $red $eo $cls $maxd $maxe $mine $uk $pw $fw $ircb $ierr $lep $lrpP $lrp $lrpM $sa $a $mc $mcl $hcl $cpu $file >03_output/ordered_markers.txt

done 2>&1 | tee 98_log_files/"$TIMESTAMP"_ordermarkers.log
#evaluate order and compute LOD score pair-wise
#java -cp $DIR OrderMarkers evaluateOrder=ordeNoSex.txt data="$INPUT".linkage >ordeNoSex_evaluate.txt

#java -cp $DIR OrderMarkers evaluateOrder=ordeNoSex_evaluate.txt computeLODScores=1 data="$INPUT".linkage improveOrder=0 >ordeNoSex_compute.txt
