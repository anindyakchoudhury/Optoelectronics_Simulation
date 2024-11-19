% clc;
% clearvars;
% close all;
% % Plot IV Characteristics for all colors at same plot

% % Define the list of files to process
% files = {'IV_yellow.txt', 'IV_green.txt', 'IV_white.txt', 'IV_red.txt'};

% % Create color array for different plots
% colors = {'m-', 'g-', 'b-', 'r-'};

% for i = 1:length(files)
%     % Read the data from the file
%     data = readmatrix(files{i}, 'NumHeaderLines', 2);

%     % Extract voltage and current
%     V = data(:, 1)'; % Voltage
%     I = data(:, 2)'; % Current

%     % Perform polynomial curve fitting (e.g., 1st degree for linear approximation)
%     p = polyfit(V, I, 1); % Fit a 1st-degree polynomial

%     % Generate fitted values starting from 0
%     V_fit = linspace(0, max(V), 100); % Generate voltage values for the fit, starting from 0
%     I_fit = polyval(p, V_fit); % Compute the fitted current values
%     I_fit(I_fit < 0) = 0;

%     % Plotting the data

%     hold on;
%     plot(V, I, 'o', 'Color', 'black', 'MarkerSize', 8, 'DisplayName', 'Data'); % Original data
%     plot(V_fit, I_fit, colors{i}, 'LineWidth', 1.5, 'DisplayName', 'Curve Fit'); % Fitted curve
%     % Configure axis and grid
%     xlim([0 max(V_fit)]); % Start x-axis from 0
%     ylim([0, max(I_fit)]); % Ensure y-axis also starts from 0
%     grid on;
% end

% legend('Experimetal Data', 'Yellow', '', 'Green', '', 'White', '','red');
% legend('Location', 'best', 'FontSize', 12);

% % Add labels and title
% title('I-V Characteristics', 'FontSize', 14);
% xlabel('Voltage (V)', 'FontSize', 12);
% ylabel('Current (mA)', 'FontSize', 12);


clc; clearvars; close all;

% Plot IV Characteristics for all colors at same plot
% Define the list of files to process
files = {'IV_yellow.txt', 'IV_green.txt', 'IV_white.txt', 'IV_red.txt'};

% Create color array for different plots with more appealing colors
colors = {[0.929, 0.694, 0.125],  % Golden yellow
         [0.180, 0.545, 0.341],   % Forest green
         [0.267, 0.447, 0.769],   % Royal blue (for white data)
         [0.850, 0.325, 0.098]};  % Coral red

% Create figure with white background
figure('Color', 'white');

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
    plot(V, I, 'o', 'Color', colors{i}, 'MarkerSize', 8, 'DisplayName', 'Data'); % Original data
    plot(V_fit, I_fit, 'Color', colors{i}, 'LineWidth', 2, 'DisplayName', 'Curve Fit'); % Fitted curve
    
    % Configure axis and grid
    xlim([0 max(V_fit)]); % Start x-axis from 0
    ylim([0, max(I_fit)]); % Ensure y-axis also starts from 0
    grid on;
end

% Set grid properties
set(gca, 'GridLineStyle', ':');
set(gca, 'GridAlpha', 0.25);

% Add legend with improved formatting
legend('Experimental Data', 'Yellow', '', 'Green', '', 'White', '', 'Red', ...
       'Location', 'best', ...
       'FontSize', 12, ...
       'Interpreter', 'latex');

% Add labels and title with LaTeX formatting
title('I-V Characteristics', ...
      'FontSize', 14, ...
      'FontWeight', 'bold', ...
      'Interpreter', 'latex');
xlabel('Voltage (V)', ...
       'FontSize', 12, ...
       'FontWeight', 'bold', ...
       'Interpreter', 'latex');
ylabel('Current (mA)', ...
       'FontSize', 12, ...
       'FontWeight', 'bold', ...
       'Interpreter', 'latex');

% Adjust figure size and appearance
set(gcf, 'Position', [100, 100, 800, 600]);
box on;
set(gca, 'LineWidth', 1.2);

 saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP9_BYAKC\reportprepare\IV_Characteristics.png');