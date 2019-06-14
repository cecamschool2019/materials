#!/bin/bash

if [ -f "heat_capacity.dat" ]; then
	rm heat_capacity.dat
fi

if [ -f "heat_capacity_f.dat" ]; then
	rm heat_capacity_f.dat
fi

for T in $( seq 0.1 0.01 2.5 ); do
	if [ -f "energies/energies_$T.dat" ]; then
		echo $T
		file=energies/energies_$T.dat
		awk < $file -v T=$T 	'BEGIN{
						E = 0.;
						E2= 0.;
						n = 0}
					      {
					      	if ($1>1000){
					      	E += $5;
					      	E2+= $5*$5;
					      	n+=1;}
					      	}
					   END{
					      	E  = E/n;
					      	E2 = E2/n;
					        cv = (E2 - E*E)/(T*T);
					        print T, E, cv}' >> heat_capacity.dat

	fi
	if [ -f "energies_f/energies_$T.dat" ]; then
		echo $T
		file=energies_f/energies_$T.dat
		awk < $file -v T=$T 	'BEGIN{
						E = 0.;
						E2= 0.;
						n = 0}
					      {
					      	if ($1>1000){
					      	E += $5;
					      	E2+= $5*$5;
					      	n+=1;}
					      	}
					   END{
					      	E  = E/n;
					      	E2 = E2/n;
					        cv = (E2 - E*E)/(T*T);
					        print T, E, cv}' >> heat_capacity_f.dat
	
	fi
done
