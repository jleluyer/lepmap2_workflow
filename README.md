# Lep-MAP2 workflow

lep-MAP2 workflow for building genetic linkage maps

## Documentation

### 1. Import data

```
mv file.loc to **02_data/*
```

### 2. Prepare data

```
00_scripts/utilities/joinMap_to_LepMap.sh 02_data/*.loc
```

### 3. Filtering module

```
sbatch 00_scripts/01_filtering.sh
```

### 4. Separate chromosome module validation

```
sbatch 00_scripts/02_separate_chromosomes_validation.sh
```

### 5. Evaluate LOD parameter

```
./00_scripts/utilities/count_nb_markers_lgs.sh
```
This step will format the output from the separate chromosome module to display the number of marker by LG. It is usefull to select a specific LOD  and size limit tresholds

### 6. Launch sep LG final

**first change the values for _LOD_ and _Size limit_ previously selected**
```
sbatch 00_scripts/03_separate_chromosomes.sh
```

### 7. Join singles module

**first change the values for _LOD_ and _Size limit_ previously selected and the second LOD value **
```
sbatch 00_scripts/04_join_singles.sh
```

### 8. Order markers module

```
sbatch 00_scripts/05_order_markers.sh
```

The results will be in **03_output/order_markers.txt**

## lep-MAP2 repository

[Lep-MAP2 repository](https://sourceforge.net/projects/lepmap2/)

P. Rastas, F.C.F. Calboli, B. Guo, T. Shikano & J. Merilä (2015). Construction of Ultradense Linkage Maps with Lep-MAP2: Stickleback F2 Recombinant Crosses as an Example. [doi: 10.1093/gbe/evv250](http://gbe.oxfordjournals.org/content/8/1/78)

**workflow in progress**

