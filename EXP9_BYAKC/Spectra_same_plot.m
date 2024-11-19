clc;
clearvars;
close all;

% Define the list of files to process
files = {'GREEN_12.txt', 'YELLOW_12.txt', 'WHITE_13.txt', 'RED_12.txt'};

% Create color array for different plots
colors = {'g-', 'm-', 'b-', 'r-'};

% Create the figure
figure;
hold on;  % Enable plotting multiple datasets

% Loop through each file
for i = 1:length(files)
    % Read the data from file and skip the first 13 lines of comments
    data = readmatrix(files{i}, 'NumHeaderLines', 13);

    % Store wavelengths and intensities in separate arrays
    lambda = data(:,1);
    Intensity = data(:,2);

    % Plot the data with different colors
    plot(lambda, Intensity, colors{i}, 'LineWidth', 1.5);
end

% Add formatting
grid on;
xlabel('Wavelength (nm)');
ylabel('Relative Intensity');
title('Spectra of different LEDs');

% Create legend
legend('Green', 'Yellow', 'White', 'Red');
hold off;  % Release the hold on the 