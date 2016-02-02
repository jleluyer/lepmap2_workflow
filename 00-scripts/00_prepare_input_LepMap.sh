#prepare the vcf
cat batch_1.vcf|grep -v '##' > batch_1.trim.vcf

#transpose column
./transpose.sh

awk '
{ 
    for (i=1; i<=NF; i++)  {
        a[NR,i] = $i
    }
}
NF>p { p = NF }
END {    
    for(j=1; j<=p; j++) {
        str=a[1,j]
        for(i=2; i<=NR; i++){
            str=str" "a[i,j];
        }
        print str
    }
}'  batch_1.trim.vcf > step1transpose.txt


# remove first lanes

#modify the parsing
sed 's/,. /:/g' step1.transpose.txt|sed 's/,./:/g' > step2.transpose.txt  

#print only genotypes
awk 'BEGIN {FS = ":"} {for (i = 1; i <= NF; i += 4) printf ("%s%c", $i, i + 4 <= NF ? "," : "\n");}' step2.transpose.txt > step3.transpose.txt

#modify the genotypes to fit the .linkage format
sed 's#0/#2/#g' step3.transpose.txt|sed 's#/0#/2#g'|sed 's/\./0/g' > step4.transpose.txt

#sort both sex and data files
sort -k 1 files> files.sort
#join
join file_sex_sort_good.txt step4.transpose.txt> step5.transpose.txt

Sex file looks like:
SFO_1	SFO	dad	mom	2	0
SFO_10	SFO	dad	mom	1	0
SFO_100	SFO	dad	mom	1	0

with 1) sample name 2) familly name,3) father name 4)mother name, 5) sex and 6) phenotype
#parse the file
sed 's/,/ /g' step5.transpose.txt|awk -v OFS="\t" '$1=$1'|sed 's#/# #g' > step6.transpose.txt


#swap column 1 and 2
awk -F "\t" 'BEGIN{OFS=FS}{t=$i;$i=$j;$j=t;}1' i=1 j=2 step6.transpose.txt > file.linkage

#get markers ID associated with marker num
cat batch_1.vcf|sed '1,10d'|awk '{print $3}' > markers_ID.txt

#create list of increasing number corresponding to markers number
 :put =range(1,8148)

and output in list_markers.txt

#merge two files
 paste list_markers.txt markers_ID.txt > list_markers_ID.txt
