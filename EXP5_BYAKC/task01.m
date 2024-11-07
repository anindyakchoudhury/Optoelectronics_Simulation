clc;
clear;
close all;
%% 

set(0, 'DefaultAxesFontName', 'Times');
set(0, 'DefaultAxesFontSize', 15);
%% Inputs
e   = 1.6e-19;
T   = 300;          % K
Io  = 25e-9;        % A
Iph = 10e-3;        % A
kb  = 1.38e-23;

Irr = 500;          % W/m^2
n   = 1;            % ideality factor
V   = 0:0.001:5;  % voltage

area = 1e-2*1e-2;   %1cmx1cm

%% I-V Characteristics of the solar cell

I_total= -Iph + Io.*(exp((e*V)./(n*kb*T))-1);

figure(1)
plot(V,I_total*1e3,'linewidth',2)
xlabel('Voltage, V (V)')
ylabel('Current, I_{tot} (mA)')
% axis tight
% grid minor;
title("I-V Characteristics");
ylim([-15,5]);

% line([-0.05, V(end)], [0, 0], 'Color', [0,0,0],'linewidth',2);
% line([0, 0], [-10, 10], 'Color', [0,0,0],'linewidth',2);

%% Open ckt voltage and Short ckt current

V_oc = V(find(I_total<=0,1,'last'));
I_sc = -Iph;
fprintf("Voc = %.4f V \n", V_oc)
fprintf("Isc = %.4f A \n", I_sc)

%% P-V Characteristics of the Solar Cell

V = 0:0.01:V_oc;
I_total = -Iph + Io.*(exp((e.*V)./(n.*kb*T))-1);
P = (-I_total).*V;

figure(2); 
% plot(V,P/(Irr*area)*100,'linewidth',2)
plot(V,P*1e3,'linewidth',2)
% grid minor;
xlabel('Voltage, V (V)')
ylabel('Output Power, P (mW)')
title("P-V Characteristics")
%% 
Pmax = max(P);
I_m  = I_total(P==Pmax);
V_m  = V(P==Pmax);
% I_m*V_m
FF   = abs(Pmax/I_sc/V_oc);
fprintf("Pmax = %.4f W\n", Pmax)
fprintf("FF = %.4f \n", FF)

