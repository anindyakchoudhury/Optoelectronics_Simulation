clc;
clear;
close all;

%% Task 1

nf=1.5;
Is=1e-18; % A
Ninj=0.99;
Nr=0.98;
Ne=0.04;
T=300;
lambda0=550*1e-9;
q=1.6e-19;
kB=1.38e-23;

Vled=linspace(1,1.5,50);
I = Is*(exp((q*Vled)./(nf*kB*T))-1);

figure(1)
plot(Vled,I,'LineWidth',2)
xlabel('Voltage (V)')
ylabel('Current (A)')
title('IV Curve')
grid on


N0=Ninj*Nr*Ne;
h=6.626e-34;
c=3e8;
L = N0*I*(h*c/lambda0)/q;
figure(2)
plot(I,L,'LineWidth',2);
xlabel('Current (A)');
ylabel('Optical output Power (Watt)');
title('LI Curve');
grid on;

%% Task 2

alpha= 6.4e3; %cm^-1
R=0.37;
A=4/(1000^2); %m^2
Length=1e-7; %cm

Int0= L./A; % Watt/m^2
Int=Int0.*(1-R).*exp(-alpha*Length);

figure(3)
plot(Vled,Int0,Vled,Int,"LineWidth",2);
xlabel('Voltage of LED (V)');
ylabel('Intensity (Watt/m^2)');
legend('Input Intensity','Output Intensity')
grid on
title('Intensity of Coating VS LED Volatge');

%% Task 3

K=(5e-3)/500;
n=1;
Iph=K*Int;
Io= 25e-9;
Rs=0;
Rp=20*1000;

figure(4)

V_oc = zeros(1,length(Iph));
I_sc = zeros(1,length(Iph));
P_max = zeros(1,length(Iph));
FF = zeros(1,length(Iph));

V = 0:0.0001:0.4;
e = 1.6e-19;
kb  = 1.38e-23;

for i = 1:length(Iph)

    I_total = -Iph(i) + Io.*(exp((e.*V)./(n.*kb*T))-1);
    %himel did not add the Rsh component
    P = (-I_total).*V;

    V_oc(i) = V(find(I_total<=0,1,'last'));
    I_sc(i) = Iph(i);
    P_max(i) = max(P);
    FF(i) = P_max(i)/(V_oc(i)*I_sc(i));

    plot(V,I_total,'linewidth',2);
    hold on;

end
xlabel('Voltage of LED')
ylabel('Current of Solar Cell')
title("IV Curve of Solar Cell")

grid on


%%

figure(5)
plot(Int,V_oc,'linewidth',2);

xlabel('Solar Irradiation, I (Wm^{-2})')
ylabel('Open Circuit Voltage, V_{oc} (V)')
grid on;
title('V_{oc} vs Solar Irradiation of Solar Cell')

%%

figure(6)
plot(Int,I_sc*1e3,'linewidth',2);

xlabel('Solar Irradiation, I (Wm^{-2})')
ylabel('Short Circuit Current, I_{sc} (mA)')
grid on;
title('I_{sc} vs Solar Irradiation of Solar Cell')

%%

figure(7)
plot(Int,P_max*1e3,'o-','linewidth',2);
xlabel('Solar Irradiation, I (Wm^{-2})')
ylabel('Maximum Power Point, P_{max} (mW)')
grid on;
title('P_{max} vs Solar Irradiation of Solar Cell')



%%

figure(8)
plot(Int,FF,'linewidth',2);
xlabel('Solar Irradiation, I (Wm^{-2})')
ylabel('Fill Factor, FF)');
grid on;
title('FF vs Solar Irradiance of Solar Cell')




