clc; 
clear;
close all;

format long;
set(0,'DefaultAxesFontName', 'Latex');
set(0,'DefaultAxesFontSize', 13);


%%
% physical constants
q       = 1.6e-19;
m0      = 9.11e-31;
h       = 6.626e-34;
hcut    = h/(2*pi);
eps0    = 8.854e-12;
c       = 3e8;
kB      = 1.38e-23;

% Load data
string = "SiO2";

switch(string)
    case "GaAs"
        data_GaAs();
    case "InP"
        data_InP();
    case "Si"
        data_Si();
    case "SiO2"
        data_SiO2();
end

data = importdata('SiO2 alpha.txt');
E = data(:,1); % eV
alpha = data(:,2); % cm^-1

figure(1)
yyaxis left;
plot(E,alpha,'Linewidth', 2)
xlabel ('h\nu (eV)');
ylabel('\alpha  cm^{-1}');
title(sprintf("Energy-dependent \\alpha %s",string));
subtitle("Due to phonon emission/absorption");
grid on
hold on

Energy = h*c./lambda;

yyaxis right;
% plot(Energy/q, 4*pi*k./lambda/100, 'Linewidth', 2);
plot(E,zeros(1,length(E)),'Linewidth', 2)
ylabel('\alpha  cm^{-1}');
hold on
legend('Experimental \alpha', 'From Extinction Coeffecient');
