clc;
close all;
clear;

set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultAxesFontSize', 15);
%% initial

e   = 1.6e-19;
Ts   = [15, 20, 25, 30, 35, 40]+273;      % K
Io  = 25e-9;              % A
kb  = 1.38e-23;
K   = 10e-3/500;
Irr = 500;                % W/m^2
n   = 1;
V   = 0:0.001:0.4;        % voltage
area= 1e-2*1e-2;          % 1cm X 1cm
Iph = K*Irr;

% For Si
Eg0 = 1.17;               % eV

% Vashni's constant
a = 4.73e-4;              % eV/K           
b = 636;                  % K

Eg = @(T) (Eg0-(a*T.^2)./(T+b))*e; %Varshni's equation
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
