clc; clear; close all;

%% Study of Transmittance vs Thickness for Different Semiconductors
% Define materials to analyze
flienames = ["GaAs.txt","GaN.txt", "Si.txt"];    % Data files containing optical constants
materials = ["GaAs","GaN", "Si"];                 % Material names for plotting

% Define thickness range and wavelength of interest
thickness = 1e-9:0.1e-11:600e-9;     % Study thickness from 1nm to 600nm
lambda_center = 550e-9;               % Center wavelength (550nm - green light)

% Initialize array to store maximum thickness values
Max_thickness = zeros(1,length(flienames));

%% First Analysis: Transmittance vs Thickness at Fixed Wavelength
figure('Color', 'white', 'Position', [100 100 800 600]);

% Define professional color scheme
colors = [0 0.4470 0.7410;    % Blue
         0.8500 0.3250 0.0980; % Orange
         0.4940 0.1840 0.5560]; % Purple

for i = 1:length(flienames)
    % Import optical constants data
    data = importdata(flienames{i});
    lambda_nm = data(:,1);         % Wavelength in nm
    n = data(:,2);                 % Refractive index
    k = data(:,3);                 % Extinction coefficient

    % Convert to SI units and calculate optical parameters
    lambda = lambda_nm*1e-6;       % Convert wavelength to meters
    alpha = 4*pi.*k./lambda;       % Absorption coefficient

    % Calculate reflection coefficient
    R = ((n-1).^2+k.^2)./((n+1).^2+k.^2);

    % Find optical properties at center wavelength (550nm)
    idx = find(abs(lambda - lambda_center) < 15e-9);
    R_fixed = R(idx(1));
    alpha_fixed = alpha(idx(1));

    % Calculate transmittance vs thickness
    T_sum = (exp(-alpha_fixed*thickness).*(1-R_fixed).^2)./(1-R_fixed.^2.*exp(-2*alpha_fixed*thickness));

    % Find maximum thickness for 30% transmittance
    idx_t = find(T_sum >= 0.3);
    Max_thickness(i) = thickness(idx_t(end));

    % Plot with enhanced styling
    plot(thickness/1e-9, T_sum, 'LineWidth', 2.5, 'Color', colors(i,:), ...
        'DisplayName', materials{i});
    hold on;
end

% Add 30% reference line
plot(thickness/1e-9, 0.3*ones(1,length(thickness)), '--', 'LineWidth', 1.5, ...
    'Color', [0.5 0.5 0.5], 'DisplayName', "30% threshold");

% Enhance plot appearance
set(gca, 'FontSize', 14, 'FontName', 'Arial', 'LineWidth', 1.5, 'Box', 'on')
xlabel('Thickness (nm)', 'FontSize', 16, 'FontWeight', 'bold');
ylabel('Transmittance', 'FontSize', 16, 'FontWeight', 'bold');
title(sprintf("Transmittance vs Thickness at λ = %.0f nm", lambda_center/1e-9), ...
    'FontSize', 16, 'FontWeight', 'bold');
grid on;
grid minor;
legend('Location', 'best', 'FontSize', 12, 'Box', 'off');

%% Print Maximum Thickness Results
fprintf('\nMaximum thickness for 30%% transmittance:\n');
for i = 1:length(Max_thickness)
    fprintf('Maximum thickness for %s will be %0.2f nm\n', ...
        materials{i}, Max_thickness(i)/1e-9);
end

%% Second Analysis: Transmittance Spectra at Maximum Thickness
figure('Color', 'white', 'Position', [100 100 1200 400]);

for i = 1:length(Max_thickness)
    subplot(1,3,i);

    % Calculate transmittance spectrum at maximum thickness
    R = ((n-1).^2+k.^2)./((n+1).^2+k.^2);
    T_sum = (exp(-alpha*Max_thickness(i)).*(1-R).^2)./(1-R.^2.*exp(-2*alpha*Max_thickness(i)));

    % Plot with enhanced styling
    plot(lambda*1e6, T_sum, 'LineWidth', 2.5, 'Color', colors(i,:));

    % Enhance subplot appearance
    set(gca, 'FontSize', 12, 'FontName', 'Arial', 'LineWidth', 1.5, 'Box', 'on')
    xlabel('Wavelength (μm)', 'FontSize', 14, 'FontWeight', 'bold');
    ylabel('Transmittance', 'FontSize', 14, 'FontWeight', 'bold');
    title(materials{i}, 'FontSize', 14, 'FontWeight', 'bold');
    subtitle(sprintf("Thickness = %.3f μm", Max_thickness(i)/1e-6), ...
        'FontSize', 12);
    xlim([0.550 0.8]);
    grid on;
    grid minor;
end
% clc; clear; close all;

% %% Plot of Transmittance vs Thickness
% flienames = ["GaAs.txt","GaN.txt", "Si.txt"];
% materials = ["GaAs","GaN", "Si"];

% thickness = 1e-9:0.1e-11:600e-9; % Check from 1nm to 600nm
% lambda_center = 550e-9;
% Max_thickness = zeros(1,length(flienames));

% figure();
% for i = 1:length(flienames)
%     % import data
%     data = importdata(flienames{i});
%     lambda_nm = data(:,1);
%     n = data(:,2);
%     k = data(:,3);

%     lambda = lambda_nm*1e-6; % SI unit
%     alpha = 4*pi.*k./lambda;

%     R = ((n-1).^2+k.^2)./((n+1).^2+k.^2);
%     % Calculate for a specific lamda
%     idx = find(abs(lambda - lambda_center) < 15e-9);
%     R_fixed = R(idx(1));
%     alpha_fixed = alpha(idx(1));

%     T_sum = (exp(-alpha_fixed*thickness).*(1-R_fixed).^2)./(1-R_fixed.^2.*exp(-2*alpha_fixed*thickness));
%     idx_t = find(T_sum >= 0.3);
%     Max_thickness(i) = thickness(idx_t(end));

%     figure(1);
%     plot(thickness/1e-9, T_sum,'Linewidth',2,'DisplayName', materials{i});
%     hold on;

%     xlabel('thickness (nm)');
%     ylabel('%');
%     legend;
%     grid on;
% end
% plot(thickness/1e-9, 0.3*ones(1,length(thickness)),'--','Linewidth',1,'DisplayName', "30% line");
% title(sprintf("Transmittance vs Thickness at \\lambda = %.f nm", lambda_center/1e-9));

% %% Print the maximum thickness for each of these materials

% for i = 1:length(Max_thickness)
%     fprintf('Maximum thickness for %s will be %0.2f nm\n',materials{i},Max_thickness(i)/1e-9);
% end

% %% Plot of transmittance for all wavelengths over the visible range at max thickness

% figure(2);

% for i = 1:length(Max_thickness)

%     subplot(1,3,i);
%     R = ((n-1).^2+k.^2)./((n+1).^2+k.^2);
%     T_sum = (exp(-alpha*Max_thickness(i)).*(1-R).^2)./(1-R.^2.*exp(-2*alpha*Max_thickness(i)));

%     plot(lambda*1e6, T_sum,'Linewidth',1.5);
%     hold on;

%     xlabel('\lambda \mum');
%     ylabel('%');
%     title(materials{i});
%     subtitle(sprintf("Thickness = %.3f \\mum", Max_thickness(i)/1e-6));
%     xlim([0.550 0.8]); % Visible Wavelength
%     grid on;
% end