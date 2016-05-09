#!/bin/bash

for i in $(ls 03_output/map_batch_1.genotypes_46.loc_lod*); do grep -v '#' $i|sort -n|uniq -c > 03_output/"$i".count; done
