% Define the exact wavelength and flux data points
wavelength = [353.1730769230769, 376.5064102564103, 399.7435897435897, 426.31410256410254, 436.28205128205116, ...
    442.37179487179486, 444.51923076923066, 450.22435897435884, 452.56410256410254, 459.29487179487165, ...
    463.1410256410254, 462.6282051282049, 467.4038461538461, 468.7179487179485, 470.8653846153846, ...
    484.4230769230768, 484.93589743589735, 488.8141025641025, 500, 507.2435897435897, 533.3653846153845, ...
    586.6346153846152, 606.2499999999999, 622.4358974358975, 634.8717948717949, 651.4423076923076, ...
    687.5, 722.724358974359, 753.6538461538462, 815.3205128205129, 865.2884615384614, 899.8717948717949, ...
    949.8397435897436, 999.7435897435898, 1026.5384615384614, 1045.480769230769];

flux = [0.003964166666666661, 0.002400833333333334, 0.0014237500000000005, 0.00357333333333333, ...
    0.013148750000000002, 0.022919583333333337, 0.03327666666666667, 0.045392499999999995, ...
    0.05457708333333334, 0.060439583333333345, 0.06043958333333333, 0.06356625, 0.05789916666666667, ...
    0.04988708333333334, 0.03679416666666667, 0.024482916666666663, 0.02135625, 0.02116083333333333, ...
    0.02331041666666667, 0.02604625, 0.03093166666666667, 0.03444916666666667, 0.03210416666666666, ...
    0.02721875, 0.021747083333333334, 0.014516666666666667, 0.005722916666666661, 0.0020099999999999858, ...
    0.001032916666666656, 0.000251249999999972, 0.0004466666666666603, 0.000642083333333327, ...
    0.000837500000000004, 0.0014237499999999867, 0.002205416666666669, 0.003964166666666651];

% Create interpolated points for smoother curve
wavelength_interp = linspace(min(wavelength), max(wavelength), 1000);
flux_interp = spline(wavelength, flux, wavelength_interp);

% Create the figure with specific size
figure('Position', [100, 100, 800, 600]);

% Plot both the interpolated curve and the original data points
plot(wavelength_interp, flux_interp, 'k-', 'LineWidth', 1.2);
hold on;
plot(wavelength, flux, 'k.', 'MarkerSize', 8);
hold off;

% Set the axis limits
xlim([350 1050]);
ylim([0 0.07]);

% Add labels and title with nice formatting
xlabel('Wavelength (nm)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Spectral Flux (W/nm)', 'FontSize', 12, 'FontWeight', 'bold');
title('Spectral Power Distribution of Light Source', 'FontSize', 14, 'FontWeight', 'bold');

% Add grid
grid on;

% Customize grid and axis appearance
set(gca, 'GridLineStyle', ':');
set(gca, 'GridAlpha', 0.3);
set(gca, 'Box', 'on');

% Set background color to white
set(gcf, 'Color', 'white');

% Add minor grid lines
grid minor;

% Format tick labels
ax = gca;
ax.FontSize = 10;
ax.TickDir = 'out';
ax.YTick = 0:0.007:0.07;

% Display all decimal places in Y-axis
ytickformat('%.4f');

% Optional: Save the figure
% saveas(gcf, 'spectral_distribution.png');