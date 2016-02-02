#!/bin/bash
#$ -N log.lepmap2_SeparateChrom
#$ -M userID@ulaval.ca
#$ -m beas
#$ -pe smp 1
#$ -l h_vmem=20G
#$ -l h_rt=00:20:00
#$ -cwd
#$ -S /bin/bash

#EstimateLod deprecated
#java EstimateLODLimit data=/data4/sandrine/11_Lep_Map/data/Uneak_210_80_75_premakeped_file_20151002.linkage malePrior=-1

INPUT="/home/jelel8/file_BEN_final_f"
DIR="/home/jelel8/Software/LepMap2/bin/"
Mprior="0.01"
infoM=0123
#LOD=7
#for LOD in $(cat list_LOD)
java -cp $DIR SeparateChromosomes sizeLimit=22 data="$INPUT".linkage lodLimit="$LOD" malePrior="$Mprior" >map.lod"$LOD".NoinfoMask24.sizeLimit22.txt



: '

usage: java SeparateChromosomes [options] data=file [file2 file3...]
options:
         data=file [file2 ...]   Loads input genotypes in LINKAGE Pre-makeped format
         lodLimit=NUM [NUM2 ...] LOD score limit [10.0]
         (fe)malePrior=NUM       Uniform prior for recombination fraction for (maternal) paternal haplotypes [0.05]
         (fe)malePrior=A B C     Affine prior for recombination fraction for (maternal) paternal haplotypes [not set]
         (fe)maleTheta=NUM       Use fixed recombination fraction [not set]
         (fe)maleTheta=ML        Use maximum likelihood recombination fraction [not set]
         removeMarkers=m1 [m2 ...] Remove markers m1 m2 ... from further analysis [not set]
         informativeMask=STR     Use only markers with informative father (1), mother(2), both patrents(3) or neither parent(0) [0123]
         families=f1 [f2 ...]    Use only families f1 f2 ... [not set]
         sizeLimit=NUM           Remove LGs with < NUM markers [1]
'
