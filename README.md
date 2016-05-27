# Lep-MAP2 workflow

lep-MAP2 workflow for building genetic linkage maps

## Documentation

### Place .loc file in 02_data/

### Prepare the data

```
00_scripts/utilities/joinMap_to_LepMap.sh 02_data/*.loc
```

### launch filtering step

```
./00_scripts/01_filtering.sh
```

### launch validation for LG segregation

```
./00_scripts/02_separate_chromosomes_validation.sh
```

### Evaluate LOD parameter

```
./00_scripts/utilities/count_nb_markers_lgs.sh
```

### Launch sep LG final

**first change the values for LOD and Size limit**

```
./00_scripts/03_separate_chromosomes.sh
```

**In progress**

## lep-MAP2 repository

[Lep-MAP2 repository](https://sourceforge.net/projects/lepmap2/)

P. Rastas, F.C.F. Calboli, B. Guo, T. Shikano & J. Merilä (2015). Construction of Ultradense Linkage Maps with Lep-MAP2: Stickleback F2 Recombinant Crosses as an Example. [doi: 10.1093/gbe/evv250](http://gbe.oxfordjournals.org/content/8/1/78)

**workflow in progress**

