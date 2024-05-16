# HPC_conda_PoPS
This repo provides YAML for conda to run PoPS along with sample batch script and some explanation. This set up works for PoPS v2.0.1.

Use the pops_env.yml to set up a conda env that has the PoPS dependencies.

Have to be on a login node. On the HPC, that is denoted with a prompt like:
`japolo@login01:~$`
The other prompt you can possibly have is on a compute/job/process node. That looks like:
`japolo@login01:japolo$` 

We won't be using the compute node for this process. You'll send your jobs from there, but for install, you do that on login node. 

There are basically four steps:
1. Create conda env
2. Start conda env
3. Start R in the conda env
4. Install PoPS in R

**1.** This is the step that requires more attention than the rest. 

HPC requires loading apps each time:

`module load conda`

**_If you have NOT run conda on HPC before, you need to read and follow the steps under Loading and Initializing Conda that are found here:_**
https://hpc.ncsu.edu/Software/Apps.php?app=Conda

You only need to do the initialization once. You don't need to do it every time you want to use conda on HPC. However, you do need the `module load conda` each time you're in a new session on the HPC. **You should also read** the 2nd section of that HPC conda page about where to set up your path for storing the libraries that are installed for your conda environment. 

After those steps, you're read to use conda regularly. The pops_env.yml file should be in your current directory. If you don't know how to check use
`ls`
and the list of files after that should includ the pops_env.yml. If it's not there, transfer or copy the file into current directory.

conda command to create an environment:

**IF THE ENVIRONMENT** is already created and you want to modify it, say due to change in version dependencies, you have to delete the existing environment. Do that with

`conda env remove -p /path/to/directory/with/dependencies`

Once that is done or if the environment is brand new:

`conda env create -p /path/to/hold/dependencies -f pops_env.yml`

**2.** Start the conda environment to run R:

`conda activate /path/to/hold/dependencies/pops_env`

A conda prompt should appear. It'll look something like:
`(/path/to/hold/dependencies/pops_env) japolo@login01:~$`

**3. & 4.** Start R inside the conda env and then install PoPS inside R inside conda. ;)

```
(/path/to/hold/dependencies/pops_env) japolo@login01:~$ R

R version 4.2.2 (2022-10-31 ucrt) -- "Innocent and Trusting"

Copyright (C) 2022 The R Foundation for Statistical Computing

Platform: x86_64-w64-mingw32/x64 (64-bit)

> remotes::install_github("ncsu-landscape-dynamics/rpops")
> q()
```

Once PoPS is installed and R is closed, deactivate conda with:

`(/path/to/hold/dependencies/pops_env) japolo@login01:~$ conda deactivate`


PoPS is now part of your pops_env. **From this point on, as long as you're using the same conda env, you just need to do the following each time you start a new session for running jobs on the HPC** 
```
module load conda
conda activate /path/to/hold/dependencies/pops_env
```
You can find these two lines inside the sample batch script. If you are using an interactive process session, you use those two lines as well, but you run them manually, since the interactive session doesn't use scripts. There is an example of the batch script in this repo.

Example batch request submission on next line. My script in this example is popsbashjob.sh

*Note the "<" and not "<-" for this. I'm used to "<-" from R.*

`bsub < popsbashjob.sh`

---
This next section has excerpts from the output files you get after a job finishes. They provide an idea of the resources used for each step in PoPS, calibration, validation, and multirun.

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

Job Summary: The process used around 4 GB for a little over an hour.

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

Job Summary: The job used a max of 11 GB. The job was a couple of minutes.

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

Job Summary: The job used a max of 18 GB. Job took less than 5 m.


Use those values from the Job Summary as guides to supply the arguments to the batch script, an example of which is part of the repo. 
