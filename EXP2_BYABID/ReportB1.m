clc; clear; close all;

%% Physical Constants and Material Parameters for p-type GaAs
q = 1.6e-19;                % Elementary charge [C]
m0 = 9.11e-31;             % Electron rest mass [kg]
me = 0.067*m0;             % Effective electron mass in GaAs
mh = 0.47*m0;              % Effective hole mass in GaAs
mr = me*mh/(me+mh);        % Reduced mass of electron-hole pair

kB = 1.38e-23;             % Boltzmann constant [J/K]
ni300 = 1.79e6;            % Intrinsic carrier concentration at 300K [cm^-3]
sr = 10e-15;               % Capture cross section [cm^2]

%% Temperature Range Definition
T = 10:10:300;             % Temperature range from 10K to 300K in steps of 10K

%% Bandgap Temperature Dependence Parameters (Varshni Equation)
A = 5.41e-4;               % Varshni coefficient alpha [eV/K]
B = 204;                   % Varshni coefficient beta [K]
Eg0 = 1.52;                % Bandgap at 0K [eV]

% Calculate temperature-dependent bandgap
Eg = (Eg0-A.*T.^2./(B+T))*q;           % Bandgap at temperature T [J]
EgT = (Eg0-A.*300.^2./(B+300))*q;      % Bandgap at 300K [J]

%% Doping and Defect Parameters
Na = 1e18;                 % Acceptor doping concentration [cm^-3]
Nt = 1e2;                  % Trap density [cm^-3]
del_E = 0.2*q;            % Trap energy level [J]

%% Calculate Temperature-Dependent Carrier Concentrations
% Temperature dependence of intrinsic carrier concentration
nis = (ni300)^2 * (T/300).^3 .* exp(-Eg./(kB*T) + EgT/(kB*300));
ni = nis.^0.5;            % Intrinsic carrier concentration [cm^-3]
po = Na;                  % Hole concentration (p-type material) [cm^-3]
no = (ni.*ni)/po;        % Electron concentration from mass action law

%% Calculations for Different Injection Levels
deln = [1e12 1e15 1e18];  % Array of excess carrier concentrations [cm^-3]

% Create enhanced figure
figure('Color', 'white', 'Position', [100 100 800 600]);

% Define professional color scheme
colors = [0 0.4470 0.7410;   % Blue
         0.8500 0.3250 0.0980; % Orange
         0.4940 0.1840 0.5560]; % Purple

for i = 1:length(deln)
    % Calculate total carrier concentrations
    n = no + deln(i);     % Total electron concentration
    p = po + deln(i);     % Total hole concentration

    % Calculate thermal velocity
    vth = sqrt(3*T*kB/mr)*100;  % Thermal velocity [cm/s]

    % Calculate SRH recombination rate
    Rnr = sr*vth*Nt.*(n.*p-ni.^2)./(n+p+2.*ni.*cosh(del_E./(kB*T)));

    % Plot with enhanced styling
    semilogy(T, Rnr, 'LineWidth', 2.5, 'Color', colors(i,:), ...
        'DisplayName', sprintf(" \\Deltan = %.2e (cm^{-3})", deln(i)));
    hold on;
end

% Enhance plot appearance
set(gca, 'FontSize', 14, 'FontName', 'Arial', 'LineWidth', 1.5, 'Box', 'on')
xlabel('Temperature (K)', 'FontSize', 16, 'FontWeight', 'bold');
ylabel('R_{nr} (cm^{-3}s^{-1})', 'FontSize', 16, 'FontWeight', 'bold');
title('Temperature Dependence of Non-radiative Recombination Rate', ...
    'FontSize', 16, 'FontWeight', 'bold');
grid on;

% Add minor grid and customize grid appearance
grid minor
set(gca, 'GridLineStyle', '--', 'MinorGridLineStyle', ':')

% Enhance legend appearance
legend('Location', 'best', 'FontSize', 12, 'Box', 'off');




% clc;
% clear;
% close all;

% %% Data input for p-type GaAs
% q = 1.6e-19;
% m0 = 9.11e-31;
% me      = 0.067*m0;
% mh      = 0.47*m0;
% mr      = me*mh/(me+mh);

% kB = 1.38e-23;
% ni300 = 1.79e6;
% sr = 10e-15;

% % Temperature Range
% T = 10:10:300;

% %Varshini Equation
% A = 5.41e-4;
% B = 204;
% Eg0 = 1.52;

% Eg =  (Eg0-A.*T.^2./(B+T))*q;
% EgT = (Eg0-A.*300.^2./(B+300))*q;

% Na=1e18;
% Nt=1e2;
% del_E=0.2*q;

% nis = (ni300)^2  * (T/300).^3   .* exp(  -Eg./(kB*T)  + EgT/(kB*300)  );
% ni = nis.^0.5;
% po = Na;
% no = (ni.*ni)/po;

% %% Calculations for different injection level

% deln = [1e12 1e15 1e18];

% for i = 1:length(deln)
%     n = no + deln(i);
%     p = po + deln(i);

%     vth = sqrt(3*T*kB/mr)*100;
%     Rnr=sr*vth*Nt.*(n.*p-ni.^2)./(n+p+2.*ni.*cosh(del_E./(kB*T)));

%     semilogy(T, Rnr,"LineWidth",2,'DisplayName',sprintf(" \\Deltan %.2e (1/cm^3)", deln(i)));
%     hold on;
% end

% xlabel('T (K)');
% ylabel('R_{nr}');
% grid on;
% title('Non-radiative recombination rate as vs T');
% legend();
