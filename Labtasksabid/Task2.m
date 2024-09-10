clc;
clearvars;
close all;

format long;
set(0,'DefaultAxesFontName', 'Latex');
set(0,'DefaultAxesFontSize', 13);



%% physical constants
m0=9.11e-31;
q=1.6e-19;
eps0=8.854e-12;
kB   = 1.38e-23;
h=6.624e-34;
hcut=h/(2*pi);
c=3e8;

me      = 0.98*m0;
mh      = 0.16*m0;
mr      = me*mh/(me+mh);

fcv     = 23*q; %constant
fcvf    = fcv/1000;

eps     = 11.9*eps0;
Eg      = 1.12*q;

%% Vashni's law
Eg0     = 1.17; %eV
A       = 7.021e-4;
B       = 1108;

Eg_V    = @(T) (Eg0 - A*T^2/(B + T))*q; %Vashni's law
Ep      = 0.03 * q;     % Typical phonon energy 20-30meV
%% Task 2: Indirect bandgap
Ts      = [250, 300, 350, 400, 415];
% E       = linspace(Eg-0.1*q,Eg+0.2*q,1000);
E       = linspace(0.95*q,1.3*q,1000);
eV      = 1.6 * 10^-19;

% Direct Allowed transition
figure(3);
for T = Ts
     EgT = Eg_V(T); %From Vashni's law
    % EgT = Eg; %bandgap does not change with temperature
    alpha   = (E>EgT-Ep).*(E - EgT + Ep).^2./(exp(Ep./(kB*T)) - 1) ...
            + (E>EgT+Ep).*(E - EgT - Ep).^2./(1 - exp(-Ep./(kB*T)));
     alpha = alpha/eV;
     alpha = (9e10)^2.*alpha;   %need to make it work

    plot(E/q, sqrt(alpha),'Linewidth', 2,...
        'DisplayName',sprintf('T = %d K',T));

    hold on;
end
xlabel ('E (eV)');
ylabel('\alpha^{1/2} cm^{-1}');
title(sprintf("Energy-dependent \\alpha^{1/2} for %s",string));
subtitle("Due to phonon emission/absorption");
% xlim([Eg/q-0.1,Eg/q+0.2]);
xlim([0.95,1.3]);
%ylim([0, 7]);
grid on;
legend('Box','off');
