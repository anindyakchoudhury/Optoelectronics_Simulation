clc;
clearvars;
close all;
% Plot IV Characteristics for all colors at same plot

% Define the list of files to process
files = {'IV_yellow.txt', 'IV_green.txt', 'IV_white.txt', 'IV_red.txt'};

% Create color array for different plots
colors = {'m-', 'g-', 'b-', 'r-'};

for i = 1:length(files)
    % Read the data from the file
    data = readmatrix(files{i}, 'NumHeaderLines', 2);
    
    % Extract voltage and current
    V = data(:, 1)'; % Voltage 
    I = data(:, 2)'; % Current
    
    % Perform polynomial curve fitting (e.g., 1st degree for linear approximation)
    p = polyfit(V, I, 1); % Fit a 1st-degree polynomial
    
    % Generate fitted values starting from 0
    V_fit = linspace(0, max(V), 100); % Generate voltage values for the fit, starting from 0
    I_fit = polyval(p, V_fit); % Compute the fitted current values
    I_fit(I_fit < 0) = 0;
    
    % Plotting the data

    hold on;
    plot(V, I, 'o', 'Color', 'black', 'MarkerSize', 8, 'DisplayName', 'Data'); % Original data
    plot(V_fit, I_fit, colors{i}, 'LineWidth', 1.5, 'DisplayName', 'Curve Fit'); % Fitted curve
    % Configure axis and grid
    xlim([0 max(V_fit)]); % Start x-axis from 0
    ylim([0, max(I_fit)]); % Ensure y-axis also starts from 0
    grid on;
end

legend('Experimetal Data', 'Yellow', '', 'Green', '', 'White', '','red');
legend('Location', 'best', 'FontSize', 12);

% Add labels and title
title('I-V Characteristics', 'FontSize', 14);
xlabel('Voltage (V)', 'FontSize', 12);
ylabel('Current (mA)', 'FontSize', 12);


