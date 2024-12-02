clc;
close all;
clear;

%% p-type GaN
m0 = 9.31e-31;  
me = 0.2*m0;
mh = 0.8*m0;
mr = me*mh/(me+mh);
T = 300;
sr = 1e-14;     
k  = 1.38e-23;  
vth = sqrt(3*k*T/mr)*100;

ni = 1.9e-10;

% Doping concentration
p0 = [1e15 1e16 1e19];
n0 = ni^2./p0;
B_r = 1e-10;
%% 

figure(1)
Nt = logspace(4,16,100);     
for i = 1:length(p0)
    
    tau_nr = 1/sr/vth./Nt;
    tau_low = 1/B_r./(n0(i)+p0(i))*ones(1,length(Nt));

    nr = tau_nr./(tau_low+tau_nr);
    semilogx(Nt,nr,"LineWidth",2, 'DisplayName',sprintf("Na = %.1e (1/cm^3)", p0(i)));
    hold on;
    grid on;
end

%% 
xlabel("Defect density, Nt (1/cm2)");
ylabel("IQE");
legend();
title('IQE vs Defect Density');