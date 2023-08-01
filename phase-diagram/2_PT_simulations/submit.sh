#!/bin/bash 
# ----- SLURM JOB SUBMIT SCRIPT -----
#SBATCH --export=ALL
#SBATCH --error=slurm.%J.err
#SBATCH --output=slurm.%J.out
#SBATCH --exclusive
################ CHANGE this section  (begin) ##########################
# -- job info --
#SBATCH --account=s1000
#SBATCH --job-name=h_xxxPxxx
#SBATCH --time=24:00:00
#SBATCH --partition=normal
# -- number of nodes --
#SBATCH --nodes=1               # of nodes            (default =  1)
#SBATCH --ntasks-per-node=1     # of MPI tasks/node   (default = 12)
#SBATCH --cpus-per-task=24       # of OMP threads/task (default =  1)
#SBATCH --ntasks-per-core=2     # HT (default = 1, HyperThreads = 2)
#SBATCH --constraint=gpu
# -- the program and input file (basename) --

module unload daint-mc
module load daint-gpu
module load GSL

export OMP_NUM_THREADS=1

ipi= #PATH TO i-PI EXECUTABLE ../i-pi/bin/i-pi

rm /tmp/ipi_*

for x in */NPT/
do
cd ${x}

if [ -f "RESTART" ]; then
${ipi} RESTART > log.i-pi &
else
${ipi} input.xml > log.i-pi &
fi

cd ../../
done

sleep 30

for x in */NPT/
do
cd ${x}

lmp_serial < in1.lmp > log.lmp &
python run-ase.py > log.cp &

cd ../../
done

wait

