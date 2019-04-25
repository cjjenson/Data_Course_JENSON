#Here's an assignment. This will count for two assignments. It's a lot of stuff!
#If you can complete the following tasks, you are ready to deal with any Illumina amplicon data that's thrown at you...well, you'll be able to figure it out at least.


#There are 6 new fastq sequence files.
#Each of these represents the microbiome of a deep sea alga sample. There are two replicates from each species of alga.

#Add each command (or series of commands) you used to accomplish each of the tasks below. 
#These may be command line or R code. Whatever works for you. Look into the excellent "fastx-toolkit" (Hannon Lab) if you want to do more in the command-line environment.

#Make sure you include all commands... so if you need to load a package, include that code. 
#If you call a command on an unzipped file, make sure you include the code to unzip it first... you get the idea.

#Your tasks:
  
#1. Convert these fastq files to fasta format and save them as separate files.
library(ShortRead)
library(tidyr)
library(stringr)
library(msa)
library(seqinr)

fq.files = dir(path = getwd(), full.names = TRUE, pattern = ".fastq")
fq.files 

fq.1 = readFastq(fq.files[1])
fq.2 = readFastq(fq.files[2])
fq.3 = readFastq(fq.files[3])
fq.4 = readFastq(fq.files[4])
fq.5 = readFastq(fq.files[5])
fq.6 = readFastq(fq.files[6])


writeFasta(fq.1,"fq1.fasta")
writeFasta(fq.2,"fq2.fasta")
writeFasta(fq.3,"fq3.fasta")
writeFasta(fq.4,"fq4.fasta")
writeFasta(fq.5,"fq5.fasta")
writeFasta(fq.6,"fq6.fasta")


#2. Count the number of sequences in each fasta file.
fqa.1=readFasta("./fq1.fasta")
fqa.2=readFasta("./fq2.fasta")
fqa.3=readFasta("./fq3.fasta")
fqa.4=readFasta("./fq4.fasta")
fqa.5=readFasta("./fq5.fasta")
fqa.6=readFasta("./fq6.fasta")

grep -c "^>" fq1.fasta

#3. Trim each fastq file to the first 150 base pairs and truncate/filter each read at the default quality score of 2. Make sure to remove any reads with uncalled bases (N)



#4. Using the error rates in these filtered reads, use dada2 to correct mis-called bases.




#5. Create a "species" abundance table



#6. Assign taxonomy to these reads based on the fungal database provided "sh_general_release_dynamic_10.10.2017.fasta.gz" (the rdp_train_set won't work since these are fungal, not bacterial reads...we need a fungal database)
                                                                                                                          If everything is working correctly, this step will take quite a while to run...~15 minutes on my machine.
                                                                                                                          
                                                                                                                          
                                                                                                                          
                                                                                                                          
                                                                                                                          7. Change the column names in your species abundance table to the assigned taxonomy names.
                                                                                                                          
                                                                                                                          
                                                                                                                          
                                                                                                                          8. Export this species abundance table with propoerly assigned names as a csv file.
                                                                                                                          
                                                                                                                          
                                                                                                                          
                                                                                                                          
                                                                                                                          
                                                                                                                          