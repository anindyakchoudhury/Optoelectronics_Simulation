clc; clear; close all;

% costants for GaAs
Br = 10e-11;
ni = 1.79e6;

% inputs
Nd = 1e17; % Doping Concentration
n0 = Nd;
p0 = ni^2/n0;

delp = logspace(10, 19, 300);
deln = delp;

t_r = 1./(Br*(n0+p0+delp));
t_r_low = 1/(Br*(n0+p0)).*ones(1,length(deln));
t_r_high = 1./(Br*delp);

figure;
semilogx(delp,t_r/1e-9);
hold on
semilogx(delp,t_r_low/1e-9);
hold on
semilogx(delp,t_r_high/1e-9);
xlabel('\Deltan (cm^-3)');
ylabel('rec lifetime');
grid on;
title('radiative recombination lifetime');
ylim([0,140]);

legend('General','Low injection','High injection');