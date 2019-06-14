#!/bin/bash

if [ ! -d "trajectories" ]; then
	mkdir trajectories
fi

if [ ! -d "energies" ]; then
	mkdir energies
fi

for T in $( seq 0.4 0.05 1.0 ); do
	cat > parm <<-EOF
		inputfile crystal.xyz
		outputfile output.xyz
		temperature $T
		tstep 0.01
		friction 1.0
		forcecutoff 2.5
		listcutoff  3.0
		nstep 10000
		nconfig 1000 trajectories/trajectory_$T.xyz
		nstat   1000 energies/energies_$T.dat
	EOF
	./simplemd.x < parm
done
