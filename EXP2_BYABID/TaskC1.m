clc; clear; close all;

%% Material Constants for Gallium Arsenide (GaAs)
Br = 10e-11;       % Radiative recombination coefficient [cm³/s]
ni = 1.79e6;       % Intrinsic carrier concentration [cm⁻³]

%% Doping Parameters and Equilibrium Concentrations
Nd = 1e17;         % Donor doping concentration [cm⁻³]
n0 = Nd;           % Equilibrium electron concentration (≈ Nd for n-type)
p0 = ni^2/n0;      % Equilibrium hole concentration from mass action law

%% Excess Carrier Concentrations
delp = logspace(10, 19, 300);    % Excess hole concentration range [cm⁻³]
deln = delp;                      % Excess electron concentration (assume Δn = Δp)

%% Calculate Recombination Lifetimes for Different Injection Regimes
% General case - valid for all injection levels
t_r = 1./(Br*(n0+p0+delp));

% Low-level injection approximation (Δn << n0)
t_r_low = 1/(Br*(n0+p0)).*ones(1,length(deln));

% High-level injection approximation (Δn >> n0)
t_r_high = 1./(Br*delp);

%% Create Enhanced Figure
figure('Color', 'white', 'Position', [100 100 800 600]);  % White background, larger figure

% Plot all three cases with improved styling
semilogx(delp, t_r/1e-9, 'LineWidth', 2.5, 'Color', [0 0.4470 0.7410], ...
    'DisplayName', 'General');
hold on
semilogx(delp, t_r_low/1e-9, 'LineWidth', 2.5, 'Color', [0.8500 0.3250 0.0980], ...
    'DisplayName', 'Low injection');
semilogx(delp, t_r_high/1e-9, 'LineWidth', 2.5, 'Color', [0.4940 0.1840 0.5560], ...
    'DisplayName', 'High injection');

% Enhance plot appearance
set(gca, 'FontSize', 14, 'FontName', 'Arial', 'LineWidth', 1.5, 'Box', 'on')
xlabel('\Deltan (cm^{-3})', 'FontSize', 16, 'FontWeight', 'bold');
ylabel('Recombination Lifetime (ns)', 'FontSize', 16, 'FontWeight', 'bold');
title('Radiative Recombination Lifetime vs Excess Carrier Density', ...
    'FontSize', 16, 'FontWeight', 'bold');
ylim([0,140]);
grid on;

% Add minor grid and customize grid appearance
grid minor
set(gca, 'GridLineStyle', '--', 'MinorGridLineStyle', ':')

% Enhance legend appearance
legend('Location', 'best', 'FontSize', 14, 'Box', 'off');


% clc; clear; close all;

% % costants for GaAs
% Br = 10e-11;
% ni = 1.79e6;

% % inputs
% Nd = 1e17; % Doping Concentration
% n0 = Nd;
% p0 = ni^2/n0;

% delp = logspace(10, 19, 300);
% deln = delp;

% t_r = 1./(Br*(n0+p0+delp));
% t_r_low = 1/(Br*(n0+p0)).*ones(1,length(deln));
% t_r_high = 1./(Br*delp);

% figure;
% semilogx(delp,t_r/1e-9);
% hold on
% semilogx(delp,t_r_low/1e-9);
% hold on
% semilogx(delp,t_r_high/1e-9);
% xlabel('\Deltan (cm^-3)');
% ylabel('rec lifetime');
% grid on;
% title('radiative recombination lifetime');
% ylim([0,140]);

% legend('General','Low injection','High injection');