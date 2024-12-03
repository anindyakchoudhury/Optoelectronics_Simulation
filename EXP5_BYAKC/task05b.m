clc;
close all;
clearvars;
set(0, 'DefaultAxesFontName', 'Times');
set(0, 'DefaultAxesFontSize', 15);

%% Constants

e   = 1.6e-19;                  % Elementary charge in Coulombs
T   = 300;                      % Temperature in Kelvin
Io  = 25e-9;                    % Reverse saturation current in Amperes
kb  = 1.38e-23;                 % Boltzmann constant in J/K
kbT = kb*T;                     % Thermal energy in Joules

K   = 10e-3/500;                % Photoelectric conversion coefficient (A/W)
Irr = 500;                      % Solar irradiance in W/m²

n   = 1;                        % Ideality factor of the diode
V   = 0:0.0001:0.35;           % Voltage array from 0 to 0.35V in steps of 0.1mV
area= 1e-2*1e-2;               % Solar cell area in m² (1cm x 1cm)

Iph = K*Irr;                    % Photogenerated current (A) = conversion efficiency * irradiance



%% Solar Cell Characteristics Analysis with Variable Shunt Resistance

Rs = 0;                          % Series resistance in ohms (set to 0)
% Rp = inf;                      % Infinite shunt resistance (commented out)
% Rp = logspace(2,6,100);        % Logarithmic array of Rp values (commented out)
Rp = [500, 1e3, 5e4, 5e5, 1e6];  % Array of shunt resistance values in ohms

% Initialize arrays to store calculated parameters for each Rp value
V_oc    = zeros(1,length(Rp));         % Open circuit voltage
V_m     = zeros(1,length(Rp));         % Voltage at maximum power point
I_m     = zeros(1,length(Rp));         % Current at maximum power point
I_sc    = zeros(1,length(Rp));         % Short circuit current
P_max   = zeros(1,length(Rp));         % Maximum power
FF      = zeros(1,length(Rp));         % Fill factor
I_total = zeros(length(Rp),length(V)); % Total current for each Rp
P_total = zeros(length(Rp),length(V)); % Total power for each Rp

% Loop through each shunt resistance value
for i = 1:length(Rp)
    % Calculate total current using solar cell equation
    % I = -Iph (photogenerated current) + diode current + shunt current
    I = - Iph + Io*(exp(e*V/(n*kb*T))-1) + (V/Rp(i));

    % Find open circuit voltage (voltage where current crosses zero)
    V_oc(i) = V(find(I>=0,1,'first'));

    % Find short circuit current (current at zero voltage)
    I_sc(i) = I(find(V<=0,1,'last'));

    % Store current and power values
    I_total(i,:) = I;
    P_total(i,:) = (-I_total(i,:)).*V;    % Power = voltage * current

    % Find maximum power point
    P_max(i) = max(P_total(i,:));

    % Find current and voltage at maximum power point
    I_m(i)  = I_total(P_total(i,:)==P_max(1,i));
    V_m(i)  = V(P_total(i,:)==P_max(1,i));

    % Calculate fill factor (ratio of max power to product of Voc and Isc)
    FF(i)   = abs(P_max(1,i)/I_sc(1,i)/V_oc(1,i));

    % Plot I-V curve (current in mA)
    plot(V,I_total(i,:)*1e3,'linewidth',2);
    hold on;
end

xlabel('Voltage, V (V)')
ylabel('Current, I_{total} (mA)')
axis tight
grid minor;
title("I-V Characteristics of given Si Solar Cell");
ylim([-12,0]);
xlim([0,0.35]);

legend("R_p = 500 \Omega","R_p = 1 k\Omega", "R_p = 50 k\Omega", "R_p = 500 k\Omega", "R_p = 1 M\Omega");
legend('Location', 'best');
legend box off;
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP5_BYAKC\reportprepare\task5_IVCharacteristics_Varying_Rp_SiSolarCell.png');
%% P-V

% i = 1;
% plot(V,P_total(i,:)/1e-3, 'linewidth',2);
% ylim([0, max(P_total(i,:)/1e-3)]);
% xlabel('Voltage, V (V)');
% ylabel('Power, P (mW)');
%
%
% grid minor;
% title("P-V curve for Si Solar Cell");

%%


figure(2)
semilogx(Rp,FF,'linewidth',2)
% semilogx(Rp,I_sc,'linewidth',2)
% semilogx(Rp,V_oc,'linewidth',2)
% semilogx(Rp,P_max,'linewidth',2)

xlabel('Shunt Resitance, R_p (\Omega)')
ylabel('Fill factor, FF')
axis tight
grid minor;
title("Fill Factor vs Shunt Resistance for Si Solar Cell");
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP5_BYAKC\reportprepare\task5_FillFactorvsRp_SiSolarCell.png');



%% Extra
% If I = [-2, -1, 0, 1, 2]
% Then I>=0 gives [0, 0, 1, 1, 1]
% find(I>=0,1,'first') returns 3
% If V = [0.1, 0.2, 0.3, 0.4, 0.5]
% Then V_oc would be 0.3


% If V = [-0.1, 0, 0.1, 0.2, 0.3]
% Then V<=0 gives [1, 1, 0, 0, 0]
% find(V<=0,1,'last') returns 2
% If I = [-5, -4, -3, -2, -1]
% Then I_sc would be -4

