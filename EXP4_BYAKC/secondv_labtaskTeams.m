% Gas Laser Analysis for wavelength 684.4 nm
clc; clearvars; close all;

% Constants and parameters
c = 3e8;                    % Speed of light (m/s)
n = 1;                      % Refractive index
tau_sp = 300e-9;            % Spontaneous decay time (s)
lambda0 = 684.4e-9;         % Center wavelength (m)
f0 = c/lambda0;             % Center frequency (Hz) 4.3e14 Hz
del_f = 1.84e9;             % Linewidth (1.84 GHz)
del_lambda = del_f*c/f0^2;  % lamda = c / f0 --differentiate-- d(lamda) = -c/(f0^2) * d(f0)
L = 50e-2;                  % Tube length (m)
gamma = 0.05;               % Loss coefficient (m^-1)
R1 = 1;                     % Mirror 1 reflectance (100%)
R2 = 0.9;                   % Mirror 2 reflectance (90%)

% Calculate threshold gain
gth = gamma + log(1./(R1*R2))/(2*L);
fprintf('Threshold gain (gth) = %.4f m^-1\n', gth);

% Task 1: Gain Lineshape and Cavity Modes Analysis
% Frequency and wavelength calculations
f = linspace(f0-5*del_f, f0+5*del_f, 1000);
lambda = c./f;
x = (f-f0)/(del_f);   %to calculate gaussian waveform

% Gain calculations for N2-N1 = 4e15
dn = 4e15;
g0 = dn*n*c^2/(8*pi*f0^2*tau_sp*del_f);
fprintf('Peak gain coefficient g0 = %.4f m^-1\n', g0);
g = g0*exp(-0.5.*x.^2);  %got a closer lookalike equation in wilson for gaussian

% Plot gain lineshape
figure(1);
plot(lambda*1e9, g, 'LineWidth', 2);
xlabel('Wavelength (nm)');
ylabel('Gain (m^{-1})');
title('Gain Lineshape (Gaussian Approximation) (N_2-N_1 = 4×10^{15} m^{-3})');
grid on;

% Calculate and plot cavity modes with both FWHM and gth
figure(2);
plot(lambda*1e9, g, 'LineWidth', 2, 'DisplayName', 'Gain Profile');
hold on;

% Calculate cavity modes
Nmode = 20; % sets how many modes to calculate on each side of the central wavelength
m = floor(2*L/lambda0);
dlambda = lambda0^2/(2*L);  % Mode spacing
% dlambda = 2*L*(1/m - 1/(m+1)); % this formula works too
lambda_cavity_mode = (lambda0-Nmode*dlambda):dlambda:(lambda0+Nmode*dlambda);
% start : step : end  % The array would contain 41 wavelengths (20 modes on each side + central wavelength)
f_cavity_mode = c./lambda_cavity_mode;
x_cavity_mode = (f_cavity_mode-f0)/(del_f);     % To match with gaussian
g_cavity_mode = g0*exp(-0.5.*x_cavity_mode.^2); % plot over lineshape

% Find modes within FWHM and above gth
g_line_fwhm    = (g_cavity_mode >= g0/2).*g_cavity_mode;
g_line_gth     = (g_cavity_mode >= gth).*g_cavity_mode;
num_modes_fwhm = sum(g_cavity_mode >= g0/2); %Counts how many modes fall within the FWHM
num_modes_gth  = sum(g_cavity_mode >= gth);


% code Explain
% Creates a new array keeping only modes that are above half the peak gain (g0/2)
% g_cavity_mode >= g0/2 creates a boolean array (1s and 0s)
% Multiplying by g_cavity_mode preserves the original gain values above FWHM and sets others to zero
% This effectively filters modes within the FWHM of the gain profile

stem(lambda_cavity_mode*1e9, g_line_fwhm, 'LineWidth', 2, 'DisplayName', 'Cavity Modes');
plot(lambda*1e9, ones(1,length(lambda))*g0/2, 'LineWidth', 2, 'DisplayName', 'FWHM Level');
plot(lambda*1e9, ones(1,length(lambda))*gth, 'r--', 'LineWidth', 2, 'DisplayName', 'g_{th} Level');
xlabel('Wavelength (nm)');
ylabel('Gain (m^{-1})');
title('Cavity Modes within Gain Profile (N_2-N_1 = 4×10^{15} m^{-3})');
fprintf('\nFor N2-N1 = 4e15 m^-3:\n');
fprintf('Number of modes within FWHM = %d\n', num_modes_fwhm);
fprintf('Number of modes above gth = %d\n', num_modes_gth);
legend('Location', 'best');
grid on;

