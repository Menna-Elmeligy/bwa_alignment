# Description
* This is a bash script to fetch a genome by its accession number and convert it from the genbank format to the fasta format.
* Then the reference genome is indexed using the **BWA** aligner 
## Software needed
* you need to install EMBOSS using 
`sudo apt-get install emboss`
* you need to install *bwa*
`sudo apt-get install bwa`
* you need to install *samtools*
`sudo apt-get install samtools`
## how to run the script?
```chmod +x create_index.sh
   ./create_index <genome_accession_number>```