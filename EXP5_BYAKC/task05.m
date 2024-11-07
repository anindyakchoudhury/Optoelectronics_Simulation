clc;
close all;
clear;

set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultAxesFontSize', 15);
%% initial

e   = 1.6e-19;
T   = 300;                  % K
Io  = 25e-9;                % A
kb  = 1.38e-23;
kbT = kb*T;                 % J
K   = 10e-3/500;
Irr = 500;                  % W/m^2
n   = 1;
V   = 0:0.01:0.4;           % voltage
area= 1e-2*1e-2;            % 1cm X 1cm
Iph = K*Irr;

%% 

Rs = [0 10 50 100 1000 10000];
% Rs = logspace(-3,3,100);

% Rs = 1;
Rp = inf;

V_oc = zeros(1,length(Rs));
V_m = zeros(1,length(Rs));
I_m = zeros(1,length(Rs));
I_sc = zeros(1,length(Rs));
P_max = zeros(1,length(Rs));
FF = zeros(1,length(Rs));

I_total = zeros(length(Rs),length(V));
P_total = zeros(length(Rs),length(V));

for i = 1:length(Rs)
    V   = 0:0.01:0.4; 
    
    I =  Iph - Io*(exp(e*(V)/(n*kb*T))-1);
    V = V - I*Rs(i);



    %By definition I is negative as it is going out
    I = -I;
    I_total(i,:) = I;

    V_oc(i) = V(find(I<=0,1,'last'));
    I_sc(i) = I(1);


    P_total(i,:) = (-I_total(i,:)).*V;
    P_max(i) = max(P_total(i,:));
    I_m(i)  = I_total(P_total(i,:)==P_max(1,i));
    V_m(i)  = V(P_total(i,:)==P_max(1,i));

%   % I_m*V_m
    FF(i)   = abs(P_max(1,i)/I_sc(1,i)/V_oc(1,i));
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

