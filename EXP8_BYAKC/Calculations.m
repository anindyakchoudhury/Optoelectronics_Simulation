clc;
clearvars;
close all;

% Define the list of files to process
files = {'IVL_Data_yellow', 'IVL_Data_green', 'IVL_Data_white', 'IVL_Data_red'};

% Create color array for different plots
colors = {'y-', 'g-', 'c-', 'r-'};

data = readmatrix('IVL_Data_yellow', 'NumHeaderLines', 2);
% Extract voltage and current
Vy = data(:, 1)'; % Voltage
Iy = data(:, 2)'; % Current
Ly = data(:, 3)'; % Power

data = readmatrix('IVL_Data_green', 'NumHeaderLines', 2);
% Extract voltage and current
Vg = data(:, 1)'; % Voltage
Ig = data(:, 2)'; % Current
Lg = data(:, 3)'; % Power

data = readmatrix('IVL_Data_white', 'NumHeaderLines', 2);
% Extract voltage and current
Vw = data(:, 1)'; % Voltage
Iw = data(:, 2)'; % Current
Lw = data(:, 3)'; % Power

data = readmatrix('IVL_Data_red', 'NumHeaderLines', 2);
% Extract voltage and current
Vr = data(:, 1)'; % Voltage
Ir = data(:, 2)'; % Current
Lr = data(:, 3)'; % Power


%% YEllow
% Perform polynomial curve fitting (e.g., 1st degree for linear approximation)
p = polyfit(Vy, Iy, 1); % Fit a 1st-degree polynomial

% Generate fitted values starting from 0
V_fit = linspace(0, max(Vy), 100); % Generate voltage values for the fit, starting from 0
I_fit = polyval(p, V_fit); % Compute the fitted current values
I_fit(I_fit < 0) = 0;

% Plotting the data
hold on;
plot(Vy, Iy, 'o', 'Color', 'black', 'MarkerSize', 8, 'DisplayName', 'Data'); % Original data
plot(V_fit, I_fit, 'Color', 'yellow', 'LineWidth', 1.5, 'DisplayName', 'Curve Fit'); % Fitted curve

%% Green
% Perform polynomial curve fitting (e.g., 1st degree for linear approximation)
p = polyfit(Vg, Ig, 1); % Fit a 1st-degree polynomial

% Generate fitted values starting from 0
V_fit = linspace(0, max(Vg), 100); % Generate voltage values for the fit, starting from 0
I_fit = polyval(p, V_fit); % Compute the fitted current values
I_fit(I_fit < 0) = 0;

% Plotting the data
hold on;
plot(Vg, Ig, 'o', 'Color', 'black', 'MarkerSize', 8, 'DisplayName', 'Data'); % Original data
plot(V_fit, I_fit, 'Color', 'green', 'LineWidth', 1.5, 'DisplayName', 'Curve Fit'); % Fitted curve

%% White
% Perform polynomial curve fitting (e.g., 1st degree for linear approximation)
p = polyfit(Vw, Iw, 1); % Fit a 1st-degree polynomial

% Generate fitted values starting from 0
V_fit = linspace(0, max(Vw), 100); % Generate voltage values for the fit, starting from 0
I_fit = polyval(p, V_fit); % Compute the fitted current values
I_fit(I_fit < 0) = 0;

% Plotting the data
hold on;
plot(Vw, Iw, 'o', 'Color', 'black', 'MarkerSize', 8, 'DisplayName', 'Data'); % Original data
plot(V_fit, I_fit, 'Color', 'blue', 'LineWidth', 1.5, 'DisplayName', 'Curve Fit'); % Fitted curve

%% Red
% Perform polynomial curve fitting (e.g., 1st degree for linear approximation)
p = polyfit(Vr, Ir, 1); % Fit a 1st-degree polynomial

% Generate fitted values starting from 0
V_fit = linspace(0, max(Vr), 100); % Generate voltage values for the fit, starting from 0
I_fit = polyval(p, V_fit); % Compute the fitted current values
I_fit(I_fit < 0) = 0;

