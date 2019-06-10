
````
#!/bin/bash

#first
grep "ATOM" 3fhr.pdb| grep "CA"  | awk '{x[NR]=$7; y[NR]=$8; z[NR]=$9; type[NR]=$4;}
END{
for(i=1;i<=NR;i++)
for(j=1;j<=NR; j++)
if(i<j){
dist=(x[i]-x[j])^2+(y[i]-y[j])^2+(z[i]-z[j])^2;
 if(sqrt(dist)<5){print i, j, type[i], type[j];}
 }
}' > contacts
awk 'END{print NR;}' contacts

#second
grep "ATOM" 3fhr.pdb| grep "CA"  | awk '{x[NR]=$7; y[NR]=$8; z[NR]=$9; type[NR]=$4;}
END{
for(i=1;i<=NR;i++)
for(j=1;j<=NR; j++)
if(i<j){
dist=(x[i]-x[j])^2+(y[i]-y[j])^2+(z[i]-z[j])^2;
 {print i, j, type[i], type[j], sqrt(dist);}
 }
}' > all
sort -grk5 all | head -1

#third
grep 'ATOM' 3fhr.pdb | grep 'CA' | awk '{x[NR]=$7; y[NR]=$8; z[NR]=$9; xavg+=x[NR]; 
	yavg+=y[NR]; zavg+=z[NR];}
END{ xavg/=NR; yavg/=NR; zavg/=NR; 
	for(i=1;i<=NR;i++)
		pos+=(x[i]-xavg)^2+(y[i]-yavg)^2+(z[i]-zavg)^2;
	print sqrt(pos/NR);
}'
````
