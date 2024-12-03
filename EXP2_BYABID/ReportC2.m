clc; close all; clearvars;

%% Physical Constants and Material Parameters for p-type GaN
m0 = 9.31e-31;        % Electron rest mass [kg]
me = 0.2*m0;          % Effective electron mass in GaN
mh = 0.8*m0;          % Effective hole mass in GaN
mr = me*mh/(me+mh);   % Reduced mass of electron-hole pair

% Operating and recombination parameters
T = 300;              % Temperature [K]
sr = 1e-14;          % Capture cross section [cm²]
k  = 1.38e-23;       % Boltzmann constant [J/K]

% Calculate thermal velocity for carriers in GaN
vth = sqrt(3*k*T/mr)*100;    % Thermal velocity [cm/s]

% Material properties
ni = 1.9e-10;         % Intrinsic carrier concentration in GaN [cm⁻³]

% Define range of doping concentrations to study
p0 = [1e15 1e16 1e19];    % Array of acceptor concentrations [cm⁻³]
n0 = ni^2./p0;            % Corresponding electron concentrations from mass action law

% Radiative recombination coefficient
B_r = 1e-10;              % Radiative coefficient for GaN [cm³/s]

%% Create Enhanced Figure for IQE vs Defect Density Analysis
figure('Color', 'white', 'Position', [100 100 800 600])

% Define defect density range to study
Nt = logspace(4,16,100);     % Trap density range from 10⁴ to 10¹⁶ [cm⁻³]

% Define professional color scheme
colors = [0 0.4470 0.7410;    % Blue
         0.8500 0.3250 0.0980; % Orange
         0.4940 0.1840 0.5560]; % Purple

% Calculate and plot IQE for each doping concentration
for i = 1:length(p0)
    % Calculate carrier lifetimes
    tau_nr = 1/sr/vth./Nt;    % Non-radiative lifetime (SRH recombination)
    tau_low = 1/B_r./(n0(i)+p0(i))*ones(1,length(Nt));  % Radiative lifetime

    % Calculate Internal Quantum Efficiency
    nr = tau_nr./(tau_low+tau_nr);    % IQE = τnr/(τr + τnr)

    % Plot with enhanced styling
    semilogx(Nt, nr, "LineWidth", 2.5, 'Color', colors(i,:), ...
        'DisplayName', sprintf("N_a = %.1e cm^{-3}", p0(i)));
    hold on;
    grid on;
end

%% Enhance Plot Appearance
% Customize axes and labels
set(gca, 'FontSize', 14, 'FontName', 'Arial', 'LineWidth', 1.5, 'Box', 'on')
xlabel("Defect Density, N_t (cm^{-3})", 'FontSize', 16, 'FontWeight', 'bold');
ylabel("Internal Quantum Efficiency", 'FontSize', 16, 'FontWeight', 'bold');
title('IQE vs Defect Density in p-type GaN', 'FontSize', 16, 'FontWeight', 'bold');

% Add minor grid and customize grid appearance
grid minor
set(gca, 'GridLineStyle', '--', 'MinorGridLineStyle', ':')

% Enhance legend appearance
legend('Location', 'best', 'FontSize', 12, 'Box', 'off');


% clc;
% close all;
% clear;

% %% p-type GaN
% m0 = 9.31e-31;
% me = 0.2*m0;
% mh = 0.8*m0;
% mr = me*mh/(me+mh);
% T = 300;
% sr = 1e-14;
% k  = 1.38e-23;
% vth = sqrt(3*k*T/mr)*100;

% ni = 1.9e-10;

% % Doping concentration
% p0 = [1e15 1e16 1e19];
% n0 = ni^2./p0;
% B_r = 1e-10;
% %%

% figure(1)
% Nt = logspace(4,16,100);
% for i = 1:length(p0)

%     tau_nr = 1/sr/vth./Nt;
%     tau_low = 1/B_r./(n0(i)+p0(i))*ones(1,length(Nt));

%     nr = tau_nr./(tau_low+tau_nr);
%     semilogx(Nt,nr,"LineWidth",2, 'DisplayName',sprintf("Na = %.1e (1/cm^3)", p0(i)));
%     hold on;
%     grid on;
% end

% %%
% xlabel("Defect density, Nt (1/cm2)");
% ylabel("IQE");
% legend();
% title('IQE vs Defect Density');