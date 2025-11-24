function yout=Fuel_to_air_ratio(w3,Ht3,Ht4)
F_A = 0;
while F_A == 0
Q=43115.800;
etab=0.985;
wf=w3*(Ht4-Ht3)/((Q*etab)-Ht4);
F_A=wf/w3;
end
yout=[F_A wf];