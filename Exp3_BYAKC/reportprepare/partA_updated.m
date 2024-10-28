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

        Eg = 1.43*q; % bandgap

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

        Eg = 3.4*q; %bandgap
end

deln = 1e17; % excess minority carrier concentration
mr = (me*mh)/(me+mh); % average effective mass

npo = ni^2/Na;
pno = ni^2/Nd;
Br = 1e-10;

%tau_n means lifetime of minority electron in p-region
tau_n = 1/(Br*(Na+npo+deln));
tau_p = 1/(Br*(pno+Nd+deln));

%% Emission Spectra

E = linspace(Eg-0.3*q,Eg+q,1000);
lambda = (h*c)./E;
delE = (E-Eg);

%Recombination happens in p-GaAs region
tau_r = tau_p;

Ef_n = k_B*T*log((Nd+deln)/ni);     % Ef_n-Ef_i
Ef_p = k_B*T*log((Na+deln)/ni);     % Ef_i-Ef_p

% Efn_Efp = Ef_n + Ef_p;

R_sp = ((((2*mr)^1.5)/(2*pi^2*(h_cut^3)*tau_r)) ...
    *exp((Ef_n + Ef_p-Eg)/(k_B*T)).*(delE.^0.5).*exp(-delE./(k_B*T)));

%SI to 1/s. 1/eV . 1/cm3 unit
R_sp_cgs = R_sp*q/100^3;

figure();
subplot(211);
plot(lambda/1e-9,real(R_sp_cgs), 'LineWidth',2);
xlabel('\lambda (nm)');
ylabel('R_{sp} (1/s. 1/eV . 1/cm^3)');
title(sprintf('Emission Spectra of %s', material));
grid on;

subplot(212);
plot(E/q,real(R_sp_cgs), 'LineWidth',2);
xlabel('E (eV)');
ylabel('R_{sp} (1/s. 1/eV . 1/cm^3)');
title(sprintf('Emission Spectra of %s', material));
grid on;



%% Flux Calculation
% SI unit
% Vol = 0.5/1000^3;
% % phi = (Vol/(sqrt(2)*h_cut^3*tau_r))*((mr*k_B*T/pi)^1.5)*exp((Efn_Efp-Eg)/(k_B*T))
% phi = Vol*sum(real(R_sp))*abs(E(2)-E(1))
%
% P = Vol*sum(E.*real(R_sp))*abs(E(2)-E(1));
%
% % exportgraphics(fig,'i_1.png','Resolution',600);

% Calculate total spontaneous emission rate
R_total = trapz(E*q, real(R_sp)); % Numerical integration over energy

% Volume in m^3
V = 0.5e-9; % 0.5 mm^3 in m^3

% Calculate photon flux
Phi = R_total / V; % Total photon flux
fprintf('Total phonon flux for the LED: %e 1/s \n',Phi)



% Save the plot as a PNG file
saveas(gcf, 'C:\SPB_Data\EEE460_Jan2024_byakc\Exp3_BYAKC\reportprepare\partA_task2.png');