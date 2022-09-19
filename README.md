## GPMeta
A GPU-accelerated method for ultrarapid pathogen identification from metagenomic sequences.

### Introduction
GPMeta is a GPU-accelerated method for ultrarapid pathogen identification from metagenomic sequences. GPMeta can rapidly and accurately remove host contamination, isolate microbial reads, and identify potential disease-causing pathogens. GPMeta is much faster than existing CPU-based tools, being 5-40x faster than Kraken2 and Centrifuge and 25-68x faster than Bwa and Bowtie2 by using a GPU-computing technique.
![GPMeta](https://user-images.githubusercontent.com/19549825/166857024-a8b9bd9c-7457-4e09-a4fd-2b63725c8258.png)


### Requirements
GPMeta requires NVIDIA's GPUs，which the sum of the graphics memory of the graphics card needs to be greater than the database size.
### Usage
GPMeta requires database files in a specific format for sequence alignment. These files can be generated from FASTA formmated DNA sequence files.To generate multiple pathogen databases, you need to split the FASTA file evenly according to the number of GPU graphics cards(the minimum granularity is chromosomes).Database index can take step interval.Users have to prepare a database file in FASTA format and convert it into GPMeta format database files by using "Index the reference database" command at first.The database needs to be loaded into GPU video memory before sequence alignment.
#### Index the reference database
```
host database:      GPMetaIndex human.fasta index_step 0
pathogen database:  GPMetaIndex pmseq.fasta index_step 1

Index and generate refhash.bin.
```
#### load the reference database to GPU
```
host database:      GPMetaMemServer_host human.fasta index.conf
    index.conf:
    /human_index/refHash.bin

The index.conf file stores the human index path.

pathogen database:  GPMetaMemServer_pathogen ref.conf index.conf
    ref.conf:
    /pmseq/fasta1.fa
    /pmseq/fasta2.fa
    index.conf:
    /pmseq/1/refHash.bin
    /pmseq/2/refHash.bin
    /pmseq/get_species_genus.xls

According to the number of ref splits, the ref.conf file stores the ref path.The index.conf file stores the corresponding index path and species relationship file.
```
#### Alignement to host DB
```
[info] single mate
Usage: GPMeta_host <required> [options]

Algorithm required:

    --ref              -r FILE reference file path
    --fastq            -1 FILE fastq file path

Algorithm options:

    --output           -o FILE bam file to output results to [stdout]
    --fq_out           -f No compare file path
    --reads_out        -h Human reads statistics file path
    --batchSize        -b INT batch size of GPU memory [10000]
    --gpuRes           -g INT GPU resource number [32]
    --cpuRes           -c INT CPU resource number [2]

Note: Please read the man page for detailed description of the command line and options.
Example:./GPMeta_host -r /data/hg19.fasta -1 /data/test.fq
```
#### Alignement to pathogen DB
```
[info] single mate
Usage: GPMeta_pathogen <required> [options]

Algorithm required:

    --ref              -r FILE reference file path
    --fastq            -1 FILE fastq file path

Algorithm options:

    --output           -o FILE bam file to output results to [stdout]
    --statistics       -I output Contig_Species_Genus or not
    --pmseq_out        -P Pmseq data statistics file path
    --reads_out        -p Pmseq reads statistics file path
    --ref_out          -R Ref contig statistics file path
    --ref_limit        -n Ref contig statistics out limit
    --batchSize        -b INT batch size of GPU memory [10000]
    --gpuRes           -g INT GPU resource number [32]
    --cpuRes           -c INT CPU resource number [2]

Note: Please read the man page for detailed description of the command line and options.
Example:./GPMeta_pathogen -r /data/hg19.fasta -1 /data/test.fq
```

### Results

#### 1. outputs in host-flitering:  
`*.sam / *.bam`:  The SAM/BAM file containing alignments.  
`*.Human_reads.stat`: Statistical results for host filtering.  
for example:  
```
total_reads:111777654
host_reads:99836961
non_human_reads:11940693
non_human_rate:10.682540%
```
`*.rmhost.fq`: FASTQ file containing reads that fail to align.  

#### 2. outputs in pathogen identification: 
`*.sam / *.bam`:  The SAM/BAM file containing alignments.  
`pmseq_out.xls`: a report with aggregrate counts at genus and species levels.  
for example:  
```
SpeciesLatin    GenusLatin      SpeciesSMRN     GenusSMRN       SSRN    GSRN    S_count G_count SRPM    GRPM
Buchnera aphidicola     Buchnera        3314    3314    3129    3129    3314    3314    279.617188      279.617188
Borreliella burgdorferi Borreliella     76      67767   0       30909   78      67771   6.581213        5718.145996
Borrelia hermsii        Borrelia        43321   50586   20449   21921   43322   50587   3655.273193     4268.254395
Treponema denticola     Treponema       5059    26974   66      17023   5060    26975   426.935089      2276.002930
```
The field descriptions are as follows:  
**SpeciesLatin**: Latin name of the species.  
**GenusLatin**: Latin name of the genus.   
**SpeciesSMRN**:  Number of strictly reads of the species. Strictly reads are defined as Alignment_score>=30 and match_rate>=0.9 and mismatch_rate<=0.08.  
**GenusSMRN**: Number of strictly reads of the genus. Strictly reads are defined as Alignment_score>=30 and match_rate>=0.9 and mismatch_rate<=0.08.    
**SSRN**: Number of unique mapping reads at species level.  
**GSRN**: Number of unique mapping reads at genus level.   
**S_count**: Number of total mapping reads at species level.   
**G_count**: Number of total mapping reads at genus level.  
**SRPM**: RPM (Reads per million mapped reads) at species level.   
**GRPM**: RPM (Reads per million mapped reads) at genus level.  

`*.reads_out.txt`: Statistical results for pathogen identification.  
for example:   
```
mapped_reads:11851918
mapped_reads rate:99.256531
unknown_reads:88775
reads_total:11940693
```
`*.ref_out.xls`: Depth information of the identified pathogen genome.  
for example:  
```
RefID   Length  mapped_reads    depth
NC_009614.1     5163189 98867   0.957422
NC_017355.1     1588278 83445   2.626902
NC_017986.1     6085449 81191   0.667091
NC_015167.1     3765936 75001   0.995782
NC_015177.1     4635236 75000   0.809020
```
The field descriptions are as follows:  
**RefID**: ID of the reference sequence.    
**Length**: The length of this reference sequence.   
**mapped_reads**: Number of reads aligned to this reference sequence.   
**depth**: The average sequencing depth. 




