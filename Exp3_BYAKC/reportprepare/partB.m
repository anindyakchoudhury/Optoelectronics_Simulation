clc;
clearvars;
close all;

% Constants in SI unit
h     = 6.626e-34;
h_cut = h/(2*pi);
c     = 3e8;
k_B   = 1.38e-23;
T     = 300;
q     = 1.6e-19;
mo    = 9.1e-31;

%% Choose data
Task_no = 1;  % Task 1: GaAs, Task 2: GaN

switch (Task_no)
    case 1
        material = 'GaAs';
        % Mobility in cm2/Vs
        u_n = 8500;
        u_p = 400;

        % Doping concentrations in (cm-3)
        Na = 1e15;
        Nd = 5e17;

        ni = 1.79e6; % intrinsic carrier concentration (cm-3)

        % effective mass
        me = 0.067*mo;
        mh = 0.5*mo;

        % Refractive index
        nr1 = 3.68; %GaAs

        Eg     = 1.43*q;     % bandgap
        lamda0 = 860e-9; %Peak Wavelength from Exp1

    case 2
        material = 'GaN';
        % Mobility in cm2/Vs
        u_n = 1800;
        u_p = 30;

        % Doping concentrations in (cm-3)
        Na = 1e15;
        Nd = 1e18;

        ni = 1.9e-10; % intrinsic carrier concentration (cm-3)

        % effective mass
        me = 0.27*mo;
        mh = 0.8*mo;

        % Refractive index
        nr1 = 2.55; %GaN

        Eg     = 3.4*q;      % bandgap
        lamda0 = 360e-9; % Peak Wavelength from Exp1
end

deln = 1e17;             % excess minority carrier concentration
A    = 1*(1/10)^2;       % Cross section Area in cm2
mr   = (me*mh)/(me+mh);  % average effective mass


%% Injection efficiency
% Calculate equilibrium minority carrier concentrations using mass action law
npo = ni^2/Na;    % Equilibrium electron concentration in p-region
pno = ni^2/Nd;    % Equilibrium hole concentration in n-region

% Calculate diffusion coefficients using Einstein relation (D = kT*μ/q)
% These describe how carriers spread through the semiconductor
Dn = (k_B*T*u_n)/q;    % Electron diffusion coefficient (cm²/s)
Dp = (k_B*T*u_p)/q;    % Hole diffusion coefficient (cm²/s)

% Define radiative recombination coefficient
Br = 1e-10;    % Radiative recombination coefficient (cm³/s)

% Calculate carrier lifetimes considering all available carriers
% Total available carriers = majority carriers + equilibrium minority carriers + excess carriers
tau_n = 1/(Br*(Na+npo+deln));    % Electron lifetime in p-region % Basically tau_r of n-doped LED
tau_p = 1/(Br*(pno+Nd+deln));    % Hole lifetime in n-region

% Calculate diffusion lengths - average distance carriers travel before recombining
% L = sqrt(D*τ) - combines both mobility and lifetime effects
Ln = (Dn*tau_n)^0.5;    % Electron diffusion length in p-region
Lp = (Dp*tau_p)^0.5;    % Hole diffusion length in n-region

% Calculate injection efficiency
% This represents the fraction of total current carried by electrons
% Higher efficiency means better electron injection into active region
Nin = (Dn*npo/Ln)/((Dn*npo/Ln)+(Dp*pno/Lp));

% Display injection efficiency
fprintf('Injection efficiency is %0.5f \n',Nin)

%% Calculate radiative recombination efficiency (internal quantum efficiency)
% This section determines what fraction of carrier recombination is radiative
% (produces light) versus non-radiative (produces heat)

% Define parameters for non-radiative recombination via traps
sr = 1e-15;          % Capture cross-section for carriers by traps (cm²)
NT = 1e13;           % Density of trap states/defects in material (cm⁻³)

% Calculate thermal velocity of carriers
% This represents how fast carriers move due to thermal energy
% Converted to cm/s by multiplying with 1e2
Vth = ((3*k_B*T)/mr)^(0.5)*1e2;    % Thermal velocity in cm/s