% Plotting the data
hold on;
plot(Vr, Ir, 'o', 'Color', 'black', 'MarkerSize', 8, 'DisplayName', 'Data'); % Original data
plot(V_fit, I_fit, 'Color', 'red', 'LineWidth', 1.5, 'DisplayName', 'Curve Fit'); % Fitted curve
hold off
grid on;

legend('', 'Yellow', '', 'Green', '', 'White', '','red');
legend('Location', 'best', 'FontSize', 12);

% Add labels and title
title('I-V Characteristics', 'FontSize', 14);
xlabel('Voltage (V)', 'FontSize', 12);
ylabel('Current (mA)', 'FontSize', 12);


%% LI

figure(2)
plot(Iy, Ly, 'Color', 'yellow', 'LineWidth', 1.5);
hold on
plot(Iy, Ly, 'o', 'Color', 'black', 'LineWidth', 1.5);
hold on
plot(Ig, Lg, 'Color', 'green', 'LineWidth', 1.5);
hold on
plot(Ig, Lg, 'o', 'Color', 'black', 'LineWidth', 1.5);
hold on
plot(Iw, Lw, 'Color', 'blue', 'LineWidth', 1.5);
hold on
plot(Iw, Lw, 'o', 'Color', 'black', 'LineWidth', 1.5);
hold on
plot(Ir, Lr, 'Color', 'red', 'LineWidth', 1.5);
hold on
plot(Ir, Lr, 'o', 'Color', 'black', 'LineWidth', 1.5);
hold on

legend('Yellow', '', 'Green', '', 'White', '', 'red','');
legend('Location', 'best', 'FontSize', 12);

% Add labels and title
title('L-I Characteristics', 'FontSize', 14);
xlabel('Current (mA)', 'FontSize', 12);
ylabel('optical Power, L(uW)', 'FontSize', 12);

%% LV

figure(3)
plot(Vy, Ly, 'Color', 'yellow', 'LineWidth', 1.5);
hold on
plot(Vy, Ly, 'o', 'Color', 'black', 'LineWidth', 1.5);
hold on
plot(Vg, Lg, 'Color', 'green', 'LineWidth', 1.5);
hold on
plot(Vg, Lg, 'o', 'Color', 'black', 'LineWidth', 1.5);
hold on
plot(Vw, Lw, 'Color', 'blue', 'LineWidth', 1.5);
hold on
plot(Vw, Lw, 'o', 'Color', 'black', 'LineWidth', 1.5);
hold on
plot(Vr, Lr, 'Color', 'red', 'LineWidth', 1.5);
hold on
plot(Vr, Lr, 'o', 'Color', 'black', 'LineWidth', 1.5);
hold on

legend('Yellow', '', 'Green', '', 'White', '', 'red','');
legend('Location', 'best', 'FontSize', 12);

% Add labels and title
title('L-V Characteristics', 'FontSize', 14);
xlabel('Voltage(V)', 'FontSize', 12);
ylabel('optical Power, L(uW)', 'FontSize', 12);

%% EQE

eqe_y = ((Ly*10^-6*570*10^-9*1.6*10^-19)./(6.626*10^-34*3*10^8*Iy*10^-3)).*100;
eqe_g = ((Lg*10^-6*570*10^-9*1.6*10^-19)./(6.626*10^-34*3*10^8*Ig*10^-3)).*100;
eqe_w = ((Lw*10^-6*570*10^-9*1.6*10^-19)./(6.626*10^-34*3*10^8*Iw*10^-3)).*100;
eqe_r = ((Lr*10^-6*570*10^-9*1.6*10^-19)./(6.626*10^-34*3*10^8*Ir*10^-3)).*100;

