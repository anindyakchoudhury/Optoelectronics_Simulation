clc;
close all;
clear;
q = 1.6e-19;

%% GaN
m0 = 9.31e-31;  %kg
me = 0.2*m0;
mh = 0.8*m0;
mr = me*mh/(me+mh);

T = 300;
sr = 1e-14;     
Nt = 1e2;      
k  = 1.38e-23; 
vth = sqrt(3*k*T/mr)*100;   

ni = 1.9e-10;
p0 = 1e17;
n0 = ni^2/p0;

deln = logspace(10,16,1e7);
tau_nr = 1/sr/vth/Nt*ones(1,length(deln));

B_r = 1e-10;
tau_low = 1/B_r./(n0+p0)*ones(1,length(deln));

% internal quantum efficiency (IQE)
nr = tau_nr./(tau_low+tau_nr);

figure(1)
semilogx(deln,nr,"LineWidth",2)
hold on;

%% Si
me = 1.08*m0;
mh = 0.56*m0;
mr = me*mh/(me+mh);

T = 300;
sr = 1e-14;     
Nt = 1e2;       
k  = 1.38e-23;  
vth = sqrt(3*k*T/mr)*100;

ni = 1.45e10;
p0 = 1e17;
n0 = ni^2/p0;
deln = logspace(10,16,1e7);
tau_nr = 1/sr/vth/Nt*ones(1,length(deln));

B_r = 1e-14;
tau_low = 1/B_r./(n0+p0)*ones(1,length(deln));

% internal quantum efficiency (IQE)
nr = tau_nr./(tau_low+tau_nr);

semilogx(deln,nr,"LineWidth",2)
hold off
grid minor
axis tight
legend("GaN","Si")
xlabel("Excess carrier concentration (cm3)");
ylabel("IQE");
legend();
title('IQE vs Excess carrier concentration');
