#create a bwa index for any reference genome before the alignment process
#!/bin/bash
set -uex #this will cause the script to exit if any command fails

#Function to check if the commands exist and redirects the stderr and stdoutput to the /dev/null
command_exists() {
    command -v "$1" > /dev/null 2>&1
}

if ! command_exists bwa; then
    echo "Error: bwa is not installed."
    exit 1
else
    echo "bwa is installed."
fi

if ! command_exists samtools; then
    echo "Error: samtools is not installed."
    exit 1
else
    echo "samtools is installed."
fi

#Check if the number of arguments is correct
if [ $# -ne 1 ]; then
    echo "Error: Invalid number of arguments."
    echo "Usage: $0 <reference_genome>"
    exit 1
fi

ACC_number=$1
echo "Reference genome: $ACC_number"
mkdir -p refs
#the genbank reference file
genbk="refs/$ACC_number.gb"
echo "Reference genbank file: $genbk"
#the fasta reference file
REF="refs/$ACC_number.fasta"
#Fetch the genbank file from the NCBI
echo "Fetching genbank file from NCBI..."
bio fetch $ACC_number > "$genbk"
#Convert the genbank file to fasta format
echo "Converting genbank file to fasta format..."
seqret -sequence $genbk -outseq $REF -osformat fasta 
#seqtk seq -a "$genbk" > "$REF" 

#Create the bwa index
echo "Creating bwa index..."
bwa index $REF
#Build a FAI index for the reference so that we can view in IGV 
echo "Building FAI index for the reference..."
samtools faidx $REF

echo "Done!"

