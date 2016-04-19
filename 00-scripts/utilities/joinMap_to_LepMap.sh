#!/bin/bash


#alias
INPUT=$1

#converts JoinMap loc files to linkage
grep \< $INPUT|grep \> |cut -f 1 >$INPUT.markernames
grep \< $INPUT|grep \>|cut -f 2-|./00-scripts/utilities/transpose_tab|sed -e 's/[\<,\>]//g' -e 's/x/\t/g'|tr [A-Z] [a-z]|sed -e 's/-/0 /g' -e 's/[l]/1 /g' -e 's/m/2 /g' -e 's/n/3 /g' -e 's/p/4 /g' -e 's/e/5 /g' -e 's/f/6 /g' -e 's/g/7 /g' -e 's/h/8 /g' -e 's/k/9 /g' -e 's/a/1 /g' -e 's/b/2 /g' -e 's/c/3 /g' -e 's/d/4 /g'|sed -e 's/ \t/\t/g'|awk 'BEGIN{FS="\t";fn="FAMILY"}{if (line == 0) {for (i = 1; i <= NF; i+=2) f = f $i "\t";for (i = 2; i <= NF; i+=2) m = m $i "\t";print fn "\t" ++line "\t0\t0\t1\t0\t" f;print fn "\t" ++line "\t0\t0\t2\t0\t" m;} else print fn "\t" ++line "\t1\t2\t0\t0\t" $0}'
