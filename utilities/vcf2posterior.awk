#awk -f vcf2posterior.awk input.vcf >output.posterior
BEGIN{
	FS="\t"
	for (i = 0; i <= 1000; ++i)
		pow[i] = 10**(-i / 10)
}

(!($1 ~ /^##/)){
	if (!first) {
		s = $1 "\t" $2
		for (i = 10; i <= NF; ++i)
			s = s "\t" $i
		print s
		first = 1
	}
	else {
		n = split($9, format, ":")
	
		for (j = 1; j <= n; ++j)
			if (format[j] == "PL")
				break
		numAlleles = split($4 "," $5, alleles, ",")

		if (j <= n && numAlleles <= 4 && numAlleles >= 2) {
			s = $1 "\t" $2
			for (i = 10; i <= NF; ++i) {

				if ($i == "./.")
					s = s "\t1 1 1 1 1 1 1 1 1 1"
				else {
					split($i, format, ":")
					split(format[j], pl, ",")
					if (numAlleles == 2)
						s = s "\t" pow[pl[1]]+0 " " pow[pl[2]]+0 " 0 0 " pow[pl[3]]+0 " 0 0 0 0 0"
					else if (numAlleles == 3)
						s = s "\t" pow[pl[1]]+0 " " pow[pl[2]]+0 " " pow[pl[3]]+0 " 0 " pow[pl[4]]+0 " " pow[pl[5]]+0 " 0 " pow[pl[6]]+0 " 0 0"
					else
						s = s "\t" pow[pl[1]]+0 " " pow[pl[2]]+0 " " pow[pl[3]]+0 " " pow[pl[4]]+0 " " pow[pl[5]]+0 " " pow[pl[6]]+0 " " pow[pl[7]]+0  " " pow[pl[8]]+0  " " pow[pl[9]]+0  " " pow[pl[10]]+0
				}
			}
			print s
		}
	}
}
