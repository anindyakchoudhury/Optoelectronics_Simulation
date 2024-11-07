clc;
clear;
close all;

set(0, 'DefaultAxesFontName', 'Arial');
set(0, 'DefaultAxesFontSize', 15);
%% 
e   = 1.6e-19;
T   = 300;                              % K
Io  = 25e-9;                            % A
kb  = 1.38e-23;
K   = 10e-3/500;
Irr = 500;                              % W/m^2

n   = linspace(1,2.5,4);                % ideality factor
V   = 0:0.0001:1;                      % voltage

Iph = K*Irr;

%% I-V Characteristics

figure(1)
V_oc = zeros(1,length(n)); % Initialization
I_sc = zeros(1,length(n));
P_max = zeros(1,length(n));
R_opt = zeros(1,length(n));
FF = zeros(1,length(n));

for i = 1:length(n)
    
    I_total = -Iph + Io.*(exp((e.*V)./(n(i).*kb*T))-1);
    P = (-I_total).*V;

    V_oc(i) = V(find(I_total<=0,1,'last'));
    I_sc(i) = Iph;

    P_max(i) = max(P);

    R_opt(i) = abs(V(P==P_max(i))/I_total(P==P_max(i))); %V/I at Pmax
    FF(i) = P_max(i)/(V_oc(i)*I_sc(i));

    plot(V,I_total*1e3,'linewidth',2);
    hold on;

end

xlabel('Voltage, V (V)')
ylabel('Current, I_{total} (mA)')
grid minor;
title("I-V Characteristics for various Ideality factor")

ylim([-10 0]);
legend("n ="+num2str(n(:)),"Location","best")

legend box off
%% Voc vs n

figure(2)
plot(n,V_oc,'linewidth',2);

xlabel('Ideality Factor, n')
ylabel('V_{oc} (V)')
grid minor;
title("V_{oc} vs Ideality Factor")

%% Isc vs n

figure(3)
plot(n,-I_sc*1e3,'linewidth',2);

xlabel('Ideality Factor, n')
ylabel('I_{sc} (mA)')
grid minor;
title("I_{sc} vs Ideality Factor")

%% Pmax vs n

figure(4)
plot(n,P_max*1e3,'linewidth',2);
hold on;

xlabel('Ideality Factor, n')
ylabel('P_{max} (mW)')
grid minor;
title("P_{max} vs Ideality Factor");
%% Ropt vs n

figure(5)
plot(n,R_opt,'linewidth',2);
xlabel('Ideality Factor, n')
ylabel('Optimum Load Resistance, R_{opt} (\Omega)')
grid minor;
title("Optimum Load Resistance vs Ideality Factor of Si Solar Cell")
%% FF vs n

figure(6)
plot(n,FF,'linewidth',2);
xlabel('Ideality Factor, n')
ylabel('Fill Factor, FF')
grid minor;
title("Fill factor vs Ideality Factor of Si Solar Cell")
