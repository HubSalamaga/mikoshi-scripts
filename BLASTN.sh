#!/bin/bash
#SBATCH --nodes=1
#SBATCH --time=8:00:00
#SBATCH --job-name=BLASTN_SEARCH
#SBATCH --mem=100G
#SBATCH --partition=short
#SBATCH --cpus-per-task=64

Help()
{
   # Display Help
   echo "options:"
   echo "q     Query path."
   echo "h     Print this Help."
   echo "db    database path."
   echo "o     out path."
   echo "outfmt outformat."
   echo "m     max target sequences."
   echo
}


# Get the options
while getopts ":hq:" option; do
   case $option in
      h) # display Help
         Help
         exit;;
      q) # Enter query path
         query_path=$OPTARG;;
      db) # Enter database path
         db_path=$OPTARG;;
      o) # Enter output path
         out_path=$OPTARG;;
      outfmt) # Enter the output type
         out_type=$OPTARG;;
       m) # Max target sequences
            m_targets=$OPTARG;;
       t) # Task type
            task=$OPTARG;;
       e) # Evalue cutoff
            e=$OPTARG;;
       
   esac
done

source ~/miniconda3/etc/profile.d/conda.sh 
conda init bash
bash
conda activate blast
blastn -task $task -query $query_path -out $out_path -outfmt $out_type -db $db_path -max_target_seqs $m_targets -subject_besthit -evalue $e
