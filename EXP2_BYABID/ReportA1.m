clc; clear; close all;

%% Setup for Optical Properties Analysis of Semiconductors
% Define input files and materials to analyze
flienames = ["Si.txt", "GaN.txt", "GaAs.txt"];    % Data files containing optical constants
materials = ["Si", "GaN", "GaAs"];                 % Material names for plotting
thickness = 2e-6;                                  % Film thickness in meters (2 µm)

% Create enhanced figure window
figure('Color', 'white', 'Position', [100 100 1200 400])

% Process each material's optical data
for i = 1:length(flienames)
    % Import and extract optical constants
    data = importdata(flienames{i});
    lambda_um = data(:,1);     % Wavelength in micrometers
    n = data(:,2);             % Refractive index
    k = data(:,3);             % Extinction coefficient

    % Convert wavelength to meters and calculate absorption coefficient
    lambda = lambda_um*1e-6;   % Convert wavelength to meters
    alpha = 4*pi.*k./lambda;   % Calculate absorption coefficient

    % Calculate optical properties using thin film equations
    % Single interface reflection coefficient
    R = ((n-1).^2+k.^2)./((n+1).^2+k.^2);

    % Total reflection including multiple internal reflections
    R_sum = R.*(1 + ((1-R).^2.*exp(-2*alpha*thickness))./(1-R.^2.*exp(-2*alpha*thickness)));

    % Total transmission including multiple internal reflections
    T_sum = (exp(-alpha*thickness).*(1-R).^2)./(1-R.^2.*exp(-2*alpha*thickness));

    % Create subplot for each material
    subplot(1,3,i);

    % Plot transmittance and reflectance with enhanced styling
    plot(lambda*1e6, T_sum, 'LineWidth', 2.5, 'Color', [0 0.4470 0.7410], ...
        'DisplayName', 'Transmittance');
    hold on;
    plot(lambda*1e6, R_sum, 'LineWidth', 2.5, 'Color', [0.8500 0.3250 0.0980], ...
        'DisplayName', 'Reflectance');

    % Enhance plot appearance
    set(gca, 'FontSize', 12, 'FontName', 'Arial', 'LineWidth', 1.5, 'Box', 'on')
    xlabel('Wavelength (\mum)', 'FontSize', 14, 'FontWeight', 'bold');
    ylabel('Percentage (%)', 'FontSize', 14, 'FontWeight', 'bold');
    title(sprintf('%s Optical Properties', materials{i}), ...
        'FontSize', 14, 'FontWeight', 'bold');

    xlim([0.2 0.8]);  % Set wavelength range from 200 nm to 800 nm

    % Add and customize grid
    grid on;
    grid minor;
    set(gca, 'GridLineStyle', '--', 'MinorGridLineStyle', ':')

    % Enhance legend appearance
    legend('Location', 'best', 'FontSize', 10, 'Box', 'off');
end

%{This code analyzes and compares the optical properties (transmittance and reflectance) of three important semiconductors: Si, GaN, and GaAs. For each material, it:

% 1. Loads wavelength-dependent optical constants (n, k)
% 2. Calculates the absorption coefficient from the extinction coefficient
% 3. Computes reflectance and transmittance including multiple internal reflections
% 4. Plots the results over the visible spectrum (200-800 nm)

% The calculations account for:
% - Multiple internal reflections in the thin film
% - Wavelength-dependent absorption
% - Interface reflections
% - Film thickness effects

% The resulting plots show how these materials
% interact differently with light across the visible
% spectrum, which is crucial for optoelectronic
% applications.
% %}
% clc;
% clear;
% close all;

% %% the transmittance and reflectivity of Si, GaN, GaAs
% % Data input
% flienames = [ "Si.txt","GaN.txt","GaAs.txt"];
% materials = ["Si","GaN", "GaAs"];
% thickness = 2e-6; % film thickness in meter

% figure;
% for i = 1:length(flienames)
%     data = importdata(flienames{i});
%     lambda_um = data(:,1);
%     n = data(:,2);
%     k = data(:,3);
%     lambda = lambda_um*1e-6;
%     alpha = 4*pi.*k./lambda;

%     R = ((n-1).^2+k.^2)./((n+1).^2+k.^2);
%     R_sum = R.*(1 + ((1-R).^2.*exp(-2*alpha*thickness))./(1-R.^2.*exp(-2*alpha*thickness)));
%     T_sum = (exp(-alpha*thickness).*(1-R).^2)./(1-R.^2.*exp(-2*alpha*thickness));

%     subplot(1,3,i);
%     plot(lambda*1e6, T_sum,'Linewidth',1.5,'DisplayName', 'Transmittance');
%     hold on;
%     plot(lambda*1e6, R_sum,'Linewidth',1.5,'DisplayName','Reflectance');
%     hold on;
%     xlabel('\lambda \mum');
%     ylabel('%');
%     title(materials{i});
%     xlim([0.2 0.8]); % Given wavelength range of 200 nm to 800 nm
%     grid on;
%     legend();
% end
