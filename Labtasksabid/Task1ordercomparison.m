clc;
clear;
close all;
format long;
set(0,'DefaultAxesFontName', 'Latex');
set(0,'DefaultAxesFontSize', 13);

%% Loading data
data = importdata('GaAs2.txt');
lambda = data(:,1);
lambda = lambda.*1e-6; %m
n = data(:,2);
k = data(:,3);
m0=9.11e-31;
q=1.6e-19;
eps0=8.854e-12;

%% physical constants
me      = 0.063*m0;
mh      = 0.5*m0;
mr      = me*mh/(me+mh);
h=6.624e-34;
hcut=h/(2*pi);
c=3e8;
Eg=1.42*q;
fcv     = 23*q;
fcvf    = fcv/1000;

eps     = 12.9*eps0;

%% Lab Task 1: Compare 'alpha' from 'k' with 'alpha' obtained from formula (using 'n') 

E= h*c./lambda;
% allowed transition
alpha   = q^2*sqrt(m0)./(4*pi*hcut^2*eps*c.*n).*(2*mr/m0)^1.5 .*(fcv./E).*(E-Eg).^0.5;
        
figure(1);
yyaxis left;
plot(lambda/1e-6, alpha/100,'Linewidth', 1.5);
ylabel('\alpha  cm^{-1}');
hold on;

yyaxis right;
plot(lambda/1e-6, 4*pi*k./lambda/100,'o','Linewidth', 1);
xlabel ('\lambda (\mum)');
ylabel('\alpha  cm^{-1}');
grid on;
title(sprintf("Comparison of \\alpha for %s", 'GaAs'));

legend('Theoretical \alpha','Experimental \alpha = 4\pi\kappa /\lambda');