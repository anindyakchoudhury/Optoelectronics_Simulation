% Clear workspace and prepare for fresh calculation
clc; clearvars; close all;

%% Set plotting parameters for professional figures
set(0, 'DefaultAxesFontName', 'Times');
set(0, 'DefaultAxesFontSize', 15);

%% Define solar cell parameters and physical constants
e = 1.6e-19;        % Elementary charge (C)
T = 300;            % Operating temperature (K)
Io = 25e-9;         % Dark saturation current (A) - represents recombination
Iph = 10e-3;        % Photogenerated current (A) - from incident light
kb = 1.38e-23;      % Boltzmann constant (J/K)
Irr = 500;          % Solar irradiance (W/m²)
n = 1;              % Ideality factor - indicates dominant recombination mechanism
V = 0:0.001:5;      % Voltage range for analysis (V)
area = 1e-2*1e-2;   % Solar cell area (m²), 1cm x 1cm

%% Calculate I-V Characteristics
% Solar cell equation: I = Iph - Io(exp(qV/nkT) - 1)
% Negative Iph because conventional current is opposite to photocurrent
I_total = -Iph + Io.*(exp((e*V)./(n*kb*T))-1);

% Plot I-V curve
figure(1)
plot(V,I_total*1e3,'linewidth',2)    % Current in mA for better visualization
xlabel('Voltage, V (V)')
ylabel('Current, I_{tot} (mA)')
title("I-V Characteristics")
ylim([-15,5]);

% Save the I-V characteristics plot
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP5_BYAKC\reportprepare\task1_IV_characteristics.png');

%% Calculate key solar cell parameters
% Find open circuit voltage (Voc) - voltage where current is zero
V_oc = V(find(I_total<=0,1,'last'));

% Short circuit current (Isc) - equals photogenerated current
I_sc = -Iph;

% Display Voc and Isc
fprintf("Voc = %.4f V \n", V_oc)
fprintf("Isc = %.4f A \n", I_sc)

%% Calculate and plot P-V Characteristics
% Recalculate for power analysis up to Voc
V = 0:0.01:V_oc;
I_total = -Iph + Io.*(exp((e.*V)./(n.*kb*T))-1);

% Calculate power: P = IV
P = (-I_total).*V;    % Negative I_total for power generation convention

% Plot P-V curve
figure(2);
plot(V,P*1e3,'linewidth',2)    % Power in mW for better visualization
xlabel('Voltage, V (V)')
ylabel('Output Power, P (mW)')
title("P-V Characteristics")

% Save the P-V characteristics plot
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP5_BYAKC\reportprepare\task1_PV_characteristics.png');

%% Calculate performance metrics
% Find maximum power point (MPP)
Pmax = max(P);           % Maximum power output
I_m = I_total(P==Pmax);  % Current at MPP
V_m = V(P==Pmax);        % Voltage at MPP

% Calculate Fill Factor (FF) - measure of solar cell quality
% FF = Pmax/(Voc*Isc) - ratio of actual to ideal maximum power
FF = abs(Pmax/I_sc/V_oc);

% Display results
fprintf("Pmax = %.4f W\n", Pmax)
fprintf("FF = %.4f \n", FF)


%{
find working
First, I_total<=0 creates a logical array of the same length as I_total.
For example, if I_total was [-5, -3, -1, 0.5, 2], it would create:
[true, true, true, false, false]
The find() function then returns the indices where this condition is true. In our example, it would return [1, 2, 3].
The arguments 1,'last' tell find to return only one value -
specifically the last index where the condition is true.
This is crucial because we want the last point where current is non-positive,
which represents where the I-V curve crosses the voltage axis.




The Photocurrent (-Iph):


When light hits the solar cell, it generates electron-hole pairs
These carriers create a current flowing in the negative direction (from n-type to p-type)
We put a minus sign before Iph because conventional current flows opposite to electron flow
This is like a current source pushing current out of the cell


The Diode Current (Io*(exp((eV)/(nkb*T))-1)):


This is the normal p-n junction diode current
It flows in the positive direction (from p-type to n-type)
It increases exponentially with voltage
This current opposes the photocurrent
We use a plus sign because it reduces the net output current

Think of it like two people pushing against each other:

The photocurrent is like a person pushing one way (negative direction)
The diode current is like another person pushing back (positive direction)
The total current (I_total) is the net result of these opposing forces
%}