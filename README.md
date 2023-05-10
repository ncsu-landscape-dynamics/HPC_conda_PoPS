# HPC_conda_PoPS
This repo provides YAML for conda to run PoPS along with sample batch script and some explanation. The PoPS version is 2.0.1.

Use the pops_env.yml to set up a conda env that has the PoPS dependencies.

Have to be on a login node. On the HPC, that is denoted with a prompt like:
`japolo@login01:~$`

HPC requires loading apps each time:

`module load conda`

conda command to create an environment:

`conda env create -p /path/to/hold/dependencies -f pops_env.yml`

Start the conda environment to run R:

`conda activate /path/to/hold/dependencies/pops_env`

A conda prompt should appear. It'll look something like:
`(/path/to/hold/dependencies/pops_env) japolo@login01:~$`

[start R here]

```
(/path/to/hold/dependencies/pops_env) japolo@login01:~$ R

R version 4.2.2 (2022-10-31 ucrt) -- "Innocent and Trusting"

Copyright (C) 2022 The R Foundation for Statistical Computing

Platform: x86_64-w64-mingw32/x64 (64-bit)

> remotes::install_github("ncsu-landscape-dynamics/rpops")
> q()
```

Once PoPS is installed and R is closed, deactivate conda with:

`(/path/to/hold/dependencies/pops_env) conda deactivate`


PoPS is now part of your pops_env. In order to process jobs with it, need to switch to a job queue. Do that with:

`cd /share/rkmeente/$userid`

Then submit a batch request with a bash script. There is an example of the bash script at bottom.

*Note the < and not <- for this. I'm used to "<-" from R.*

`bsub < popsbashjob.sh`

This next section has excerpts from the output files you get after a job finishes.

JOB: PoPS calibration with SLF 1 km

    CPU time :                                   3710.17 sec.
    Max Memory :                                 4 GB
    Average Memory :                             3.94 GB
    Total Requested Memory :                     8.00 GB
    Delta Memory :                               4.00 GB
    Max Swap :                                   -
    Max Processes :                              4
    Max Threads :                                5
    Run time :                                   3751 sec.
    Turnaround time :                            3726 sec.

[The process used around 4 GB for a little over an hour.]

JOB: PoPS validation of SLF 1 km

    CPU time :                                   195.00 sec.
    Max Memory :                                 11 GB
    Average Memory :                             7.17 GB
    Total Requested Memory :                     8.00 GB
    Delta Memory :                               -3.00 GB
    Max Swap :                                   -
    Max Processes :                              11
    Max Threads :                                12
    Run time :                                   143 sec.
    Turnaround time :                            119 sec.

The job used a max of 11 GB. The job was a couple of minutes.

JOB: A PoPS multirun with SLF 1 km

    CPU time :                                   345.00 sec.
    Max Memory :                                 18 GB
    Average Memory :                             6.18 GB
    Total Requested Memory :                     32.00 GB
    Delta Memory :                               14.00 GB
    Max Swap :                                   -
    Max Processes :                              14
    Max Threads :                                15
    Run time :                                   269 sec.
    Turnaround time :                            264 sec.

The job used a max of 18 GB. Job took less than 5 m.


Use those values to supply the arguments to the batch script, an example of which is part of the repo. 
