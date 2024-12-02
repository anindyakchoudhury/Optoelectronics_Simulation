clc; 
clear;
close all;

%costants
q = 1.6e-19;
m0 = 9.11e-31;
me      = 0.067*m0;
mh      = 0.47*m0;
mr      = me*mh/(me+mh);

h_cut = 6.626e-34/(2*pi);
kB = 1.38e-23;

T = 300;
ni = 1.79e6; 
sr = 1e-15;
vth = sqrt(3*T*kB/mr)*100;       

% inputs
p0 = 10e18; % doping concentration    
Nt = 10e2; % defect density 
Et_a = 0.2*q; % trap energy

deln = logspace(15, 20, 300);
delp = deln;
n0=ni^2/p0;
p=p0+delp;
n=n0+deln;

% Calculate for general case
Rnr=sr*vth*Nt*(n.*p-ni^2)./(n+p+2*ni*cosh(Et_a/(kB*T)));

% Calculate for low level injection
t_nr = 1/(sr*vth*Nt);
Rnr_low_ij= deln/t_nr;

figure;
loglog(deln,Rnr, 'LineWidth',1.5);
hold on
loglog(deln,Rnr_low_ij, 'LineWidth',1.5)
xlabel('\Deltan (1/cm^3)');
ylabel('nr radiation');
grid on;
title('non-radiative recombination rate');
legend('general','Low level');
