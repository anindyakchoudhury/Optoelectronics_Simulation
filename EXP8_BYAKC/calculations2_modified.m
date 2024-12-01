clc;
clearvars;
close all;

% Define the list of files to process
files = {'IVL_Data_yellow', 'IVL_Data_green', 'IVL_Data_white', 'IVL_Data_red'};

% Create color array for different plots
colors = {'y-', 'g-', 'c-', 'r-'};

% Set default figure properties for all plots
set(0, 'DefaultFigureColor', 'white');
set(0, 'DefaultAxesLineWidth', 1.5);
set(0, 'DefaultAxesBox', 'on');
set(0, 'DefaultAxesTickLength', [0.02 0.02]);

% Read data
data = readmatrix('IVL_Data_yellow', 'NumHeaderLines', 2);
Vy = data(:, 1)'; Iy = data(:, 2)'; Ly = data(:, 3)';

data = readmatrix('IVL_Data_green', 'NumHeaderLines', 2);
Vg = data(:, 1)'; Ig = data(:, 2)'; Lg = data(:, 3)';

data = readmatrix('IVL_Data_white', 'NumHeaderLines', 2);
Vw = data(:, 1)'; Iw = data(:, 2)'; Lw = data(:, 3)';

data = readmatrix('IVL_Data_red', 'NumHeaderLines', 2);
Vr = data(:, 1)'; Ir = data(:, 2)'; Lr = data(:, 3)';

% Custom colors for better visibility
yellow_color = [0.9290, 0.6940, 0.1250];  % Dark golden
green_color = [0.4660, 0.6740, 0.1880];   % Olive green
blue_color = [0, 0.4470, 0.7410];         % Royal blue
red_color = [0.8500, 0.3250, 0.0980];     % Dark orange-red

%% I-V Characteristics
figure('Position', [100, 100, 800, 600]);

% Yellow LED
p = polyfit(Vy, Iy, 1);
V_fit = linspace(0, max(Vy), 100);
I_fit = polyval(p, V_fit);
I_fit(I_fit < 0) = 0;
plot(Vy, Iy, 'o', 'Color', 'black', 'MarkerSize', 8, 'MarkerFaceColor', yellow_color);
hold on;
plot(V_fit, I_fit, 'Color', yellow_color, 'LineWidth', 2);

% Green LED
p = polyfit(Vg, Ig, 1);
V_fit = linspace(0, max(Vg), 100);
I_fit = polyval(p, V_fit);
I_fit(I_fit < 0) = 0;
plot(Vg, Ig, 'o', 'Color', 'black', 'MarkerSize', 8, 'MarkerFaceColor', green_color);
plot(V_fit, I_fit, 'Color', green_color, 'LineWidth', 2);

% White LED
p = polyfit(Vw, Iw, 1);
V_fit = linspace(0, max(Vw), 100);
I_fit = polyval(p, V_fit);
I_fit(I_fit < 0) = 0;
plot(Vw, Iw, 'o', 'Color', 'black', 'MarkerSize', 8, 'MarkerFaceColor', blue_color);
plot(V_fit, I_fit, 'Color', blue_color, 'LineWidth', 2);

% Red LED
p = polyfit(Vr, Ir, 1);
V_fit = linspace(0, max(Vr), 100);
I_fit = polyval(p, V_fit);
I_fit(I_fit < 0) = 0;
plot(Vr, Ir, 'o', 'Color', 'black', 'MarkerSize', 8, 'MarkerFaceColor', red_color);
plot(V_fit, I_fit, 'Color', red_color, 'LineWidth', 2);

grid on;
box on;
legend({'Yellow LED (Data)', 'Yellow LED (Fit)', 'Green LED (Data)', 'Green LED (Fit)', ...
    'White LED (Data)', 'White LED (Fit)', 'Red LED (Data)', 'Red LED (Fit)'}, ...
    'Location', 'northwest', 'FontSize', 12, 'Box', 'off');

title('Current-Voltage (I-V) Characteristics of Different LED Colors', ...
    'FontSize', 14, 'FontWeight', 'bold');
xlabel('Forward Voltage (V)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Forward Current (mA)', 'FontSize', 12, 'FontWeight', 'bold');
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP8_BYAKC\reportprepare\IV_Characteristics.png');

%% L-I Characteristics
figure('Position', [100, 100, 800, 600]);

