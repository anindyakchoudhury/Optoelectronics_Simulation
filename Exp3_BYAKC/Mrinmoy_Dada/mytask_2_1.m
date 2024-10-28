clc;
clear all;
close all;


%% Choose data

i = 2;
switch (i)
    case 1 
        GaAs_Data()
        lamda0 = 860e-9;
    case 2 
        GaN_Data()
        lamda0 = 360e-9;
end


% SI unit
h = 6.626e-34;
h_cut = h/(2*pi);
c = 3e8;

k_B = 1.38e-23;

%% injection efficiency
Nin = (Dn*npo/Ln)/((Dn*npo/Ln)+(Dp*pno/Lp)) %injection effiiciency


%% radiative recombination efficiency

sr = 1e-14;


NT = 1e13;
Vth = ((3*k_B*T)/mr)^(.5)*1e2;
tau_nr = (sr*Vth*NT)^-1;


Nr = 1/(1+(tau_n/tau_nr)) % radiative recombination efficiency



%%  extraction efficiency
nr = nr2/nr1;
crit_ang = asin(nr);
Ne = (1/4)*(nr2/nr1)^2*(1-((nr1-nr2)/(nr1+nr2))^2)



%% luminous efficiency

data = importdata('sensitivity_GaAs.txt');


lambda = data(5:end,1);
sensitivity = data(5:end,2);
emission = data(5:end,3);
figure;

plot(lambda,sensitivity)
xlabel('\lambda (nm)');
ylabel('Sensitivity');
title('Photopic sensitivity');
grid on;



% Calculating rsp
E = (h*c)./(lambda.*1e-9);
delE = (E-Eg);
tau_r = 1/(Br*(Nd+pno+deln)); 

Ef_n = k_B*T*log((Nd+deln)/ni);     % Ef_n-Ef_i
Ef_p = k_B*T*log((Na+deln)/ni);     % Ef_i-Ef_p

Efn_Efp = Ef_n + Ef_p;


R_sp = ((((2*mr)^1.5)/(2*pi^2*(h_cut^3)*tau_r)) ...
    *exp((Efn_Efp-Eg)/(k_B*T)).*(delE.^0.5).*exp(-delE./(k_B*T)));

%SI to 1/s. 1/eV . 1/cm3 unit
R_sp_cgs = R_sp*q/100^3;

V = sum(sensitivity.*R_sp);
P = sum(R_sp);
Nl = V/P

%% Final efficiency
% Excluding NL
N0 = Nin*Nr*Ne



%% %output optical power (L) as a function of forward current (I) 

I = linspace(0,100,100); %mA


L = N0*I*(h*c/lamda0)/q; %mW

figure
plot(I,L, 'LineWidth',2);
xlabel('I (mA)');
ylabel('P_0 (mW)');
title('Optical output power for GaN');
grid on;

