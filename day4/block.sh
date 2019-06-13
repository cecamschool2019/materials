#!/bin/bash

fist_part=500 # number of steps necessary for system relaxation
awk '$1>500{print}' energies.dat > energies_cut.dat

n_data=`awk ' END{print NR} ' energies_cut.dat `


for N_BLOCCHI  in {2..100..1}; do (
	
	awk -v N=$n_data -v nblock=$N_BLOCCHI '
		BEGIN { 
			nconf=int( N/nblock);
			j=1; block=1; 		
		}
		{	
			if( j <= nconf*block  ){
				avg[block]= avg[block]+$5;
			}
			j++;
			if(j%nconf==0) {block=block+1;}	
			avg_tot=avg_tot+$5;
		
		}
		END { 	
			avg_tot = avg_tot/N;
	
			for(i=1;i<=nblock;i++){
				avg[i]=avg[i]/nconf;
				sigma2 = sigma2 + (avg[i] - avg_tot)**2    ; 
			}
	
			sigma2=sigma2/nblock;
			errore = (sigma2 /nblock)**0.5;
			print "nblocks " , nblock, "nconf" ,nconf, "errore", errore;

		}' energies_cut.dat

); done