% Plot with custom styling
plot(Iy, Ly, '-', 'Color', yellow_color, 'LineWidth', 2);
hold on;
plot(Iy, Ly, 'o', 'Color', 'black', 'MarkerSize', 8, 'MarkerFaceColor', yellow_color);
plot(Ig, Lg, '-', 'Color', green_color, 'LineWidth', 2);
plot(Ig, Lg, 'o', 'Color', 'black', 'MarkerSize', 8, 'MarkerFaceColor', green_color);
plot(Iw, Lw, '-', 'Color', blue_color, 'LineWidth', 2);
plot(Iw, Lw, 'o', 'Color', 'black', 'MarkerSize', 8, 'MarkerFaceColor', blue_color);
plot(Ir, Lr, '-', 'Color', red_color, 'LineWidth', 2);
plot(Ir, Lr, 'o', 'Color', 'black', 'MarkerSize', 8, 'MarkerFaceColor', red_color);

grid on;
box on;
legend({'Yellow LED', '', 'Green LED', '', 'White LED', '', 'Red LED', ''}, ...
    'Location', 'northwest', 'FontSize', 12, 'Box', 'off');

title('Light Output Power vs. Forward Current (L-I) Characteristics', ...
    'FontSize', 14, 'FontWeight', 'bold');
xlabel('Forward Current (mA)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Optical Power (µW)', 'FontSize', 12, 'FontWeight', 'bold');
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP8_BYAKC\reportprepare\LI_Characteristics.png');
%% L-V Characteristics
figure('Position', [100, 100, 800, 600]);

% Plot with custom styling
plot(Vy, Ly, '-', 'Color', yellow_color, 'LineWidth', 2);
hold on;
plot(Vy, Ly, 'o', 'Color', 'black', 'MarkerSize', 8, 'MarkerFaceColor', yellow_color);
plot(Vg, Lg, '-', 'Color', green_color, 'LineWidth', 2);
plot(Vg, Lg, 'o', 'Color', 'black', 'MarkerSize', 8, 'MarkerFaceColor', green_color);
plot(Vw, Lw, '-', 'Color', blue_color, 'LineWidth', 2);
plot(Vw, Lw, 'o', 'Color', 'black', 'MarkerSize', 8, 'MarkerFaceColor', blue_color);
plot(Vr, Lr, '-', 'Color', red_color, 'LineWidth', 2);
plot(Vr, Lr, 'o', 'Color', 'black', 'MarkerSize', 8, 'MarkerFaceColor', red_color);

grid on;
box on;
legend({'Yellow LED', '', 'Green LED', '', 'White LED', '', 'Red LED', ''}, ...
    'Location', 'northwest', 'FontSize', 12, 'Box', 'off');

title('Light Output Power vs. Forward Voltage (L-V) Characteristics', ...
    'FontSize', 14, 'FontWeight', 'bold');
xlabel('Forward Voltage (V)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Optical Power (µW)', 'FontSize', 12, 'FontWeight', 'bold');
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP8_BYAKC\reportprepare\LV_Characteristics.png');
%% External Quantum Efficiency (EQE)
% Calculate EQE
eqe_y = ((Ly*10^-6*570*10^-9*1.6*10^-19)./(6.626*10^-34*3*10^8*Iy*10^-3)).*100;
eqe_g = ((Lg*10^-6*570*10^-9*1.6*10^-19)./(6.626*10^-34*3*10^8*Ig*10^-3)).*100;
eqe_w = ((Lw*10^-6*570*10^-9*1.6*10^-19)./(6.626*10^-34*3*10^8*Iw*10^-3)).*100;
eqe_r = ((Lr*10^-6*570*10^-9*1.6*10^-19)./(6.626*10^-34*3*10^8*Ir*10^-3)).*100;

figure('Position', [100, 100, 800, 600]);

% Plot with custom styling
plot(Ly, eqe_y, '-', 'Color', yellow_color, 'LineWidth', 2);
hold on;
plot(Ly, eqe_y, 'o', 'Color', 'black', 'MarkerSize', 8, 'MarkerFaceColor', yellow_color);
plot(Lg, eqe_g, '-', 'Color', green_color, 'LineWidth', 2);
plot(Lg, eqe_g, 'o', 'Color', 'black', 'MarkerSize', 8, 'MarkerFaceColor', green_color);
plot(Lw, eqe_w, '-', 'Color', blue_color, 'LineWidth', 2);
plot(Lw, eqe_w, 'o', 'Color', 'black', 'MarkerSize', 8, 'MarkerFaceColor', blue_color);
plot(Lr, eqe_r, '-', 'Color', red_color, 'LineWidth', 2);
plot(Lr, eqe_r, 'o', 'Color', 'black', 'MarkerSize', 8, 'MarkerFaceColor', red_color);

