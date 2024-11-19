clc;
clearvars;
close all;
% Plot Spectral analysis and find peak wavelength for Red LED

% Define the list of files to process
files = {'RED_9.txt', 'RED_10.txt', 'RED_11.txt', 'RED_12.txt', 'RED_13.txt'};

% Create color array for different plots
colors = {'b-', 'r-', 'g-', 'm-', 'y-'};

% Initialize arrays to store peak data
peak_intensity = zeros(1, length(files));
peak_wavelength = zeros(1, length(files));
linewidth = zeros(1, length(files));

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
    
    % Find the peak intensity and corresponding wavelength
    [peak_intensity(i), peak_idx] = max(Intensity);
    peak_wavelength(i) = lambda(peak_idx);

    % Calculate the full-width at half-maximum (FWHM)
    half_max = peak_intensity(i) / 2;
    left_idx = find(Intensity >= half_max, 1, 'first');
    right_idx = find(Intensity >= half_max, 1, 'last');
    linewidth(i) = lambda(right_idx) - lambda(left_idx);
    
    % Plot the data with different colors
    plot(lambda, Intensity, colors{i}, 'LineWidth', 1.5);
end

% Add formatting
grid on;
xlabel('Wavelength (nm)');
ylabel('Relative Intensity');
title('Spectral Analysis of Red LED');

% Add some formatting to make the plot more readable
set(gca, 'FontSize', 12);
xlim([550 800]);
ylim([0 3500]);

hold off;  % Release the hold on the figure

% Save the peak data in a MATLAB data file
save('peak_data_red.mat', 'peak_intensity', 'peak_wavelength', 'linewidth');