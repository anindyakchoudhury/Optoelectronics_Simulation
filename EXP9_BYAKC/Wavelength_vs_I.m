clc;
clearvars;
close all;

%% Yellow
% Read the data from the file
data = readmatrix('IV_yellow.txt', 'NumHeaderLines', 2);

% Extract voltage and current
V = data(:, 1)'; % Voltage 
I = data(:, 2)'; % Current

load("peak_data_yellow.mat");

figure(1)
plot(I, peak_wavelength, 'color', 'yellow', 'LineWidth', 2);
hold on

%% Green

% Read the data from the file
data = readmatrix('IV_green.txt', 'NumHeaderLines', 2);

% Extract voltage and current
V = data(:, 1)'; % Voltage 
I = data(:, 2)'; % Current

load("peak_data_green.mat");

plot(I, peak_wavelength, 'color', 'green', 'LineWidth', 2);
hold on

%% White
% Read the data from the file
data = readmatrix('IV_white.txt', 'NumHeaderLines', 2);

% Extract voltage and current
V = data(:, 1)'; % Voltage 
I = data(:, 2)'; % Current

load("peak_data_white.mat");

plot(I, peak_wavelength, 'color', 'cyan', 'LineWidth', 2);
hold on

%% Red
% Read the data from the file
data = readmatrix('IV_white.txt', 'NumHeaderLines', 2);

% Extract voltage and current
V = data(:, 1)'; % Voltage 
I = data(:, 2)'; % Current

load("peak_data_red.mat");

plot(I, peak_wavelength, 'color', 'red', 'LineWidth', 2);
hold off

%% formatting

grid on
legend('Yellow', 'Green', 'White', 'red');
legend('Location', 'best', 'FontSize', 12);

% Add labels and title
title('Peak Wavelength vs Current of LED', 'FontSize', 14);
xlabel('Current, I(mA)', 'FontSize', 12);
ylabel('Wavelength (nm)', 'FontSize', 12);

% Add some formatting to make the plot more readable
set(gca, 'FontSize', 12);
ylim([350 700]);