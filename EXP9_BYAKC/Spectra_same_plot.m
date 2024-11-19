% clc;
% clearvars;
% close all;

% % Define the list of files to process
% files = {'GREEN_12.txt', 'YELLOW_12.txt', 'WHITE_13.txt', 'RED_12.txt'};

% % Create color array for different plots
% colors = {'g-', 'm-', 'b-', 'r-'};

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

%     % Plot the data with different colors
%     plot(lambda, Intensity, colors{i}, 'LineWidth', 1.5);
% end

% % Add formatting
% grid on;
% xlabel('Wavelength (nm)');
% ylabel('Relative Intensity');
% title('Spectra of different LEDs');

% % Create legend
% legend('Green', 'Yellow', 'White', 'Red');
% hold off;  % Release the hold on the 


clc; clearvars; close all;

% Define the list of files to process
files = {'GREEN_12.txt', 'YELLOW_12.txt', 'WHITE_13.txt', 'RED_12.txt'};

% Create modern color array for different plots using RGB values
colors = {[0.180, 0.545, 0.341],   % Forest green
         [0.929, 0.694, 0.125],    % Golden yellow
         [0.267, 0.447, 0.769],    % Royal blue (for white)
         [0.850, 0.325, 0.098]};   % Coral red

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
    
    % Plot the data with different colors
    plot(lambda, Intensity, 'Color', colors{i}, 'LineWidth', 2, ...
         'DisplayName', strrep(files{i}(1:end-7), '_', ' '));
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
title('Spectra of Different LEDs', ...
      'FontSize', 14, ...
      'FontWeight', 'bold', ...
      'Interpreter', 'latex');

% Customize plot appearance
set(gca, 'FontSize', 12);

% Add legend with improved formatting
legend('Location', 'northeast', ...
       'FontSize', 10, ...
       'Interpreter', 'latex', ...
       'Box', 'off');

% Adjust figure size for better proportions
set(gcf, 'Position', [100, 100, 800, 600]);
box on;

hold off;

saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP9_BYAKC\reportprepare\Spectra_all.png');