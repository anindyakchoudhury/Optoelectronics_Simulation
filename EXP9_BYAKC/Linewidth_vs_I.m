% clc;
% clearvars;
% close all;

% %% Yellow
% % Read the data from the file
% data = readmatrix('IV_yellow.txt', 'NumHeaderLines', 2);

% % Extract voltage and current
% I = data(:, 2)'; % Current

% load("peak_data_yellow.mat");

% figure(1)
% plot(I, linewidth, 'color', 'yellow', 'LineWidth', 2);
% hold on

% %% Green

% % Read the data from the file
% data = readmatrix('IV_green.txt', 'NumHeaderLines', 2);

% % Extract voltage and current
% I = data(:, 2)'; % Current

% load("peak_data_green.mat");

% plot(I, linewidth, 'color', 'green', 'LineWidth', 2);
% hold on

% %% White
% % Read the data from the file
% data = readmatrix('IV_white.txt', 'NumHeaderLines', 2);

% % Extract voltage and current
% I = data(:, 2)'; % Current

% load("peak_data_white.mat");

% plot(I, linewidth, 'color', 'cyan', 'LineWidth', 2);
% hold on

% %% Red
% % Read the data from the file
% data = readmatrix('IV_white.txt', 'NumHeaderLines', 2);

% % Extract voltage and current
% V = data(:, 1)'; % Voltage 
% I = data(:, 2)'; % Current

% load("peak_data_red.mat");

% plot(I, linewidth, 'color', 'red', 'LineWidth', 2);
% hold off

% %% formatting

% grid on
% legend('Yellow', 'Green', 'White', 'red');
% legend('Location', 'best', 'FontSize', 12);

% % Add labels and title
% title('The linewidth (FWHM) vs Current', 'FontSize', 14);
% xlabel('Current, I(mA)', 'FontSize', 12);
% ylabel('linewidth (nm)', 'FontSize', 12);

% % Add some formatting to make the plot more readable
% set(gca, 'FontSize', 12);


clc; clearvars; close all;

%% Yellow
% Read the data from the file
data = readmatrix('IV_yellow.txt', 'NumHeaderLines', 2);

% Extract current
I = data(:, 2)'; % Current

load("peak_data_yellow.mat");

% Create figure with white background
figure('Color', 'white');
plot(I, linewidth, 'Color', [0.929, 0.694, 0.125], 'LineWidth', 2, ...
     'DisplayName', 'Yellow');
hold on

%% Green
% Read the data from the file
data = readmatrix('IV_green.txt', 'NumHeaderLines', 2);

% Extract current
I = data(:, 2)'; % Current

load("peak_data_green.mat");

plot(I, linewidth, 'Color', [0.180, 0.545, 0.341], 'LineWidth', 2, ...
     'DisplayName', 'Green');

%% White
% Read the data from the file
data = readmatrix('IV_white.txt', 'NumHeaderLines', 2);

% Extract current
I = data(:, 2)'; % Current

load("peak_data_white.mat");

plot(I, linewidth, 'Color', [0.267, 0.447, 0.769], 'LineWidth', 2, ...
     'DisplayName', 'White');

%% Red
% Read the data from the file
data = readmatrix('IV_white.txt', 'NumHeaderLines', 2);

% Extract voltage and current
V = data(:, 1)'; % Voltage
I = data(:, 2)'; % Current

load("peak_data_red.mat");

plot(I, linewidth, 'Color', [0.850, 0.325, 0.098], 'LineWidth', 2, ...
     'DisplayName', 'Red');

hold off

%% Formatting
% Customize grid appearance
grid on;
set(gca, 'GridLineStyle', ':');
set(gca, 'GridAlpha', 0.25);
set(gca, 'LineWidth', 1.2);

% Add legend with improved formatting
legend('Location', 'best', ...
       'FontSize', 10, ...
       'Interpreter', 'latex', ...
       'Box', 'off');

% Add labels and title with LaTeX formatting
xlabel('Current, $I$ (mA)', ...
       'FontSize', 12, ...
       'FontWeight', 'bold', ...
       'Interpreter', 'latex');
ylabel('Linewidth (nm)', ...
       'FontSize', 12, ...
       'FontWeight', 'bold', ...
       'Interpreter', 'latex');
title('The Linewidth (FWHM) vs Current', ...
      'FontSize', 14, ...
      'FontWeight', 'bold', ...
      'Interpreter', 'latex');

% Customize plot appearance
set(gca, 'FontSize', 12);

% Adjust figure size for better proportions
set(gcf, 'Position', [100, 100, 800, 600]);
box on;

saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP9_BYAKC\reportprepare\FWHMvsI.png');