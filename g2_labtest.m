clc; clearvars; close all;

%% IV and LI for LED


% Constants in SI unit
h     = 6.626e-34;
h_cut = h/(2*pi);
c     = 3e8;
k_B   = 1.38e-23;
T     = 300;
q     = 1.6e-19;
mo    = 9.1e-31;


%%
Nin = 0.99;
Nr = 0.98;
Ne = 0.04;
lamda0 = 550e-9;
nf = 1.5;

alpha = 6.4e3; %cm-1
R = 0.37;
A = 4/(1000*1000); %m^2
thickness = 1e-7; %cm

N0 = Nin*Nr*Ne;



%% Calculate I-V Characteristics
% Define voltage range for calculations
V = linspace(0,1.5,100);    % Voltage from 0 to 1.5


Is = 1e-18;    % Total saturation current (A)

% Calculate total current using diode equation
I = Is*exp(((q*V)./(nf*k_B*T))-1);    % Current (A)

figure(9)
% Plot I-V characteristics with current in microamps
plot(V,I/1e-6, "LineWidth",2);
xlabel('V (V)');
ylabel('I (\muA)');
title(sprintf('I-V characteristics for LED'));

% Set plot limits and add grid
ylim([0 10]);
grid on;

%% Output optical power (L) as a function of forward current (I)

L = N0*I*(h*c/lamda0)/q; %mW

figure(8)
plot(I,L, 'LineWidth',2);
xlabel('I (mA)');
ylabel('P_0 (mW)');
title(sprintf('Optical output power for LED'));
grid on;


%% Second Question

Intensity0 = L./A;
Intensity  = Intensity0 .*(1-R).*exp(-alpha.*thickness);
%basically Intensity = Irr
figure(7)
plot(V,Intensity0, V, Intensity, "LineWidth", 2);
xlabel("Voltage of LED (V)");
ylabel("Intensity(W/m^2)");
legend('Input Intensity', 'Output Intensity');
grid on
title("Intensity of Coating vs LED Voltage");

%% third question

e = 1.6e-19;        % Elementary charge (C)
T = 300;            % Operating temperature (K)
K = 10e-3/500;       % Conversion factor relating irradiance to photocurrent
Io = 25e-9;         % Dark saturation current (A) - represents recombination
Iph = K.*Intensity;        % Photogenerated current (A) - from incident light
kb = 1.38e-23;      % Boltzmann constant (J/K)
n = 1;              % Ideality factor - indicates dominant recombination mechanism
Rp = 20e3;
Irr = Intensity;
V = 0:0.0001:0.4;
%% I-V Characteristics

figure(1)
% Initialize arrays to store key parameters for each irradiance level
V_oc = zeros(1,length(Iph));     % Open circuit voltage
I_sc = zeros(1,length(Iph));     % Short circuit current
P_max = zeros(1,length(Iph));    % Maximum power
R_opt = zeros(1,length(Iph));    % Optimal load resistance
FF = zeros(1,length(Iph));       % Fill factor

for i = 1:length(Iph)

    I_total = -Iph(i) + Io.*(exp((e.*V)./(n.*kb*T))-1) + (V/Rp);
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

% % Calculate deviation of power from linearity
% p_new = zeros(1,length(Irr));
% for j = 1:length(Irr)
%     % Create arrays for interpolation
%     p_array = linspace(P_max(1),P_max(end),100001);
%     I_array = linspace(Irr(1),Irr(end),100001);
%     % Find interpolated power value
%     p_new(j) =  p_array(I_array==Irr(j));
% end
% % Calculate normalized deviation from linear behavior
% dev =  sqrt(sum(abs(p_new-P_max).^2));
% deviation = dev/(P_max(end)-P_max(1));
% fprintf("deviation = %.4f \n", deviation)

%%

figure(5)
plot(Irr,R_opt,'linewidth',2);
xlabel('Solar Irradiation, I (Wm^{-2})')
ylabel('Optimum R_{load} (\Omega)')
% grid minor;
title("R_{load} vs Solar Irradiance of Si Solar Cell")

%%
figure(6)
plot(Irr,FF,'linewidth',2);
xlabel('Solar Irradiation, I (Wm^{-2})')
ylabel('Fill Factor, FF)');
grid minor;
title("FF vs Solar Irradiance of Si Solar Cell")
