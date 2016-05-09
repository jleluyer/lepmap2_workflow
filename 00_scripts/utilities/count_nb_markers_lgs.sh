#!/bin/bash

cd $(pwd)

for i in $(ls 03_output/map_*txt|grep -v 'js'|sed 's/.txt//g')
do 
base="$(basename $i)"

grep -v '#' 03_output/"$base".txt|sort -n|uniq -c > 03_output/"$base".count

done
