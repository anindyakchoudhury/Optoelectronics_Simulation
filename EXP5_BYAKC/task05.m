clc;
close all;
clearvars;

set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultAxesFontSize', 15);
%% Constants

% Fundamental physical constants and device parameters for solar cell modeling
e   = 1.6e-19;    % Elementary charge in Coulombs - this represents the charge of a single electron, a fundamental constant in semiconductor physics
T   = 300;        % Operating temperature in Kelvin (approximately room temperature at 27°C)
Io  = 25e-9;      % Reverse saturation current in Amperes - represents the small current that flows through the diode when reverse biased
kb  = 1.38e-23;   % Boltzmann constant in J/K - relates particle energy to temperature
kbT = kb*T;       % Thermal energy in Joules - product of Boltzmann constant and temperature, represents average thermal energy of particles

% Solar cell operating conditions and conversion parameters
K   = 10e-3/500;  % Photoelectric conversion coefficient (A/W) - represents how efficiently the cell converts light to current
Irr = 500;        % Solar irradiance in W/m² - represents the incoming solar power per unit area

% Device characteristics and simulation parameters
n   = 1;          % Ideality factor of the diode - indicates how closely the diode follows ideal behavior (1 is ideal)
V   = 0:0.01:0.4; % Voltage array from 0 to 0.4V in 10mV steps - defines points where I-V curve will be calculated
area= 1e-2*1e-2;  % Active area of the solar cell in m² (1cm x 1cm) - determines total current generation capability

% Calculate photogenerated current
Iph = K*Irr;      % Photogenerated current (A) = conversion efficiency * solar irradiance - the current produced by incident light

%%

% Define different series resistance values for comparison
Rs = [0 10 50 100 1000 10000];    % Array of series resistance values in ohms
% Rs = logspace(-3,3,100);        % Alternative logarithmic spacing (commented out)
% Rs = 1;                         % Single resistance value (commented out)
Rp = inf;                         % Infinite shunt resistance - assumes ideal case with no parallel leakage

% Initialize arrays to store calculated parameters for each series resistance value
V_oc = zeros(1,length(Rs));       % Open circuit voltage array
V_m = zeros(1,length(Rs));        % Voltage at maximum power point array
I_m = zeros(1,length(Rs));        % Current at maximum power point array
I_sc = zeros(1,length(Rs));       % Short circuit current array
P_max = zeros(1,length(Rs));      % Maximum power array
FF = zeros(1,length(Rs));         % Fill factor array
I_total = zeros(length(Rs),length(V));    % Matrix to store I-V curves for each Rs
P_total = zeros(length(Rs),length(V));    % Matrix to store P-V curves for each Rs

% Loop through each series resistance value to calculate solar cell characteristics
for i = 1:length(Rs)
    V   = 0:0.01:0.4;            % Reset voltage array for each iteration

    % Calculate ideal solar cell current without series resistance
    % Using the ideal diode equation with photogenerated current
    I =  Iph - Io*(exp(e*(V)/(n*kb*T))-1);

    % Account for voltage drop across series resistance
    V = V - I*Rs(i);             % Adjust voltage by subtracting IR drop

    % Convert current direction to conventional flow (negative = current out)
    I = -I;
    I_total(i,:) = I;            % Store current values for this Rs

    % Find key solar cell parameters
    V_oc(i) = V(find(I<=0,1,'last'));     % Open circuit voltage
    I_sc(i) = I(1);                       % Short circuit current (at V=0)

    % Calculate power characteristics
    P_total(i,:) = (-I_total(i,:)).*V;    % Power at each voltage point
    P_max(i) = max(P_total(i,:));         % Maximum power point

    % Find current and voltage at maximum power point
    I_m(i)  = I_total(P_total(i,:)==P_max(1,i));
    V_m(i)  = V(P_total(i,:)==P_max(1,i));

    % Calculate fill factor (measure of solar cell quality)
    FF(i)   = abs(P_max(1,i)/I_sc(1,i)/V_oc(1,i));

    % Plot I-V curve for this series resistance value
    % Current is multiplied by 1e3 to convert from A to mA
    plot(V,I_total(i,:)*1e3,'linewidth',2,'DisplayName',sprintf("R_s = %d ohm", Rs(i)));
    hold on;
end

xlabel('Voltage, V (V)')
ylabel('Current, I_{total} (mA)')
axis tight
grid minor;
title("I-V Characteristics of given Si Solar Cell");
ylim([-12,0]);
xlim([0,0.35]);

legend('Location', 'best');
legend box off;
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP5_BYAKC\reportprepare\task5_IVCharacteristics_Varying_Rs_SiSolarCell.png');

%%

figure(2)
semilogx(Rs,FF,'linewidth',2)
% semilogx(Rs,I_sc,'linewidth',2)
% semilogx(Rs,V_oc,'linewidth',2)
% semilogx(Rs,P_max,'linewidth',2)

xlabel('Series Resistance, R_s (\Omega)')
ylabel('Fill factor, FF')
axis tight
grid minor;
title("Fill Factor vs Series Resistance for Si Solar Cell");
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP5_BYAKC\reportprepare\task5_FillFactorvsRs_SiSolarCell.png');


%% Extra
%{
I_total = [I11 I12 I13 I14 I15]  <- Current values for first resistance
          [I21 I22 I23 I24 I25]  <- Current values for second resistance
          [I31 I32 I33 I34 I35]  <- Current values for third resistance

%}