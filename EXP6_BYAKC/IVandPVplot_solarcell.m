clc; clearvars; close all;

% Data from the screenshot
V = [4.995, 5.02, 4.96, 4.878, 4.70625, 4.5385, 4.381, 4.114, 3.7225, 3.05625, 2.262, 0.76, 0];
I = [0.0946, 0.1047, 0.1287, 0.1599, 0.2139, 0.2469, 0.2666, 0.2826, 0.2900, 0.2923, 0.2934, 0.2962, 0.2973];
P = [0.47, 0.53, 0.64, 0.78, 1.01, 1.12, 1.17, 1.16, 1.08, 0.89, 0.66, 0.23, 0.00];

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
title('I-V Characteristics of Solar Cell', 'FontSize', 14, 'FontWeight', 'bold', 'Interpreter', 'latex');

% Adjust figure size and appearance
set(gcf, 'Position', [100, 100, 800, 600]);
box on;
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP6_BYAKC\reportprepare\IV_Characteristics_cell.png');
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
title('P-V Characteristics of Solar Cell', 'FontSize', 14, 'FontWeight', 'bold', 'Interpreter', 'latex');

% Adjust figure size and appearance
set(gcf, 'Position', [100, 100, 800, 600]);
box on;
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP6_BYAKC\reportprepare\V_Characteristics_cell.png');
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
title('I-V and P-V Characteristics of Solar Cell', 'FontSize', 14, 'FontWeight', 'bold', 'Interpreter', 'latex');

% Add legend
legend('I-V Characteristic', 'P-V Characteristic', ...
       'Location', 'best', 'FontSize', 10, 'Interpreter', 'latex', 'Box', 'off');

% Adjust figure size and appearance
set(gcf, 'Position', [100, 100, 800, 600]);
box on;
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP6_BYAKC\reportprepare\IVPV_Characteristics_cell.png');