grid on;
box on;
legend({'Yellow LED', '', 'Green LED', '', 'White LED', '', 'Red LED', ''}, ...
    'Location', 'northwest', 'FontSize', 12, 'Box', 'off');

title('External Quantum Efficiency (EQE) vs. Optical Power', ...
    'FontSize', 14, 'FontWeight', 'bold');
xlabel('Optical Power (µW)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('External Quantum Efficiency (%)', 'FontSize', 12, 'FontWeight', 'bold');
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP8_BYAKC\reportprepare\External_Quantum_Efficiency.png');
%% Power Conversion Efficiency (PCE)
% Calculate PCE
pce_y = ((Ly*10^-6)./(Vy.*Iy*10^-3)).*100;
pce_g = ((Lg*10^-6)./(Vg.*Ig*10^-3)).*100;
pce_w = ((Lw*10^-6)./(Vw.*Iw*10^-3)).*100;
pce_r = ((Lr*10^-6)./(Vr.*Ir*10^-3)).*100;

figure('Position', [100, 100, 800, 600]);

% Plot with custom styling
plot(Ly, pce_y, '-', 'Color', yellow_color, 'LineWidth', 2);
hold on;
plot(Ly, pce_y, 'o', 'Color', 'black', 'MarkerSize', 8, 'MarkerFaceColor', yellow_color);
plot(Lg, pce_g, '-', 'Color', green_color, 'LineWidth', 2);
plot(Lg, pce_g, 'o', 'Color', 'black', 'MarkerSize', 8, 'MarkerFaceColor', green_color);
plot(Lw, pce_w, '-', 'Color', blue_color, 'LineWidth', 2);
plot(Lw, pce_w, 'o', 'Color', 'black', 'MarkerSize', 8, 'MarkerFaceColor', blue_color);
plot(Lr, pce_r, '-', 'Color', red_color, 'LineWidth', 2);
plot(Lr, pce_r, 'o', 'Color', 'black', 'MarkerSize', 8, 'MarkerFaceColor', red_color);

grid on;
box on;
legend({'Yellow LED', '', 'Green LED', '', 'White LED', '', 'Red LED', ''}, ...
    'Location', 'northwest', 'FontSize', 12, 'Box', 'off');

title('Power Conversion Efficiency (PCE) vs. Optical Power', ...
    'FontSize', 14, 'FontWeight', 'bold');
xlabel('Optical Power (µW)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Power Conversion Efficiency (%)', 'FontSize', 12, 'FontWeight', 'bold');
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP8_BYAKC\reportprepare\Power_Conversion_Efficiency.png');
%% Luminous Efficacy (LE)
% Calculate LE
le_y = (Ly*10^-6*633*1)./(Vy.*Iy*10^-3);
le_g = (Lg*10^-6*633*0.87)./(Vg.*Ig*10^-3);
le_w = (Lw*10^-6*633*1)./(Vw.*Iw*10^-3);
le_r = (Lr*10^-6*633*0.1)./(Vr.*Ir*10^-3);

figure('Position', [100, 100, 800, 600]);

% Plot with custom styling
plot(Ly, le_y, '-', 'Color', yellow_color, 'LineWidth', 2);
hold on;
plot(Ly, le_y, 'o', 'Color', 'black', 'MarkerSize', 8, 'MarkerFaceColor', yellow_color);
plot(Lg, le_g, '-', 'Color', green_color, 'LineWidth', 2);
plot(Lg, le_g, 'o', 'Color', 'black', 'MarkerSize', 8, 'MarkerFaceColor', green_color);
plot(Lw, le_w, '-', 'Color', blue_color, 'LineWidth', 2);
plot(Lw, le_w, 'o', 'Color', 'black', 'MarkerSize', 8, 'MarkerFaceColor', blue_color);
plot(Lr, le_r, '-', 'Color', red_color, 'LineWidth', 2);
plot(Lr, le_r, 'o', 'Color', 'black', 'MarkerSize', 8, 'MarkerFaceColor', red_color);

legend('Yellow', '', 'Green', '', 'White', '', 'red','');
legend('Location', 'best', 'FontSize', 12);


% Add labels and title
title('Luminous efficacy', 'FontSize', 14);
xlabel('Optical Power, L(uW)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('LE', 'FontSize', 12, 'FontWeight', 'bold');
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP8_BYAKC\reportprepare\Luminous_Efficacy.png');