clc; close all; clear;
q = 1.6e-19;          % Elementary charge [C]

%% Parameters for Gallium Nitride (GaN)
m0 = 9.31e-31;        % Electron rest mass [kg]
me = 0.2*m0;          % Effective electron mass in GaN
mh = 0.8*m0;          % Effective hole mass in GaN
mr = me*mh/(me+mh);   % Reduced mass of electron-hole pair

% Recombination and material parameters for GaN
T = 300;              % Temperature [K]
sr = 1e-14;           % Capture cross section [cm²]
Nt = 1e2;             % Trap density [cm⁻³]
k  = 1.38e-23;        % Boltzmann constant [J/K]

% Calculate thermal velocity for GaN
vth = sqrt(3*k*T/mr)*100;    % Thermal velocity [cm/s]

% Carrier concentrations for GaN
ni = 1.9e-10;         % Intrinsic carrier concentration [cm⁻³]
p0 = 1e17;            % Hole concentration (p-type) [cm⁻³]
n0 = ni^2/p0;         % Electron concentration [cm⁻³]

% Generate excess carrier concentration range
deln = logspace(10,16,1e7);  % Excess carrier density array [cm⁻³]

% Calculate lifetimes for GaN
tau_nr = 1/sr/vth/Nt*ones(1,length(deln));    % Non-radiative lifetime
B_r = 1e-10;                                   % Radiative coefficient [cm³/s]
tau_low = 1/B_r./(n0+p0)*ones(1,length(deln)); % Radiative lifetime

% Calculate Internal Quantum Efficiency (IQE) for GaN
nr = tau_nr./(tau_low+tau_nr);    % IQE = τnr/(τr + τnr)

%% Create Enhanced Figure
figure('Color', 'white', 'Position', [100 100 800 600])
semilogx(deln, nr, 'LineWidth', 2.5, 'Color', [0 0.4470 0.7410])
hold on;

%% Parameters for Silicon (Si)
me = 1.08*m0;         % Effective electron mass in Si
mh = 0.56*m0;         % Effective hole mass in Si
mr = me*mh/(me+mh);   % Reduced mass for Si

% Recombination and material parameters for Si
T = 300;              % Temperature [K]
sr = 1e-14;           % Capture cross section [cm²]
Nt = 1e2;             % Trap density [cm⁻³]
k  = 1.38e-23;        % Boltzmann constant [J/K]

% Calculate thermal velocity for Si
vth = sqrt(3*k*T/mr)*100;    % Thermal velocity [cm/s]

% Carrier concentrations for Si
ni = 1.45e10;         % Intrinsic carrier concentration [cm⁻³]
p0 = 1e17;            % Hole concentration (p-type) [cm⁻³]
n0 = ni^2/p0;         % Electron concentration [cm⁻³]

% Generate excess carrier concentration range
deln = logspace(10,16,1e7);  % Excess carrier density array [cm⁻³]

% Calculate lifetimes for Si
tau_nr = 1/sr/vth/Nt*ones(1,length(deln));    % Non-radiative lifetime
B_r = 1e-14;                                   % Radiative coefficient [cm³/s]
tau_low = 1/B_r./(n0+p0)*ones(1,length(deln)); % Radiative lifetime

% Calculate Internal Quantum Efficiency (IQE) for Si
nr = tau_nr./(tau_low+tau_nr);    % IQE = τnr/(τr + τnr)

% Plot Si data with enhanced styling
semilogx(deln, nr, 'LineWidth', 2.5, 'Color', [0.8500 0.3250 0.0980])

% Enhance plot appearance
set(gca, 'FontSize', 14, 'FontName', 'Arial', 'LineWidth', 1.5, 'Box', 'on')
xlabel('Excess Carrier Concentration (cm^{-3})', 'FontSize', 16, 'FontWeight', 'bold')
ylabel('Internal Quantum Efficiency', 'FontSize', 16, 'FontWeight', 'bold')
title('Internal Quantum Efficiency vs Excess Carrier Concentration', ...
    'FontSize', 16, 'FontWeight', 'bold')

% Add and customize grid
grid minor
set(gca, 'GridLineStyle', '--', 'MinorGridLineStyle', ':')
axis tight

% Enhance legend appearance
legend('GaN', 'Si', 'Location', 'best', 'FontSize', 14, 'Box', 'off')






% clc;
% close all;
% clear;
% q = 1.6e-19;

% %% GaN
% m0 = 9.31e-31;  %kg
% me = 0.2*m0;
% mh = 0.8*m0;
% mr = me*mh/(me+mh);

% T = 300;
% sr = 1e-14;
% Nt = 1e2;
% k  = 1.38e-23;
% vth = sqrt(3*k*T/mr)*100;

% ni = 1.9e-10;
% p0 = 1e17;
% n0 = ni^2/p0;

% deln = logspace(10,16,1e7);
% tau_nr = 1/sr/vth/Nt*ones(1,length(deln));

% B_r = 1e-10;
% tau_low = 1/B_r./(n0+p0)*ones(1,length(deln));

% % internal quantum efficiency (IQE)
% nr = tau_nr./(tau_low+tau_nr);

% figure(1)
% semilogx(deln,nr,"LineWidth",2)
% hold on;

% %% Si
% me = 1.08*m0;
% mh = 0.56*m0;
% mr = me*mh/(me+mh);

% T = 300;
% sr = 1e-14;
% Nt = 1e2;
% k  = 1.38e-23;
% vth = sqrt(3*k*T/mr)*100;

% ni = 1.45e10;
% p0 = 1e17;
% n0 = ni^2/p0;
% deln = logspace(10,16,1e7);
% tau_nr = 1/sr/vth/Nt*ones(1,length(deln));

% B_r = 1e-14;
% tau_low = 1/B_r./(n0+p0)*ones(1,length(deln));

% % internal quantum efficiency (IQE)
% nr = tau_nr./(tau_low+tau_nr);

% semilogx(deln,nr,"LineWidth",2)
% hold off
% grid minor
% axis tight
% legend("GaN","Si")
% xlabel("Excess carrier concentration (cm3)");
% ylabel("IQE");
% legend();
% title('IQE vs Excess carrier concentration');
