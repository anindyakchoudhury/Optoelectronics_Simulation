% clc;
% clearvars;
% close all;
% % Plot Spectral analysis and find peak wavelength for Green LED

% % Define the list of files to process
% files = {'GREEN_9.txt', 'GREEN_10.txt', 'GREEN_11.txt', 'GREEN_12.txt', 'GREEN_13.txt'};

% % Create color array for different plots
% colors = {'b-', 'r-', 'g-', 'm-', 'y-'};

% % Initialize arrays to store peak data
% peak_intensity = zeros(1, length(files));
% peak_wavelength = zeros(1, length(files));
% linewidth = zeros(1, length(files));

% % Create the figure
% figure;
% hold on;  % Enable plotting multiple datasets

% % Loop through each file
% for i = 1:length(files)
%     % Read the data from file and skip the first 13 lines of comments
%     data = readmatrix(files{i}, 'NumHeaderLines', 13);

%     % Store wavelengths and intensities in separate arrays
%     lambda = data(:,1);
%     Intensity = data(:,2);

%     % Find the peak intensity and corresponding wavelength
%     [peak_intensity(i), peak_idx] = max(Intensity);
%     peak_wavelength(i) = lambda(peak_idx);

%     % Calculate the full-width at half-maximum (FWHM)
%     half_max = peak_intensity(i) / 2;
%     left_idx = find(Intensity >= half_max, 1, 'first');
%     right_idx = find(Intensity >= half_max, 1, 'last');
%     linewidth(i) = lambda(right_idx) - lambda(left_idx);

%     % Plot the data with different colors
%     plot(lambda, Intensity, colors{i}, 'LineWidth', 1.5);
% end

% % Add formatting
% grid on;
% xlabel('Wavelength (nm)');
% ylabel('Relative Intensity');
% title('Spectral Analysis of Green LED');

% % Add some formatting to make the plot more readable
% set(gca, 'FontSize', 12);
% xlim([450 700]);

% hold off;  % Release the hold on the figure

% % Save the peak data in a MATLAB data file
% save('peak_data_green.mat', 'peak_intensity', 'peak_wavelength', 'linewidth');

clc; clearvars; close all;

% Plot Spectral analysis and find peak wavelength for Green LED
% Define the list of files to process
files = {'GREEN_9.txt', 'GREEN_10.txt', 'GREEN_11.txt', 'GREEN_12.txt', 'GREEN_13.txt'};

% Create modern color array for different plots using RGB values
colors = {[0.267, 0.447, 0.769],  % Royal blue
         [0.850, 0.325, 0.098],   % Coral red
         [0.180, 0.545, 0.341],   % Forest green
         [0.494, 0.184, 0.556],   % Deep purple
         [0.929, 0.694, 0.125]};  % Golden yellow

% Initialize arrays to store peak data
peak_intensity = zeros(1, length(files));
peak_wavelength = zeros(1, length(files));
linewidth = zeros(1, length(files));

% Create figure with white background
figure('Color', 'white');
hold on;

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
    plot(lambda, Intensity, 'Color', colors{i}, 'LineWidth', 2, ...
         'DisplayName', sprintf('Green LED at %dV', i+8));
end

% Customize grid appearance
grid on;
set(gca, 'GridLineStyle', ':');
set(gca, 'GridAlpha', 0.25);
set(gca, 'LineWidth', 1.2);

% Add labels and title with LaTeX formatting
xlabel('Wavelength (nm)', ...
       'FontSize', 12, ...
       'FontWeight', 'bold', ...
       'Interpreter', 'latex');
ylabel('Relative Intensity', ...
       'FontSize', 12, ...
       'FontWeight', 'bold', ...
       'Interpreter', 'latex');
title('Spectral Analysis of Green LED', ...
      'FontSize', 14, ...
      'FontWeight', 'bold', ...
      'Interpreter', 'latex');

% Customize plot appearance
set(gca, 'FontSize', 12);
xlim([450 700]);

% Add legend with improved formatting
legend('Location', 'northeast', ...
       'FontSize', 10, ...
       'Interpreter', 'latex', ...
       'Box', 'off');

% Adjust figure size for better proportions
set(gcf, 'Position', [100, 100, 800, 600]);
box on;

hold off;

% Save the peak data in a MATLAB data file
save('peak_data_green.mat', 'peak_intensity', 'peak_wavelength', 'linewidth');

saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP9_BYAKC\reportprepare\Spectra_green.png');