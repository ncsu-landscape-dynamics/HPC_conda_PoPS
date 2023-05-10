#!/bin/bash
#BSUB -n 1
#BSUB -W 8:00
#BSUB -q cnr
#BSUB -R "rusage[mem=8GB]"
#BSUB -J pops_pro
#BSUB -oo pops_out
#BSUB -eo popserr
module load conda
eval "$(conda shell.bash hook)"
conda activate /usr/local/usrapps/rkmeente/japolo/pops_env
Rscript ./slf_cal.R
conda deactivate

### NOTE: You only need the lines from 1 - 13 for a batch script. 
### This next part is for people new to HPC and batch scripts.
### See https://hpc.ncsu.edu/Documents/LSF.php for more detail, especialy concerning parallel and shared memory jobs

#BSUB -n 1                         <- This is number of cores requested. Required
#BSUB -W 8:00                      <- This is amount of time requested. Required. This example is 8 hrs
#BSUB -q cnr                       <- This is processing queue requested. Optional
#BSUB -R "rusage[mem=8GB]"         <- This is RAM requested. Required. There are other options, like "ptile", for shared
 memory or parallel jobs
#BSUB -J pops_pro                  <- The name of the job that appears in the bjobs when the job is pending or active.
 Required
#BSUB -oo pops_out_%J              <- Name for the file that is produced when job finishes running. Required
#BSUB -eo popserr_%J               <- Name for the file that containes any error that is produced when job finishes running.
 Required
module load conda                  <- Load whatever programs or apps are necessary for running job. Required.
eval "$(conda shell.bash hook)"    <- This is required when running conda. 
conda activate /usr/local/usrapps/rkmeente/japolo/pops_env  <- Required. Make sure to set the path and correct environment.
Rscript ./slf_cal.R                <- Required. This is the R code for your job.
conda deactivate                   <- Required with conda.
