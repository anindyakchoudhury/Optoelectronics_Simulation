clc;
clearvars;
close all;

% Constants in SI unit
h = 6.626e-34;
h_cut = h/(2*pi);
c = 3e8;
k_B = 1.38e-23;
T = 300;
q = 1.6e-19;
mo = 9.1e-31;

%% Choose data
Task_no = 2;  % Task 1: GaAs, Task 2: GaN

switch (Task_no)
    case 1
        material = 'GaAs';
        % Mobility in cm2/Vs
        u_n = 8500;
        u_p = 400;

        % Doping concentrations in (cm-3)
        Na = 1e15;
        Nd = 5e17;

        ni = 1.79e6; % intrinsic carrier concentration (cm-3)

        % effective mass
        me = 0.067*mo;
        mh = 0.5*mo;

        % Refractive index
        nr1 = 3.68; %GaAs

        Eg = 1.43*q; % bandgap
        lamda0 = 860e-9; %Peak Wavelength from Exp1

    case 2
        material = 'GaN';
        % Mobility in cm2/Vs
        u_n = 1800;
        u_p = 30;

        % Doping concentrations in (cm-3)
        Na = 1e15;
        Nd = 1e18;

        ni = 1.9e-10; % intrinsic carrier concentration (cm-3)

        % effective mass
        me = 0.27*mo;
        mh = 0.8*mo;

        % Refractive index
        nr1 = 2.55; %GaN

        Eg = 3.4*q; %bandgap
        lamda0 = 360e-9; %Peak Wavelength from Exp1
end

deln = 1e17; % excess minority carrier concentration
A = 1*(1/10)^2;       % Cross section Area in cm2
mr = (me*mh)/(me+mh); % average effective mass


%% Injection efficiency
npo = ni^2/Na;
pno = ni^2/Nd;

% cm2/s
Dn = (k_B*T*u_n)/q;
Dp = (k_B*T*u_p)/q;
Br = 1e-10;

%tau_n means lifetime of minority electron in p-region
tau_n = 1/(Br*(Na+npo+deln));
tau_p = 1/(Br*(pno+Nd+deln));

Ln = (Dn*tau_n)^0.5;
Lp = (Dp*tau_p)^0.5;

Nin = (Dn*npo/Ln)/((Dn*npo/Ln)+(Dp*pno/Lp)); %injection effiiciency
fprintf('Injection efficiency is %0.5f \n',Nin)

%% radiative recombination efficiency
sr = 1e-15;
NT = 1e13; % Trap density (cm-3)
Vth = ((3*k_B*T)/mr)^(.5)*1e2;
tau_nr = (sr*Vth*NT)^-1;

Nr = 1/(1+(tau_n/tau_nr)); % radiative recombination efficiency
fprintf('Radiative recombination efficiency is %0.5f \n',Nr)

%%  Extraction efficiency

% Refractive index -> nr1-material
nr2 = 1;   %Air

Ne = (1/4)*(nr2/nr1)^2*(1-((nr1-nr2)/(nr1+nr2))^2);
fprintf('Extraction efficiency is %0.5f \n',Ne)

%% luminous efficiency

data = importdata('sensitivity_GaAs.txt');

lambda = data(5:end,1);
sensitivity = data(5:end,2);
emission = data(5:end,3);

% figure;
% plot(lambda,sensitivity)
% xlabel('\lambda (nm)');
% ylabel('Sensitivity');
% title('Photopic sensitivity');
% grid on;

% Calculating Rsp
E = (h*c)./(lambda.*1e-9);
delE = (E-Eg);
tau_r = 1/(Br*(Nd+pno+deln));

Ef_n = k_B*T*log((Nd+deln)/ni);     % Ef_n-Ef_i
Ef_p = k_B*T*log((Na+deln)/ni);     % Ef_i-Ef_p

Efn_Efp = Ef_n + Ef_p;

R_sp = ((((2*mr)^1.5)/(2*pi^2*(h_cut^3)*tau_r)) ...
    *exp((Efn_Efp-Eg)/(k_B*T)).*(delE.^0.5).*exp(-delE./(k_B*T)));

V = sum(sensitivity.*R_sp);
P = sum(R_sp);
Nl = V/P;
fprintf('luminous efficiency is %0.5f \n \n',Nl)

%% Final efficiency
% Excluding NL (as Nl very low)
N0 = Nin*Nr*Ne;
fprintf('External conversion efficiency is %0.5f \n',N0)

%% Output optical power (L) as a function of forward current (I)

I = linspace(0,100,100); %mA
L = N0*I*(h*c/lamda0)/q; %mW

figure
plot(I,L, 'LineWidth',2);
xlabel('I (mA)');
ylabel('P_0 (mW)');
title(sprintf('Optical output power for %s LED',material));
grid on;


% Save the plot as a PNG file
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\Exp3_BYAKC\reportprepare\partB_task2.png');