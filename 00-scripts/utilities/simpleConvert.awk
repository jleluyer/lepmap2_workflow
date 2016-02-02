#converts posterior to linkage file
BEGIN{
	map[0]="1 1"
	map[1]="1 2"
	map[2]="1 3"
	map[3]="1 4"
	map[4]="2 2"
	map[5]="2 3"
	map[6]="2 4"
	map[7]="3 3"
	map[8]="3 4"
	map[9]="4 4"
	if (limit == "")
		limit = 0.01
}
($1 !~ /^#/){
	if (++line < 7)
		print
	else {
		s = $1 "\t" $2
		for (i = 3;i <= NF;i+=10) {
			sum = 0
			max = 0
			for (j = 0;j < 10;++j) {
				if ($(i+j) == 1)
					max = j
				sum += $(i+j)
			}
			if (sum < 1 + limit && sum >= 0.99)
				s = s "\t" map[max]
			else
				s = s "\t" "0 0"
		}
		print s
	}
}
