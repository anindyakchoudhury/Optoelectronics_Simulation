clc;
clear;
close all;

set(0, 'DefaultAxesFontName', 'Times');
set(0, 'DefaultAxesFontSize', 15);
%% Parameters
e   = 1.6e-19;
T   = 300;                              % K
Io  = 25e-9;                            % A
kb  = 1.38e-23;

K   = 10e-3/500;
Irr = [500 600 700 800 1000];           % W/m^2
n   = 1;                                % ideality factor
V   = 0:0.0001:0.4;                    % voltage
area= 1e-2*1e-2;                        % 1cm X 1cm
Iph = K*Irr;

%% I-V Characteristics

figure(1)
V_oc = zeros(1,length(Iph)); % Initializations
I_sc = zeros(1,length(Iph));
P_max = zeros(1,length(Iph));
R_opt = zeros(1,length(Iph));

FF = zeros(1,length(Iph));

for i = 1:length(Iph)
    
    I_total = -Iph(i) + Io.*(exp((e.*V)./(n.*kb*T))-1);
    P = (-I_total).*V;

    V_oc(i) = V(find(I_total<=0,1,'last'));
    I_sc(i) = Iph(i);
    P_max(i) = max(P);
    R_opt(i) = abs(V(P==P_max(i))/I_total(P==P_max(i)));

    FF(i) = P_max(i)/(V_oc(i)*I_sc(i));

    plot(V,I_total*1e3,'linewidth',2);
    hold on;

end

xlabel('Voltage, V (V)');
ylabel('Current, I_{tot} (mA)');
title("I-V Characteristics for various Irradiation");
ylim([-22 5]);
legend(num2str(Irr(:))+ " Wm^{-2}","Location","best");
legend box off;
%% Voc vs n

figure(2)
plot(Irr,V_oc,'linewidth',2);

xlabel('Solar Irradiation, I (Wm^{-2})')
ylabel('Open Circuit Voltage, V_{oc} (V)')
% grid minor;
title("V_{oc} vs Solar Irradiation")

%% Isc vs n

figure(3)
plot(Irr,-I_sc*1e3,'linewidth',2);

xlabel('Solar Irradiation, I (Wm^{-2})')
ylabel('Short Circuit Current, I_{sc} (mA)')
% grid minor;
title("I_{sc} vs Solar Irradiation of Si Solar Cell")

%% 

figure(4)
plot(Irr,P_max*1e3,'^-','linewidth',2);

xlabel('Solar Irradiation, I (Wm^{-2})')
ylabel('P_{max} (mW)')
% grid minor;
title("P_{max} vs Solar Irradiation of Si Solar Cell")

p_new = zeros(1,length(Irr));
for j = 1:length(Irr)
    p_array = linspace(P_max(1),P_max(end),100001);
    I_array = linspace(Irr(1),Irr(end),100001);
    p_new(j) =  p_array(I_array==Irr(j));
end

dev =  sqrt(sum(abs(p_new-P_max).^2));
deviation = dev/(P_max(end)-P_max(1));
fprintf("deviation = %.4f \n", deviation)

%% 

figure(5)
plot(Irr,R_opt,'linewidth',2);
xlabel('Solar Irradiation, I (Wm^{-2})')
ylabel('Optimum R_{load} (\Omega)')
% grid minor;
title("R_{load} vs Solar Irradiance")


%%
figure(6)
plot(Irr,FF,'linewidth',2);
xlabel('Solar Irradiation, I (Wm^{-2})')
ylabel('Fill Factor, FF)');
grid minor;
title("FF vs Solar Irradiance of Si Solar Cell")





