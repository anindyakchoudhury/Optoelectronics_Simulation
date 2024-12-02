% Clear workspace and command window for fresh start
clc; clearvars; close all;

%% Material Selection and Parameter Definition
% Choose between GaAs (Task 1) or GaN (Task 2) LED characteristics
Task_no = 2; % Task 1: GaAs, Task 2: GaN

switch (Task_no)
    case 1
        % Parameters for GaAs LED
        material = 'GaAs';
        u_n = 8500;        % Electron mobility in cm²/Vs - higher for GaAs
        u_p = 400;         % Hole mobility in cm²/Vs
        Na = 1e15;         % p-type doping concentration (cm⁻³)
        Nd = 5e17;         % n-type doping concentration (cm⁻³)
        ni = 1.79e6;       % Intrinsic carrier concentration (cm⁻³)
        A = 1*(1/10)^2;    % Device cross-sectional area (cm²)
        nf = 1.5;          % Ideality factor - indicates recombination mechanism
        lamda0 = 860e-9;   % Peak emission wavelength (m)

    case 2
        % Parameters for GaN LED
        material = 'GaN';
        u_n = 1800;        % Lower mobility compared to GaAs
        u_p = 30;          % Much lower hole mobility - typical for GaN
        Na = 1e15;         % p-type doping concentration (cm⁻³)
        Nd = 1e18;         % Higher n-type doping for GaN
        ni = 1.9e-10;      % Much lower due to wider bandgap
        A = 0.5*(1/10)^2;  % Smaller device area
        nf = 1;            % Ideal diode behavior assumed
        lamda0 = 360e-9;   % Shorter wavelength (UV region)
end

% Define fundamental physical constants in SI units
h = 6.626e-34;    % Planck's constant (J·s)
k_B = 1.38e-23;   % Boltzmann constant (J/K)
T = 300;          % Temperature (K)
q = 1.6e-19;      % Elementary charge (C)

% Define injection level
deln = 1e17;      % Excess carrier concentration (cm⁻³)

%% Calculate Transport Parameters
% Determine equilibrium minority carrier concentrations
npo = ni^2/Na;    % Electrons in p-region
pno = ni^2/Nd;    % Holes in n-region

% Calculate diffusion coefficients using Einstein relation
Dn = (k_B*T*u_n)/q;    % Electron diffusion coefficient (cm²/s)
Dp = (k_B*T*u_p)/q;    % Hole diffusion coefficient (cm²/s)

% Define radiative recombination coefficient and calculate lifetimes
Br = 1e-10;                           % Radiative recombination coefficient
tau_n = 1/(Br*(Na+npo+deln));        % Electron lifetime in p-region
tau_p = 1/(Br*(pno+Nd+deln));        % Hole lifetime in n-region

% Calculate diffusion lengths
Ln = (Dn*tau_n)^0.5;    % Electron diffusion length
Lp = (Dp*tau_p)^0.5;    % Hole diffusion length

%% Calculate I-V Characteristics
% Define voltage range for calculations
V = linspace(0,3,10000);    % Voltage from 0 to 3V

% Calculate saturation current density using diffusion theory
Js = q*((Dn*npo/Ln)+(Dp*pno/Lp));    % Saturation current density (A/cm²)

% Calculate total saturation current considering device area
Is = A*Js;    % Total saturation current (A)

% Calculate total current using diode equation
I = Is*exp(((q*V)./(nf*k_B*T))-1);    % Current (A)

%% Create and Save Plot
% Plot I-V characteristics with current in microamps
plot(V,I/1e-6, "LineWidth",2);
xlabel('V (V)');
ylabel('I (\muA)');
title(sprintf('I-V characteristics for %s LED',material));

% Set plot limits and add grid
ylim([0 10]);
grid on;

% Save plot as PNG file
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\Exp3_BYAKC\reportprepare\partC_task2.png');