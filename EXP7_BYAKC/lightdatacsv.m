% Define the data as cell arrays
light_sources = {
    '37 mW "Superbright" white LED', 0.20;
    '15 mW green laser (532 nm wavelength)', 8.4;
    '1 W high-output white LED', '25-120';
    'Kerosene lantern', 100;
    '40 W incandescent lamp at 230 volts', 325;
    '7 W high-output white LED', 450;
    '6 W COB filament LED lamp', 600;
    '18 W fluorescent lamp', 1250;
    '100 W incandescent lamp', 1750;
    '40 W fluorescent lamp', 2800;
    '35 W xenon bulb', '2200-3200';
    '100 W fluorescent lamp', 8000;
    '127 W low pressure sodium vapor lamp', 25000;
    '400 W metal-halide lamp', 40000
};

% Create headers
headers = {'Source', 'Luminous Flux (lumens)'};

% Combine headers and data
data = [headers; light_sources];

% Write to CSV file
filename = 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP7_BYAKC\light_sources_luminous_flux.csv';

% Open file for writing
fileID = fopen(filename, 'w');

% Write the data
for i = 1:size(data, 1)
    % Write each row
    fprintf(fileID, '%s,%s\n', char(data{i,1}), char(string(data{i,2})));
end

% Close the file
fclose(fileID);

% Display confirmation message
fprintf('Data has been successfully written to %s\n', filename);

% Optional: Read and display the contents to verify
fprintf('\nContents of the CSV file:\n');
type(filename);