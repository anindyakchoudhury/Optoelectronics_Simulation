clc;
clearvars;
close all;

%% Yellow
% Read the data from the file
data = readmatrix('IV_yellow.txt', 'NumHeaderLines', 2);

% Extract voltage and current
I = data(:, 2)'; % Current

load("peak_data_yellow.mat");

figure(1)
plot(I, linewidth, 'color', 'yellow', 'LineWidth', 2);
hold on

%% Green

% Read the data from the file
data = readmatrix('IV_green.txt', 'NumHeaderLines', 2);

% Extract voltage and current
I = data(:, 2)'; % Current

load("peak_data_green.mat");

plot(I, linewidth, 'color', 'green', 'LineWidth', 2);
hold on

%% White
% Read the data from the file
data = readmatrix('IV_white.txt', 'NumHeaderLines', 2);

% Extract voltage and current
I = data(:, 2)'; % Current

load("peak_data_white.mat");

plot(I, linewidth, 'color', 'cyan', 'LineWidth', 2);
hold on

%% Red
% Read the data from the file
data = readmatrix('IV_white.txt', 'NumHeaderLines', 2);

% Extract voltage and current
V = data(:, 1)'; % Voltage 
I = data(:, 2)'; % Current

load("peak_data_red.mat");

plot(I, linewidth, 'color', 'red', 'LineWidth', 2);
hold off

%% formatting

grid on
legend('Yellow', 'Green', 'White', 'red');
legend('Location', 'best', 'FontSize', 12);

% Add labels and title
title('The linewidth (FWHM) vs Current', 'FontSize', 14);
xlabel('Current, I(mA)', 'FontSize', 12);
ylabel('linewidth (nm)', 'FontSize', 12);

% Add some formatting to make the plot more readable
set(gca, 'FontSize', 12);