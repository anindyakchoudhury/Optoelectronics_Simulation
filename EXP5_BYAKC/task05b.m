clc;
close all;
clear all;
set(0, 'DefaultAxesFontName', 'Times');
set(0, 'DefaultAxesFontSize', 15);

%% Constants

e   = 1.6e-19;
T   = 300;                  % K
Io  = 25e-9;                % A
kb  = 1.38e-23;
kbT = kb*T;                 % J
K   = 10e-3/500;
Irr = 500;                  % W/m^2
n   = 1;
V   = 0:0.0001:0.35;         % voltage
area= 1e-2*1e-2;            % 1cm X 1cm
Iph = K*Irr;

%% 

Rs = 0;
% Rp = inf;
% Rp = logspace(2,6,100);
Rp = [500, 1e3, 5e4, 5e5, 1e6];

V_oc = zeros(1,length(Rp));
V_m = zeros(1,length(Rp));
I_m = zeros(1,length(Rp));
I_sc = zeros(1,length(Rp));
P_max = zeros(1,length(Rp));
FF = zeros(1,length(Rp));
I_total = zeros(length(Rp),length(V));
P_total = zeros(length(Rp),length(V));

for i = 1:length(Rp)

    % minus current
    I = - Iph + Io*(exp(e*V/(n*kb*T))-1) + (V/Rp(i));
   
    V_oc(i) = V(find(I>=0,1,'first'));
    I_sc(i) = I(find(V<=0,1,'last'));


    I_total(i,:) = I;

    
    P_total(i,:) = (-I_total(i,:)).*V;
    P_max(i) = max(P_total(i,:));

    I_m(i)  = I_total(P_total(i,:)==P_max(1,i));
    V_m(i)  = V(P_total(i,:)==P_max(1,i));

    % % I_m*V_m
    FF(i)   = abs(P_max(1,i)/I_sc(1,i)/V_oc(1,i));

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