figure(4)
plot(Ly, eqe_y, 'Color', 'yellow', 'LineWidth', 1.5);
hold on
plot(Ly, eqe_y, 'o', 'Color', 'black', 'LineWidth', 1.5);
hold on
plot(Lg, eqe_g, 'Color', 'green', 'LineWidth', 1.5);
hold on
plot(Lg, eqe_g, 'o', 'Color', 'black', 'LineWidth', 1.5);
hold on
plot(Lw, eqe_w, 'Color', 'blue', 'LineWidth', 1.5);
hold on
plot(Lw, eqe_w, 'o', 'Color', 'black', 'LineWidth', 1.5);
hold on
plot(Lr, eqe_r, 'Color', 'red', 'LineWidth', 1.5);
hold on
plot(Lr, eqe_r, 'o', 'Color', 'black', 'LineWidth', 1.5);
hold on

legend('Yellow', '', 'Green', '', 'White', '', 'red','');
legend('Location', 'best', 'FontSize', 12);

% Add labels and title
title('External quantum efficiency', 'FontSize', 14);
xlabel('Optical Power, L(uW)', 'FontSize', 12);
ylabel('EQE', 'FontSize', 12);

%% PCE

pce_y = ((Ly*10^-6)./(Vy.*Iy*10^-3)).*100;
pce_g = ((Lg*10^-6)./(Vg.*Ig*10^-3)).*100;
pce_w = ((Lw*10^-6)./(Vw.*Iw*10^-3)).*100;
pce_r = ((Lr*10^-6)./(Vr.*Ir*10^-3)).*100;

figure(5)
plot(Ly, pce_y, 'Color', 'yellow', 'LineWidth', 1.5);
hold on
plot(Ly, pce_y, 'o', 'Color', 'black', 'LineWidth', 1.5);
hold on
plot(Lg, pce_g, 'Color', 'green', 'LineWidth', 1.5);
hold on
plot(Lg, pce_g, 'o', 'Color', 'black', 'LineWidth', 1.5);
hold on
plot(Lw, pce_w, 'Color', 'blue', 'LineWidth', 1.5);
hold on
plot(Lw, pce_w, 'o', 'Color', 'black', 'LineWidth', 1.5);
hold on
plot(Lr, pce_r, 'Color', 'red', 'LineWidth', 1.5);
hold on
plot(Lr, pce_r, 'o', 'Color', 'black', 'LineWidth', 1.5);
hold on

legend('Yellow', '', 'Green', '', 'White', '', 'red','');
legend('Location', 'best', 'FontSize', 12);

% Add labels and title
title('Power conversion efficiency', 'FontSize', 14);
xlabel('Optical Power, L(uW)', 'FontSize', 12);
ylabel('PCE', 'FontSize', 12);

%% LE

le_y = (Ly*10^-6*633*1)./(Vy.*Iy*10^-3);
le_g = (Lg*10^-6*633*0.87)./(Vg.*Ig*10^-3);
le_w = (Lw*10^-6*633*1)./(Vw.*Iw*10^-3);
le_r = (Lr*10^-6*633*0.1)./(Vr.*Ir*10^-3);

figure(6)
plot(Ly, le_y, 'Color', 'yellow', 'LineWidth', 1.5);
hold on
plot(Ly, le_y, 'o', 'Color', 'black', 'LineWidth', 1.5);
hold on
plot(Lg, le_g, 'Color', 'green', 'LineWidth', 1.5);
hold on
plot(Lg, le_g, 'o', 'Color', 'black', 'LineWidth', 1.5);
hold on
plot(Lw, le_w, 'Color', 'blue', 'LineWidth', 1.5);
hold on
plot(Lw, le_w, 'o', 'Color', 'black', 'LineWidth', 1.5);
hold on
plot(Lr, le_r, 'Color', 'red', 'LineWidth', 1.5);
hold on
plot(Lr, le_r, 'o', 'Color', 'black', 'LineWidth', 1.5);
hold on

legend('Yellow', '', 'Green', '', 'White', '', 'red','');
legend('Location', 'best', 'FontSize', 12);

% Add labels and title
title('Luminous efficacy', 'FontSize', 14);
xlabel('Optical Power, L(uW)', 'FontSize', 12);
ylabel('LE', 'FontSize', 12);