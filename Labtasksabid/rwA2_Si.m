clc;
clearvars;
close all;
format long;
set(0,'DefaultAxesFontName', 'Latex');
set(0,'DefaultAxesFontSize', 13);

data = importdata('Si.txt');
lambda = data(:,1);
lambda = lambda.*1e-6; %m
n = data(:,2);
k = data(:,3);

% physical constants
Eg0     = 1.17; %eV
A       = 7.021e-4;
B       = 1108;
q       = 1.6e-19;
m0      = 9.11e-31;
h       = 6.626e-34;
hcut    = h/(2*pi);
c       = 3e8;
kB      = 1.38e-23;
eps0    = 8.854e-12;
eps     = 11.9*eps0;
me      = 0.98*m0;
mh      = 0.16*m0;
mr      = me*mh/(me+mh);
fcv     = 23*q;
fcvf    = fcv/1000;


Eg      = 1.12*q;
nr      = mean(n);

data    = importdata('Si-alpha.txt');
E       = data(:,1); % eV
alpha   = data(:,2); % cm^-1

figure(1)
yyaxis left;
plot(E,alpha,'Linewidth', 2)
xlabel ('h\nu (eV)');
ylabel('\alpha  cm^{-1}');
title(sprintf("Energy-dependent \\alpha %s for Si",string));
subtitle("Due to Phonon Emission/Absorption");
grid on
hold on

Energy = h*c./lambda;

yyaxis right;
plot(Energy/q, 4*pi*k./lambda/100, 'Linewidth', 2);
%plot(E,zeros(1,length(E)),'Linewidth', 2)
ylabel('\alpha  cm^{-1}');
hold on
legend('Experimental \alpha', 'From Extinction Coeffecient');