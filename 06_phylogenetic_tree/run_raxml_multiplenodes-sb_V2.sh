#!/bin/bash -l
#PBS -l walltime=24:00:00
#PBS -L tasks=2:lprocs=28

module load leibniz/2017a
module load RAxML/8.2.10-intel-2017a-hybrid
export LD_BIND_NOW=1

cd ${VSC_DATA}/carrot_isolates/raxml/

cat $PBS_NODEFILE | uniq > machinefile

mpirun -n 4 -machinefile machinefile \
raxmlHPC-HYBRID -T 14 -f a \
-m PROTCATWAG \
-p 1991 \
-x 1991 -N autoMRE \
-s SuperMatrix.fas \
-n carrotisolates

rm machinefile
