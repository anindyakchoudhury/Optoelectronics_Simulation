clc; clear; close all;

%% Physical Constants
q = 1.6e-19;                % Elementary charge [C]
m0 = 9.11e-31;             % Electron rest mass [kg]
me = 0.067*m0;             % Effective electron mass in semiconductor
mh = 0.47*m0;              % Effective hole mass in semiconductor
mr = me*mh/(me+mh);        % Reduced mass of electron-hole pair

h_cut = 6.626e-34/(2*pi);  % Reduced Planck's constant [J·s]
kB = 1.38e-23;             % Boltzmann constant [J/K]
T = 300;                   % Temperature [K]
ni = 1.79e6;               % Intrinsic carrier concentration [cm^-3]

%% Recombination Parameters
sr = 1e-15;                % Capture cross section [cm^2]
vth = sqrt(3*T*kB/mr)*100; % Thermal velocity [cm/s]

%% Material and Defect Properties
p0 = 10e18;                % Doping concentration [cm^-3]
Nt = 10e2;                 % Trap density [cm^-3]
Et_a = 0.2*q;              % Trap energy level [J]

%% Carrier Concentration Arrays
deln = logspace(15, 20, 300);  % Excess electron concentration range [cm^-3]
delp = deln;                   % Excess hole concentration (assume equal to electrons)
n0 = ni^2/p0;                  % Equilibrium electron concentration
p = p0 + delp;                 % Total hole concentration
n = n0 + deln;                 % Total electron concentration

%% Calculate Recombination Rates
% Shockley-Read-Hall recombination rate - general case
Rnr = sr*vth*Nt*(n.*p-ni^2)./(n+p+2*ni*cosh(Et_a/(kB*T)));

% Low-level injection approximation
t_nr = 1/(sr*vth*Nt);         % Non-radiative lifetime
Rnr_low_ij = deln/t_nr;       % Recombination rate for low injection

%% Create Enhanced Figure
figure('Color', 'white', 'Position', [100 100 800 600]);  % White background, larger figure
loglog(deln, Rnr, 'LineWidth', 2.5, 'Color', [0 0.4470 0.7410], 'DisplayName', 'General Case');
hold on
loglog(deln, Rnr_low_ij, 'LineWidth', 2.5, 'Color', [0.8500 0.3250 0.0980], 'DisplayName', 'Low Level Injection');

% Enhance plot appearance
set(gca, 'FontSize', 14, 'FontName', 'Arial', 'LineWidth', 1.5, 'Box', 'on')
xlabel('\Deltan (cm^{-3})', 'FontSize', 16, 'FontWeight', 'bold');
ylabel('Non-radiative Recombination Rate (cm^{-3}s^{-1})', 'FontSize', 16, 'FontWeight', 'bold');
title('Shockley-Read-Hall Recombination Rate vs Excess Carrier Density', ...
    'FontSize', 16, 'FontWeight', 'bold');
grid on;
legend('Location', 'best', 'FontSize', 14, 'Box', 'off');

% Add grid with custom properties
grid minor
set(gca, 'GridLineStyle', '--', 'MinorGridLineStyle', ':')

% Original Abid Code
% clc;
% clear;
% close all;

% %costants
% q = 1.6e-19;
% m0 = 9.11e-31;
% me      = 0.067*m0;
% mh      = 0.47*m0;
% mr      = me*mh/(me+mh);

% h_cut = 6.626e-34/(2*pi);
% kB = 1.38e-23;

% T = 300;
% ni = 1.79e6;
% sr = 1e-15;
% vth = sqrt(3*T*kB/mr)*100;

% % inputs
% p0 = 10e18; % doping concentration
% Nt = 10e2; % defect density
% Et_a = 0.2*q; % trap energy

% deln = logspace(15, 20, 300);
% delp = deln;
% n0=ni^2/p0;
% p=p0+delp;
% n=n0+deln;

% % Calculate for general case
% Rnr=sr*vth*Nt*(n.*p-ni^2)./(n+p+2*ni*cosh(Et_a/(kB*T)));

% % Calculate for low level injection
% t_nr = 1/(sr*vth*Nt);
% Rnr_low_ij= deln/t_nr;

% figure;
% loglog(deln,Rnr, 'LineWidth',1.5);
% hold on
% loglog(deln,Rnr_low_ij, 'LineWidth',1.5)
% xlabel('\Deltan (1/cm^3)');
% ylabel('nr radiation');
% grid on;
% title('non-radiative recombination rate');
% legend('general','Low level');
