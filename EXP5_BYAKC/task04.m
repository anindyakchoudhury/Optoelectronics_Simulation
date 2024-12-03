clc;
close all;
clearvars;

set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultAxesFontSize', 15);
%% initial

% Fundamental physical constants
e   = 1.6e-19;                      % Elementary charge in Coulombs
Ts   = [15, 20, 25, 30, 35, 40]+273;  % Temperature range in Kelvin (converting from Celsius)
Io  = 25e-9;                        % Reference reverse saturation current at 300K in Amperes
kb  = 1.38e-23;                     % Boltzmann constant in J/K

% Solar cell operating parameters
K   = 10e-3/500;                    % Photoelectric conversion coefficient (A/W)
Irr = 500;                          % Solar irradiance in W/m²
n   = 1;                            % Ideality factor (ideal diode)
V   = 0:0.001:0.4;                 % Voltage array from 0 to 0.4V in 1mV steps
area= 1e-2*1e-2;                    % Solar cell area (1cm x 1cm) in m²
Iph = K*Irr;                        % Photogenerated current (A)

% Silicon bandgap parameters for temperature dependence
Eg0 = 1.17;                         % Silicon bandgap energy at 0K in eV
a = 4.73e-4;                        % Varshni coefficient alpha in eV/K
b = 636;                            % Varshni coefficient beta in K

% Temperature-dependent bandgap energy using Varshni's equation
% This equation models how silicon's bandgap decreases with increasing temperature
% T^2 dependence in numerator and (T+b) in denominator capture the physical behavior
Eg = @(T) (Eg0-(a*T.^2)./(T+b))*e; % Converting eV to Joules by multiplying with e

% Temperature-dependent saturation current
% Models how reverse saturation current increases with temperature due to:
% 1. T^3 term from carrier density dependence
% 2. Exponential term from bandgap narrowing effect
% Normalized to reference temperature of 300K
Is = @(T) Io*(T/300).^3.*exp(-(  Eg(T)./(kb*T)  -  Eg(300)/(kb*300) ));

%% I-V Characteristics

figure(1)
% V_oc = zeros(1,length(n));
% I_sc = zeros(1,length(n));
% P_max = zeros(1,length(n));
% R_opt = zeros(1,length(n));

for T = Ts

     I_total = -Iph + Is(T).*(exp((e.*V)./(n.*kb*T))-1);
%     P = (-I_total).*V;
%
%     V_oc(i) = V(find(I_total<=0,1,'last'));
%     I_sc(i) = -Iph;
%     P_max(i) = max(P);
%     R_opt(i) = abs(V(P==P_max(i))/I_total(P==P_max(i)));

    plot(V,I_total*1e3,'linewidth',2,"DisplayName",sprintf("T = %d °C", T-273));
    hold on;

end

xlabel('Voltage, V (V)')
ylabel('Current, I (mA)')
axis tight
grid minor;
title("I-V Characteristics for various Temparature")

ylim([-10 0])
legend('Location', 'best');
legend box off
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP5_BYAKC\reportprepare\task4_IV_Curve_fortempVaries_IoVaries_SiSolarCell.png');