% Calculate non-radiative lifetime
% This is how long carriers survive before being captured by traps
% τ_nr = 1/(sr * Vth * NT) - derived from Shockley-Read-Hall statistics
tau_nr = (sr*Vth*NT)^-1;           % Non-radiative lifetime

% Calculate radiative recombination efficiency
% Nr = τ_nr/(τ_r + τ_nr) = 1/(1 + τ_r/τ_nr)
% where τ_r is the radiative lifetime (tau_n in this case)
Nr = 1/(1+(tau_n/tau_nr));         % Fraction of recombination that produces light

% Display the calculated efficiency
fprintf('Radiative recombination efficiency is %0.5f \n',Nr)

%% Calculate Light Extraction Efficiency
% This section determines what fraction of generated photons escape the semiconductor
% Photons can be trapped inside due to total internal reflection at interfaces

% Define refractive indices for the material interface
% nr1 is defined elsewhere for the semiconductor material
nr2 = 1;   % Refractive index of air

% Calculate extraction efficiency using simplified formula
% This formula considers:
% 1. Critical angle for total internal reflection
% 2. Fresnel reflection at normal incidence
% 3. Geometric factors for emission cone
Ne = (1/4) * ...                           % Geometric factor for emission cone
     (nr2/nr1)^2 * ...                     % Transmission coefficient
     (1-((nr1-nr2)/(nr1+nr2))^2);         % Accounts for Fresnel reflection

% Display the calculated extraction efficiency
fprintf('Extraction efficiency is %0.5f \n',Ne);

%% Calculate luminous efficiency (how well emission matches human eye response)
% Import eye sensitivity and emission data from external file
data = importdata('sensitivity_GaAs.txt');

% Extract wavelength, sensitivity, and emission data
% Wavelength in nm, sensitivity is photopic response, emission is LED spectrum
lambda = data(5:end,1);
sensitivity = data(5:end,2);
emission = data(5:end,3);

% Optional plotting code (currently commented out)
% Plots the photopic sensitivity curve vs wavelength
% figure;
% plot(lambda,sensitivity)
% xlabel('\lambda (nm)');
% ylabel('Sensitivity');
% title('Photopic sensitivity');
% grid on;

% Calculate spontaneous emission rate spectrum
% First convert wavelength to energy using E = hc/λ
E = (h*c)./(lambda.*1e-9);    % Energy in Joules
delE = (E-Eg);                % Energy relative to bandgap

% Calculate radiative recombination lifetime in n-type region
tau_r = 1/(Br*(Nd+pno+deln));

% Calculate quasi-Fermi levels for electrons and holes
Ef_n = k_B*T*log((Nd+deln)/ni);     % Electron quasi-Fermi level
Ef_p = k_B*T*log((Na+deln)/ni);     % Hole quasi-Fermi level
Efn_Efp = Ef_n + Ef_p;              % Total quasi-Fermi level separation

% Calculate spontaneous emission rate using van Roosbroeck-Shockley formula
R_sp = ((((2*mr)^1.5)/(2*pi^2*(h_cut^3)*tau_r)) ...
    *exp((Efn_Efp-Eg)/(k_B*T)).*(delE.^0.5).*exp(-delE./(k_B*T)));

% Calculate luminous efficiency
V = sum(sensitivity.*R_sp);    % Weighted sum considering eye response
P = sum(R_sp);                % Total emission power
Nl = V/P;                     % Luminous efficiency (ratio of visible to total power)

% Display the calculated luminous efficiency
fprintf('luminous efficiency is %0.5f \n \n',Nl)

%% Final efficiency
% Excluding NL (as Nl very low)
N0 = Nin*Nr*Ne;
fprintf('External conversion efficiency is %0.5f \n',N0)

%% Output optical power (L) as a function of forward current (I)

I = linspace(0,100,100); %mA
L = N0*I*(h*c/lamda0)/q; %mW

figure
plot(I,L, 'LineWidth',2);
xlabel('I (mA)');
ylabel('P_0 (mW)');
title(sprintf('Optical output power for %s LED',material));
grid on;


% Save the plot as a PNG file
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\Exp3_BYAKC\reportprepare\partB_task2.png');