clc;
clearvars;
close all;

set(0, 'DefaultAxesFontName', 'Times');
set(0, 'DefaultAxesFontSize', 15);
%% Parameters
e = 1.6e-19;          % Elementary charge (C)
T = 300;              % Operating temperature (K)
Io = 25e-9;          % Dark saturation current (A)
kb = 1.38e-23;       % Boltzmann constant (J/K)

% Define solar cell characteristics
K = 10e-3/500;       % Conversion factor relating irradiance to photocurrent
Irr = [500 600 700 800 1000];    % Different irradiance levels (W/m²)
n = 1;               % Ideality factor for ideal diode behavior
V = 0:0.0001:0.4;    % Voltage range for analysis
area = 1e-2*1e-2;    % Cell area (m²)
Iph = K*Irr;         % Photocurrent for each irradiance level
%% I-V Characteristics

figure(1)
% Initialize arrays to store key parameters for each irradiance level
V_oc = zeros(1,length(Iph));     % Open circuit voltage
I_sc = zeros(1,length(Iph));     % Short circuit current
P_max = zeros(1,length(Iph));    % Maximum power
R_opt = zeros(1,length(Iph));    % Optimal load resistance
FF = zeros(1,length(Iph));       % Fill factor

for i = 1:length(Iph)

    I_total = -Iph(i) + Io.*(exp((e.*V)./(n.*kb*T))-1);
    P = (-I_total).*V;

    V_oc(i) = V(find(I_total<=0,1,'last'));
    I_sc(i) = Iph(i);
    P_max(i) = max(P);
     % Calculate optimal load resistance at maximum power point
    R_opt(i) = abs(V(P==P_max(i))/I_total(P==P_max(i)));

    FF(i) = P_max(i)/(V_oc(i)*I_sc(i));
    % Plot I-V curve for this irradiance
    plot(V,I_total*1e3,'linewidth',2);
    hold on;

end

xlabel('Voltage, V (V)');
ylabel('Current, I_{tot} (mA)');
title("I-V Characteristics for various Irradiation");
ylim([-22 5]);
legend(num2str(Irr(:))+ " Wm^{-2}","Location","best");
legend box off;
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP5_BYAKC\reportprepare\task2_IV_Charac_various_irridation_SiSolarCell.png');
%% Voc vs n

figure(2)
plot(Irr,V_oc,'linewidth',2);

xlabel('Solar Irradiation, I (Wm^{-2})')
ylabel('Open Circuit Voltage, V_{oc} (V)')
% grid minor;
title("V_{oc} vs Solar Irradiation")
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP5_BYAKC\reportprepare\task2_VocvsSolar_Irridance_SiSolarCell.png');

%% Isc vs n

figure(3)
plot(Irr,-I_sc*1e3,'linewidth',2);

xlabel('Solar Irradiation, I (Wm^{-2})')
ylabel('Short Circuit Current, I_{sc} (mA)')
% grid minor;
title("I_{sc} vs Solar Irradiation of Si Solar Cell")
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP5_BYAKC\reportprepare\task2_IscvsSolar_Irridance_SiSolarCell.png');
%%

figure(4)
plot(Irr,P_max*1e3,'^-','linewidth',2);

xlabel('Solar Irradiation, I (Wm^{-2})')
ylabel('P_{max} (mW)')
% grid minor;
title("P_{max} vs Solar Irradiation of Si Solar Cell")
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP5_BYAKC\reportprepare\task2_PmaxvsSolar_Irridance_SiSolarCell.png');

% Calculate deviation of power from linearity
p_new = zeros(1,length(Irr));
for j = 1:length(Irr)
    % Create arrays for interpolation
    p_array = linspace(P_max(1),P_max(end),100001);
    I_array = linspace(Irr(1),Irr(end),100001);
    % Find interpolated power value
    p_new(j) =  p_array(I_array==Irr(j));
end
% Calculate normalized deviation from linear behavior
dev =  sqrt(sum(abs(p_new-P_max).^2));
deviation = dev/(P_max(end)-P_max(1));
fprintf("deviation = %.4f \n", deviation)

%%

figure(5)
plot(Irr,R_opt,'linewidth',2);
xlabel('Solar Irradiation, I (Wm^{-2})')
ylabel('Optimum R_{load} (\Omega)')
% grid minor;
title("R_{load} vs Solar Irradiance of Si Solar Cell")
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP5_BYAKC\reportprepare\task2_RloadvsSolar_Irridance.png');

%%
figure(6)
plot(Irr,FF,'linewidth',2);
xlabel('Solar Irradiation, I (Wm^{-2})')
ylabel('Fill Factor, FF)');
grid minor;
title("FF vs Solar Irradiance of Si Solar Cell")
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\EXP5_BYAKC\reportprepare\task2_FFvsSolar_Irridance_SiSolarCell.png');