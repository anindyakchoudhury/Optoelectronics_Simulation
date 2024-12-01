clc; clearvars; close all;

% Data from the screenshot
V = [4.995, 5.02, 4.96, 4.878, 4.70625, 4.5385, 4.381, 4.114, 3.7225, 3.05625, 2.262, 0.76, 0];
I = [0.0946, 0.1047, 0.1287, 0.1599, 0.2139, 0.2469, 0.2666, 0.2826, 0.2900, 0.2923, 0.2934, 0.2962, 0.2973];

% Calculate power to identify MPP region
P = V .* I;
[max_power, mpp_idx] = max(P);

% Define regions for fitting
% Shunt resistance region (near Isc)
shunt_region = 10:13;  % Last few points near short circuit
% Series resistance region (near Voc)
series_region = 1:4;   % First few points near open circuit

% Fit lines
p_shunt = polyfit(V(shunt_region), I(shunt_region), 1);
p_series = polyfit(V(series_region), I(series_region), 1);

% Calculate resistances (negative reciprocal of slopes)
R_shunt = -1/p_shunt(1);
R_series = -1/p_series(1);

% Create points for plotting fitted lines
V_shunt = linspace(min(V(shunt_region)), max(V(shunt_region)), 100);
I_shunt = polyval(p_shunt, V_shunt);
V_series = linspace(min(V(series_region)), max(V(series_region)), 100);
I_series = polyval(p_series, V_series);

% Plotting
figure('Color', 'white');

% Plot original I-V curve
plot(V, I, 'Color', [0.267, 0.447, 0.769], 'LineWidth', 2, 'Marker', 'o', ...
     'MarkerFaceColor', [0.267, 0.447, 0.769], 'MarkerSize', 6, ...
     'DisplayName', 'I-V Curve');
hold on;

% Plot fitted lines
plot(V_shunt, I_shunt, '--', 'Color', [0.850, 0.325, 0.098], 'LineWidth', 6, ...
     'DisplayName', sprintf('Shunt Region Fit ( R_{sh} = %.2f Ω)', R_shunt));
plot(V_series, I_series, '--', 'Color', [0.180, 0.545, 0.341], 'LineWidth', 6, ...
     'DisplayName', sprintf('Series Region Fit (R_s = %.2f Ω)', R_series));

% Mark MPP
plot(V(mpp_idx), I(mpp_idx), 'p', 'MarkerSize', 15, 'MarkerFaceColor', 'r', ...
     'DisplayName', 'Maximum Power Point');

% Customize grid appearance
grid on;
set(gca, 'GridLineStyle', ':');
set(gca, 'GridAlpha', 0.25);
set(gca, 'LineWidth', 1.2);

% Add labels and title with LaTeX formatting
xlabel('Voltage, $V$ (V)', 'FontSize', 12, 'FontWeight', 'bold', 'Interpreter', 'latex');
ylabel('Current, $I$ (A)', 'FontSize', 12, 'FontWeight', 'bold', 'Interpreter', 'latex');
title('Solar Cell I-V Characteristics with Resistance Analysis', ...
      'FontSize', 14, 'FontWeight', 'bold', 'Interpreter', 'latex');

% Add legend
legend('Location', 'best', 'FontSize', 14, 'Interpreter', 'latex', 'Box', 'off');

% Adjust figure size and appearance
set(gcf, 'Position', [100, 100, 800, 600]);
box on;
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP6_BYAKC\reportprepare\SeriesandShuntResistance_cell.png');
% Display results
fprintf('Analysis Results:\n');
fprintf('Shunt Resistance (Rsh): %.2f Ω\n', R_shunt);
fprintf('Series Resistance (Rs): %.2f Ω\n', R_series);
fprintf('Maximum Power Point: %.2f W at V = %.2f V, I = %.2f A\n', ...
        max_power, V(mpp_idx), I(mpp_idx));