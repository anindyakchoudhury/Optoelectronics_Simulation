clc;
clearvars; 
close all;

% Constants and parameters
c = 3e8;                 % Speed of light (m/s)
n = 1;                   % Refractive index
tau_sp = 300e-9;         % Spontaneous decay time (s)
lambda0 = 623.8e-9;      % Center wavelength (m)
f0 = c/lambda0;          % Center frequency (Hz)
del_f = 1.5e9;           % Linewidth (1.5 GHz)
L = 50e-2;               % Tube length (m)
gamma = 0.05;            % Loss coefficient (m^-1)
R1 = 1;                  % Mirror 1 reflectance (100%)
R2 = 0.9;                % Mirror 2 reflectance (90%)

% Calculate threshold gain
gth = gamma + log(1./(R1*R2))/(2*L);
fprintf('Threshold gain (gth) = %.4f m^-1\n', gth);

%% Task 1: Gain Lineshape and Cavity Modes Analysis
% Frequency and wavelength calculations
f = linspace(f0-5*del_f, f0+5*del_f, 1000);
lambda = c./f;
x = (f-f0)/(del_f);

% Gain calculations for N2-N1
dn = 4e15;
g0 = dn*n*c^2/(8*pi*f0^2*tau_sp*del_f);
fprintf('Peak gain coefficient g0 = %.4f m^-1\n', g0);
g = g0*exp(-0.5.*x.^2);

% Plot gain lineshape
figure(1);
plot(lambda*1e9, g, 'LineWidth', 2);
xlabel('Wavelength (nm)');
ylabel('Gain (m^{-1})');
title('Gain Lineshape');

% Calculate and plot cavity modes with both FWHM and gth
figure(2);
plot(lambda*1e9, g, 'LineWidth', 2, 'DisplayName', 'Gain Profile');
hold on;

% Calculate cavity modes
Nmode = 20;
m = floor(2*L/lambda0);
dlambda = 2*L*(1/m-1/(m+1));
lambda_cavity_mode=(lambda0-Nmode*dlambda):dlambda:(lambda0+Nmode*dlambda);
f_cavity_mode = c./lambda_cavity_mode;
x_cavity_mode = (f_cavity_mode-f0)/(del_f);
g_cavity_mode = g0*exp(-0.5.*x_cavity_mode.^2);

% Find modes within FWHM and above gth
num_modes_fwhm = sum(g_cavity_mode >= g0/2);
num_modes_gth = sum(g_cavity_mode >= gth);
fprintf('\nFor N2-N1 = 4e15 m^-3:\n');
fprintf('Number of modes within FWHM = %d\n', num_modes_fwhm);
fprintf('Number of modes above gth = %d\n', num_modes_gth);

stem(lambda_cavity_mode*1e9, g_cavity_mode, 'LineWidth', 2,...
    'DisplayName', 'Cavity Modes');
plot(lambda*1e9, ones(1,length(lambda))*g0/2, 'LineWidth', 2,...
    'DisplayName', 'FWHM Level');
plot(lambda*1e9, ones(1,length(lambda))*gth, 'r--', 'LineWidth', 2,...
    'DisplayName', 'g_{th} Level');
xlabel('Wavelength (nm)');
ylabel('Gain (m^{-1})');
title('Allowed Modes within Gain Profile');
legend('Location', 'best');
grid on;

%% Task 2: Threshold gain variation analysis
figure(3);
R2_range = linspace(0.1, 0.9, 1000);  % R2 between 0.1 and 0.9
L_values = (10:10:100)*1e-2;          % 10 cavity lengths from 10cm to 100cm
colors = jet(length(L_values));       % Create different colors for each length

% Plot gth vs R2 for different cavity lengths
for i = 1:length(L_values)
    gth_curve = gamma + log(1./(R1.*R2_range))./(2*L_values(i));
    plot(R2_range*100, gth_curve, 'LineWidth', 2, 'Color', colors(i,:), ...
         'DisplayName', sprintf('L = %d cm', L_values(i)*100));
    hold on;
end

xlabel('Mirror Reflectance R2 (%)');
ylabel('Threshold Gain g_{th} (m^{-1})');
title('Threshold Gain vs Mirror Reflectance for Different Cavity Lengths');
legend('Location', 'best');
grid on;

% Add x and y axis limits and formatting
xlim([10 90]);
grid minor;
ax = gca;
ax.GridAlpha = 0.3;
ax.MinorGridAlpha = 0.15;

%% Task 3: Analysis of Lasing Conditions for Different Population Inversions
% Calculate modes for different population inversions
dn = logspace(15,16.2,100);
num_modes=zeros(1,length(dn));

for i = 1:length(dn)
    g0 = dn(i)*n*c^2/(8*pi*f0^2*tau_sp*del_f);
    g = g0*exp(-0.5.*x.^2);
    m = floor(2*L/lambda0);
    d_l = 2*L*(1/m-1/(m+1));
    lambda_cavity_mode=(lambda0-Nmode*dlambda):dlambda:(lambda0+Nmode*dlambda);
    f_cavity_mode = c./lambda_cavity_mode;
    x_cavity_mode = (f_cavity_mode-f0)/(del_f);
    g_cavity_mode = g0*exp(-0.5.*x_cavity_mode.^2);
    num_modes(i) = sum(g_cavity_mode > gth);
    i = i + 1;
end
figure(4)
plot(dn, num_modes, 'LineWidth', 2);
xlabel('N_{2} - N_{1}');
ylabel('Number of modes');
title('Gain Profiles for Different Population Inversions');
grid on;