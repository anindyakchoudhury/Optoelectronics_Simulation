clc; clearvars; close all;

% Data from the screenshot
V = [19.98, 20.08, 19.84, 19.512, 18.825, 18.154, 17.524, 16.456, 14.89, 12.225, 9.048, 3.04, 0];
I = [0.851, 0.942, 1.158, 1.439, 1.925, 2.222, 2.399, 2.543, 2.61, 2.631, 2.641, 2.666, 2.676];

% Calculate Power
P = V .* I;

% Create modern color scheme
color_iv = [0.267, 0.447, 0.769];  % Royal blue
color_pv = [0.850, 0.325, 0.098];  % Coral red

% Plot I-V Characteristics
figure('Color', 'white');
plot(V, I, 'Color', color_iv, 'LineWidth', 2, 'Marker', 'o', ...
     'MarkerFaceColor', color_iv, 'MarkerSize', 6);

% Customize grid appearance
grid on;
set(gca, 'GridLineStyle', ':');
set(gca, 'GridAlpha', 0.25);
set(gca, 'LineWidth', 1.2);

% Add labels and title with LaTeX formatting
xlabel('Voltage, $V$ (V)', 'FontSize', 12, 'FontWeight', 'bold', 'Interpreter', 'latex');
ylabel('Current, $I$ (A)', 'FontSize', 12, 'FontWeight', 'bold', 'Interpreter', 'latex');
title('I-V Characteristics of Solar Panel', 'FontSize', 14, 'FontWeight', 'bold', 'Interpreter', 'latex');

% Adjust figure size and appearance
set(gcf, 'Position', [100, 100, 800, 600]);
box on;
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP6_BYAKC\reportprepare\IV_Characteristics.png');
% Plot P-V Characteristics
figure('Color', 'white');
plot(V, P, 'Color', color_pv, 'LineWidth', 2, 'Marker', 'o', ...
     'MarkerFaceColor', color_pv, 'MarkerSize', 6);

% Customize grid appearance
grid on;
set(gca, 'GridLineStyle', ':');
set(gca, 'GridAlpha', 0.25);
set(gca, 'LineWidth', 1.2);

% Add labels and title with LaTeX formatting
xlabel('Voltage, $V$ (V)', 'FontSize', 12, 'FontWeight', 'bold', 'Interpreter', 'latex');
ylabel('Power, $P$ (W)', 'FontSize', 12, 'FontWeight', 'bold', 'Interpreter', 'latex');
title('P-V Characteristics of Solar Panel', 'FontSize', 14, 'FontWeight', 'bold', 'Interpreter', 'latex');

% Adjust figure size and appearance
set(gcf, 'Position', [100, 100, 800, 600]);
box on;
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP6_BYAKC\reportprepare\PV_Characteristics.png');
% Combined Plot
figure('Color', 'white');

% Create left y-axis for current
yyaxis left
plot(V, I, 'Color', color_iv, 'LineWidth', 2, 'Marker', 'o', ...
     'MarkerFaceColor', color_iv, 'MarkerSize', 6);
ylabel('Current, $I$ (A)', 'FontSize', 12, 'FontWeight', 'bold', 'Interpreter', 'latex');
set(gca, 'YColor', color_iv);

% Create right y-axis for power
yyaxis right
plot(V, P, 'Color', color_pv, 'LineWidth', 2, 'Marker', 'o', ...
     'MarkerFaceColor', color_pv, 'MarkerSize', 6);
ylabel('Power, $P$ (W)', 'FontSize', 12, 'FontWeight', 'bold', 'Interpreter', 'latex');
set(gca, 'YColor', color_pv);

% Customize grid appearance
grid on;
set(gca, 'GridLineStyle', ':');
set(gca, 'GridAlpha', 0.25);
set(gca, 'LineWidth', 1.2);

% Add labels and title with LaTeX formatting
xlabel('Voltage, $V$ (V)', 'FontSize', 12, 'FontWeight', 'bold', 'Interpreter', 'latex');
title('I-V and P-V Characteristics of Solar Panel', 'FontSize', 14, 'FontWeight', 'bold', 'Interpreter', 'latex');

% Add legend
legend('I-V Characteristic', 'P-V Characteristic', ...
       'Location', 'best', 'FontSize', 10, 'Interpreter', 'latex', 'Box', 'off');

% Adjust figure size and appearance
set(gcf, 'Position', [100, 100, 800, 600]);
box on;
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP6_BYAKC\reportprepare\IVPV_Characteristics.png');