% Task 2: Analysis with N2-N1 = 7e15
figure(3);
dn = 7e15;
g0_new = dn*n*c^2/(8*pi*f0^2*tau_sp*del_f);
g_new = g0_new*exp(-0.5.*x.^2);
g_cavity_mode_new = g0_new*exp(-0.5.*x_cavity_mode.^2);
g_line_fwhm_new = (g_cavity_mode_new >= g0_new/2).*g_cavity_mode_new;
g_line_gth_new = (g_cavity_mode_new >= gth).*g_cavity_mode_new;
num_modes_fwhm_new = sum(g_cavity_mode_new >= g0_new/2);
num_modes_gth_new = sum(g_cavity_mode_new >= gth);

plot(lambda*1e9, g_new, 'LineWidth', 2, 'DisplayName', 'Gain Profile');
hold on;
stem(lambda_cavity_mode*1e9, g_line_fwhm_new, 'LineWidth', 2, 'DisplayName', 'Cavity Modes');
plot(lambda*1e9, ones(1,length(lambda))*g0_new/2, 'LineWidth', 2, 'DisplayName', 'FWHM Level');
plot(lambda*1e9, ones(1,length(lambda))*gth, 'r--', 'LineWidth', 2, 'DisplayName', 'g_{th} Level');
xlabel('Wavelength (nm)');
ylabel('Gain (m^{-1})');
title('Cavity Modes within Gain Profile (N_2-N_1 = 7×10^{15} m^{-3})');
fprintf('\nFor N2-N1 = 7e15 m^-3:\n');
fprintf('Number of modes within FWHM = %d\n', num_modes_fwhm_new);
fprintf('Number of modes above gth = %d\n', num_modes_gth_new);
legend('Location', 'best');
grid on;

% Task 3: Threshold gain variation with cavity length
figure(4);
R2_range = 0.5:0.1:0.9;
L_range = (10:0.1:100)*1e-2;
[R2_mesh, L_mesh] = meshgrid(R2_range, L_range);
% R2_range becomes the value in the column assigned to every value of L_range (essentially row)
gth_mesh = gamma + log(1./(R1.*R2_mesh))./(2*L_mesh);
% calculates gth_mesh for every possible value of (L,R) combination

% Plot gth vs L for different R2
plot(L_range*100, gth_mesh(:,1), 'LineWidth', 2, 'DisplayName', 'R2=50%');
%prints the first column (first value of R) and every row (all possible values of L)
hold on;
plot(L_range*100, gth_mesh(:,3), 'LineWidth', 2, 'DisplayName', 'R2=70%');
plot(L_range*100, gth_mesh(:,5), 'LineWidth', 2, 'DisplayName', 'R2=90%');

% Calculate specific values for R2=70%
L_specific = [10 30 50]*1e-2;
gth_specific = gamma + log(1./(R1*0.7))./(2*L_specific);
fprintf('\nThreshold gain values for R2=70%%:\n');
fprintf('L=10cm: gth = %.4f m^-1\n', gth_specific(1));
fprintf('L=30cm: gth = %.4f m^-1\n', gth_specific(2));
fprintf('L=50cm: gth = %.4f m^-1\n', gth_specific(3));

xlabel('Cavity Length (cm)');
ylabel('Threshold Gain (m^{-1})');
title('Threshold Gain vs Cavity Length');
legend('Location', 'best');
grid on;




% [Previous code remains the same until Figure 4]

% Task 3: Modified threshold gain variation analysis
figure(5);
R2_range = linspace(0.5, 0.9, 1000);  % 1000 points between 0.5 and 0.9
L_values = (10:10:100)*1e-2;          % 10 cavity lengths from 10cm to 100cm
colors = jet(length(L_values));       % Create different colors for each length

% Plot gth vs R2 for different cavity lengths
for i = 1:length(L_values)
    gth_curve = gamma + log(1./(R1.*R2_range))./(2*L_values(i));
    plot(R2_range*100, gth_curve, 'LineWidth', 2, 'Color', colors(i,:), ...
         'DisplayName', sprintf('L = %d cm', L_values(i)*100));
    hold on;
end
%check how different colors are assigned here

xlabel('Mirror Reflectance R2 (%)');
ylabel('Threshold Gain (m^{-1})');
title('Threshold Gain vs Mirror Reflectance for Different Cavity Lengths');
legend('Location', 'best');
grid on;

% Calculate specific values for R2=70%
L_specific = [10 30 50]*1e-2;
gth_specific = gamma + log(1./(R1*0.7))./(2*L_specific);
fprintf('\nThreshold gain values for R2=70%%:\n');
fprintf('L=10cm: gth = %.4f m^-1\n', gth_specific(1));
fprintf('L=30cm: gth = %.4f m^-1\n', gth_specific(2));
fprintf('L=50cm: gth = %.4f m^-1\n', gth_specific(3));

% Add x and y axis limits and formatting
xlim([50 90]);
grid minor;
ax = gca;
ax.GridAlpha = 0.3;
ax.MinorGridAlpha = 0.15;