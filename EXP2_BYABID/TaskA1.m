clc; clearvars; close all;

%% Data preparation and material parameters
% Define sample thicknesses: 100nm and 1cm films
W = [100e-9 1e-2]; % [meters]

% Import optical constants (n, k) data for GaAs
data = importdata('GaAs.txt');
lambda_um = data(:,1);        % Wavelength in micrometers
n = data(:,2);               % Refractive index
k = data(:,3);               % Extinction coefficient

% Convert wavelength to meters and calculate optical parameters
lambda = lambda_um*1e-6;     % Convert wavelength to meters
alpha = 4*pi.*k./lambda;     % Absorption coefficient calculation
R = ((n-1).^2+k.^2)./((n+1).^2+k.^2);  % Single-interface reflection coefficient

%% Create figure with enhanced visual properties
figure('Color', 'white', 'Position', [100 100 800 900])  % White background, larger figure

%% Reflectance Calculation and Plotting
subplot(311);
% Calculate reflectance for 100nm thickness
thickness_index = 1;
% Multiple reflection calculation using recursive formula
R_sum1 = R.*(1 + ((1-R).^2.*exp(-2*alpha*W(thickness_index)))./(1-R.^2.*exp(-2*alpha*W(thickness_index))));
plot(lambda*1e6, R_sum1, 'LineWidth', 2, 'Color', [0 0.4470 0.7410], 'DisplayName','W = 100nm');
xlim([0.2 0.8])
hold on;

% Calculate reflectance for 1cm thickness
thickness_index = 2;
R_sum2 = R.*(1 + ((1-R).^2.*exp(-2*alpha*W(thickness_index)))./(1-R.^2.*exp(-2*alpha*W(thickness_index))));
plot(lambda*1e6, R_sum2, 'LineWidth', 2, 'Color', [0.8500 0.3250 0.0980], 'DisplayName','W = 1cm');

% Enhance plot appearance
set(gca, 'FontSize', 12, 'FontName', 'Arial', 'LineWidth', 1.5)
xlabel('Wavelength (μm)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Reflectance', 'FontSize', 12, 'FontWeight', 'bold');
title("Reflectance", 'FontSize', 14, 'FontWeight', 'bold');
grid on;
legend('Location', 'best', 'FontSize', 10);
legend box off;

%% Transmittance Calculation and Plotting
subplot(312);
% Calculate transmittance for 100nm thickness
thickness_index = 1;
% Account for multiple internal reflections in transmittance
T_sum1 = (exp(-alpha*W(thickness_index)).*(1-R).^2)./(1-R.^2.*exp(-2*alpha*W(thickness_index)));
plot(lambda*1e6, T_sum1, 'LineWidth', 2, 'Color', [0 0.4470 0.7410], 'DisplayName','W = 100nm');
xlim([0.2 0.8])
hold on;

% Calculate transmittance for 1cm thickness
thickness_index = 2;
T_sum2 = (exp(-alpha*W(thickness_index)).*(1-R).^2)./(1-R.^2.*exp(-2*alpha*W(thickness_index)));
plot(lambda*1e6, T_sum2, 'LineWidth', 2, 'Color', [0.8500 0.3250 0.0980], 'DisplayName','W = 1cm');

% Enhance plot appearance
set(gca, 'FontSize', 12, 'FontName', 'Arial', 'LineWidth', 1.5)
xlabel('Wavelength (μm)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Transmittance', 'FontSize', 12, 'FontWeight', 'bold');
title("Transmittance", 'FontSize', 14, 'FontWeight', 'bold');
grid on;
legend('Location', 'best', 'FontSize', 10);
legend box off;

%% Absorption Calculation and Plotting
subplot(313);
% Calculate absorption for 100nm using energy conservation: A = 1 - R - T
A_sum1 = 1 - R_sum1 - T_sum1;
plot(lambda*1e6, A_sum1, 'LineWidth', 2, 'Color', [0 0.4470 0.7410], 'DisplayName','W = 100nm');
xlim([0.2 0.8])
hold on;

% Calculate absorption for 1cm
A_sum2 = 1 - R_sum2 - T_sum2;
plot(lambda*1e6, A_sum2, 'LineWidth', 2, 'Color', [0.8500 0.3250 0.0980], 'DisplayName','W = 1cm');

% Enhance plot appearance
set(gca, 'FontSize', 12, 'FontName', 'Arial', 'LineWidth', 1.5)
xlabel('Wavelength (μm)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Absorption', 'FontSize', 12, 'FontWeight', 'bold');
title("Absorption", 'FontSize', 14, 'FontWeight', 'bold');
grid on;
legend('Location', 'best', 'FontSize', 10);
legend box off;



%Abid Original Code
% clc; clearvars; close all;

% %% Data import
% W = [100e-9 1e-2]; % films having thicknesses of  100 nm and 1 cm
% data = importdata('GaAs.txt');
% lambda_um = data(:,1);
% n = data(:,2);
% k = data(:,3);

% lambda = lambda_um*1e-6;
% alpha = 4*pi.*k./lambda;
% R = ((n-1).^2+k.^2)./((n+1).^2+k.^2);

% %% Reflectance Calculation
% subplot(311);
% % Calculate for W = 100nm
% thickness_index = 1;
% R_sum1 = R.*(1 + ((1-R).^2.*exp(-2*alpha*W(thickness_index)))./(1-R.^2.*exp(-2*alpha*W(thickness_index))));
% plot(lambda*1e6, R_sum1,'DisplayName','W = 100nm');
% xlim([0.2 0.8])
% hold on;

% % Calculate for W = 1cm
% thickness_index = 2;
% R_sum2 = R.*(1 + ((1-R).^2.*exp(-2*alpha*W(thickness_index)))./(1-R.^2.*exp(-2*alpha*W(thickness_index))));
% plot(lambda*1e6, R_sum2,'DisplayName','W = 1cm');
% xlabel('wavelenth (um)');
% ylabel('percentage');
% %xlim([0.2 0.8])
% title("Reflectance");
% grid on;
% legend();
% legend box off;

% %% Transmittance Calculation
% subplot(312);
% % Calculate for W = 100nm
% thickness_index = 1;
% T_sum1 = (exp(-alpha*W(thickness_index)).*(1-R).^2)./(1-R.^2.*exp(-2*alpha*W(thickness_index)));
% plot(lambda*1e6, T_sum1,'DisplayName','W = 100nm');
% xlim([0.2 0.8])
% hold on;

% % Calculate for W = 1cm
% thickness_index = 2;
% T_sum2 = (exp(-alpha*W(thickness_index)).*(1-R).^2)./(1-R.^2.*exp(-2*alpha*W(thickness_index)));
% plot(lambda*1e6, T_sum2,'DisplayName','W = 1cm');
% xlabel('wavelenth (um)');
% ylabel('percentage');
% title("Transmittance");
% grid on;
% legend();
% legend box off;

% %% Absorption Calculation
% subplot(313);
% % Calculate for W = 100nm
% A_sum1 = 1 - R_sum1 - T_sum1;
% plot(lambda*1e6, A_sum1,'DisplayName','W = 100nm');
% xlim([0.2 0.8])
% hold on;

% % Calculate for W = 1cm
% A_sum2 = 1 - R_sum2 - T_sum2;
% plot(lambda*1e6, A_sum2,'DisplayName','W = 1cm');
% xlabel('wavelenth (um)');
% ylabel('percentage');
% title("Absorption");
% grid on;
% legend();
% legend box off;